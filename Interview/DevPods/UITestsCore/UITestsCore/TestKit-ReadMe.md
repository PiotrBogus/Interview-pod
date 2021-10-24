# Things To Do & Discuss
#### Write your thoughts & problem met during development and let's talk about it!
- Applitools --> should we reuse UI tests or write new one?
- Renaming --> Steps -> Action, Paths -> Step
<br/>

#  Overview
### Quick overview of our UITest architecture.

<br/>

# Tests
## Base Test
Replacement for `LegacyBaseTest`.<br/>
The main reason the `BaseTest` was created to get rid of all things related to the old way of writing UITests, like `Screens`.<br/>
It also helped to split responsibilities and make it more lightweight.
The `BaseTest` is consists of:
- `FeatureController`
- `SnapshotController`
- `PathsFactory`

## Test Case Configuration
Two protocols `TestCaseConfigurable` & `TestCaseAPIConfigurable` can help you configure your tests.<br/>
The idea behind those protocols is `to map the NAME of the test to SOME enum case`.

`TestCaseConfigurable` should be used when you want to map to some special options / feature.
```swift
protocol TestCaseConfiguration: CaseIterable, RawRepresentable where RawValue == String {}

protocol TestCaseConfigurable: BaseTest {
    associatedtype Configuration: TestCaseConfiguration
}
```

`TestCaseAPIConfigurable` should be used when you want to map to specific api, for example `empty result list` or `list with recommendations` etc.
```swift
protocol TestCaseAPIConfiguration: TestCaseConfiguration {
    var api: [MockAPI] { get }
}

protocol TestCaseAPIConfigurable: BaseTest {
    associatedtype API: TestCaseAPIConfiguration
}
```

### Usage
How the mapping works:<br/>
It iterates over all cases and transfer it by capitalising the first letter `magicLink` -> `MagicLink`, then checking whether the test’s name contains the case.<br/>
It collects all suitable cases, then you can map them to `api` using `testCaseApi` or your own like `launchArgument`.
```swift
ResultListTests & ZeroResultsListTests

# API & Configuration
enum API: String, TestCaseAPIConfiguration {
    case emptyList, withRecommendations, jobsSynchronization

    var api: [MockAPI] {
        switch self {
        case .emptyList:
            return [.emptySearch]
        case .withRecommendations:
            return [.userRecommendations()]
        case .jobsSynchronization:
            return [.applications]
        }
    }
}

enum Configuration: String, TestCaseConfiguration {
    case zeroResultsRecommendations
    case userIsLoggedIn
    case magicLink
    case jobsSynchronization

    var launchArgument: UITestLaunchArguments? {
        [.jobsSynchronization, .userIsLoggedIn].contains(self) ? .userLoggedIn : nil
    }
}

# Test
func test_ZeroResultsRecommendations_WithRecommendations_AreStillVisibleOn_EmptyList_AfterLoginAndLogoutWith_MagicLink()

# Where is it used?
override func setUpCustomFeatures(on controller: FeatureController) {
    controller
        .launchArguments(testCaseConfiguration.compactMap(\.launchArgument))
        .update(features: [.resultList.apis(testCaseAPI)])
}
```
`OnboardingTests` can serve you as another example.


# Features
We want our features to be as close to real app as possible (needed especially for managing Applitools), 
that's why the way how we enable/disable features were changes.<br/>
Currently, we should tweak features only in special cases, like turning off the onboarding/analytics, example `ResultListTests`.

## Feature Controller
The controller is responsible for setting up `feature environment`.<br/>
Things you need to control a feature:
- to indicate for a feature availability
- to mock server responses related to a feature
- set up app custom flags, like `analytics`

The controller manages:
- adding, removing, checking existence of a feature configuration
- adding, removing launch arguments

## Feature Configuration
The idea with `FeatureConfiguration` is to have features grouped by their domains, ResultList, Profile, Login, Onboarding (In progress!)<br/>
This way, we can slim down a `MockAPI enum` because currently, it is a bag of all apis.<br/>
In the future, it will significantly simplify moving them to modules.

### Note
#### !!! Important !!! Each configuration is identified by its `id`, which is why you should reuse or change earlier defined configuration.
The predefined configurations you can find in a `FeatureConfiguration+Predefined.swift`.<br/>
Currently it is copy pasted from old solution and should be changed.

### Usage
```swift
ResultListTests

override func setUpCustomFeatures(on controller: FeatureController) {
    controller
        .launchArguments(testCaseConfiguration.compactMap(\.launchArgument))
        .update(features: [.resultList.apis(testCaseAPI)])
}

private extension FeatureConfiguration {

    static let resultList = FeatureConfiguration(configuration: [.onboarding: false])
}
```


# Applitools
Due to the need for a reduction of the number of snapshots, we need to define what pages can take them.

#### Disclaimer
From now, snapshot and snapshooter terms will be used, because it is implemented in a way that enables use in an easy way to change a mechanism of taking snapshots.


## Snapshot Controller
The `SnapshotController` controls what pages can take snapshots and provide a way how to define them.
The controller contains of:
- `snapShooter` 
- `allowedPages`
- `append(allowedPages:)`

The controller is used in `extensions SnapshotSteps` where the page is checked if it is allowed.

```swift
extension SnapshotSteps {

    private var isSnapshotAllowed: Bool {
        factory.snapshotController?.isAllowed(page: page, in: factory) ?? true
    }
    ...
}
```

### Note
To simplify indicating pages that can take snapshots an operator `^` was introduced.<br/> 
The operator imitates `KeyPaths`.<br/> 
The `KeyPath` cannot be used because it doesn't work with protocols, for example, `\PageFactory.resultList returns KeyPath<PageFactory, ResultList>`<br/>
A declaration of `^` operator<br/>
`prefix func ^ <P: Page>(_ kp: KeyPath<PageFactory, P>) -> (PageFactory) -> Page`

## Usage
In `makeSnapshotController` you indicate pages that can take snapshots.
```swift
OnboardingApplitoolsTests

override func makeSnapshotController() -> SnapshotController? {
    .applitools(test: self)
        .append(allowedPages: ^\.onboarding, ^\.autosuggestWithSkills, ^\.autosuggest)
}
```
A predefined controllers can be found in `SnapshotController+Predefiend.swift`

# Identification of elements

## Element Identifier
An element identifier is a pair of value that are used to identify an element on view.
```swift
public struct ElementIdentifier {

    public var id: String           // element identifier
    public var type: ElementType    // element type: button, staticText, image, etc.
}

extension XCUIElement {
    subscript(element id: ElementIdentifier) -> XCUIElement

    subscript(query id: ElementIdentifier) -> XCUIElementQuery

    // partial is used if you want to get elements that CONTAINS part of identifier -> JobListPage.cellSaveButtons
    subscript(query id: ElementIdentifier, partial partial: Bool) -> XCUIElementQuery 
}

extension XCUIElementQuery {
    subscript(element id: ElementIdentifier) -> XCUIElement

    subscript(query id: ElementIdentifier) -> XCUIElementQuery

    subscript(query id: ElementIdentifier, partial partial: Bool) -> XCUIElementQuery
}

extension XCUIApplication {
    subscript(textField id: ElementIdentifier) -> TextFieldPage
}
```
Look at
- `ElementIdentifier`
- `ElementIdentifier+Predefined.swift`
- `ElementIdentifier+Utils.swift`

### Usage
#### !! Important  !! You need to invoke getting an element on its `parent` in the view hierarchy, not on an element on the level.
```swift
✅ Correct
var button: XCUIElement { screen[element: id.button] }

❌ Incorrect
var button: XCUIElement { screen.buttons[element: id.button] }
```

#### More examples
- OnboardingPage, JobListPage


# Page, Step, Path Factories
Each type has its own `Factory` that contains all available elements of a particular type.
Factories:
- `PageFactory`
- `StepsFactory`
- `PathsFactory`

# Pages, Steps, Paths & their roles
## Page
A page is an object defining elements of a particular view.

### Base
```swift
public protocol Page: AnyObject {
    var id: String { get }
    var type: XCUIElement.ElementType { get }
    ...
}
public extension Page {

    var type: XCUIElement.ElementType { .any }
    var screen: XCUIElement {
        let elements = app.descendants(matching: type)

        return id.isEmpty ? elements.firstMatch : elements[id].firstMatch
    }
}
```
Those are the most important properties of a page.<br/> 
An `id` and a `type` are used to identify a `screen`.<br/>
The `screen` property is used for methods like `waitForAppearance/Disappearance`.

### Helper methods to operate on page's elements
A page defines set of helper methods which are used to simplify actions on `XCUIElement` and `XCUIElementQuery`
Kinds of helper methods:
- Tap an element
- Type a text
- Pick an element from set of elements (`XCUIElementQuery`) via index, predicate, identifier
- Verify an element via predicate 
- Other actions, like swipe/pan up/down

#### Note
A `Predicate` is a set of states that you may want to verify on an element.<br/>
For example, is an element hittable, exists, does not exists, check label text, etc.

### Snapshot
A `SnapshotPage` is a extended version of `Page`.
```swift
protocol SnapshotPage: Page {
    var snapShooter: SnapShooter? { get }

    var ignoredElements: [XCUIElement] { get }
}
```
It defines additional requirements that a page must meet if it wants to take snapshots.<br/>
Only the first one, `snapShooter`, is required.

#### Examples:
- OnboardingPage
- AlertPage
- ProfilePage
- ResultListPage

## Steps
A step is an object defining actions on pages.

### Base
Each step has its corresponding page. `OnboardingSteps -> OnboardingPage`
```swift

protocol Steps: AnyObject {
    associatedtype PageType: Page

    var page: PageType { get }
    var factory: PageFactory { get }
}
```

### Tracking
```swift
protocol ValidationSteps: Steps {
    var validator: TrackingValidator? { get }
}

protocol AnalyticsValidatorParameters {
    static var type: AnalyticsParameterType { get }

    var name: String { get }
    var contextData: [String: String?]? { get }
}
```
We are supporting `SiteCatalyst State & Action` and `Adjust`tracks.<br/>
Each of them has a protocol that requires a namespace defined at `associatedType` that should contain all tracks of a particular kind.<br/>
Track's parameters defined by the `AnalyticsValidatorParameters`  protocol:<br/>
- type - is a variable to determine what is it - `action`, `state`, `adjust`
- name - track name
- contextData - optional, parameters send with track

State
```swift
protocol SiteCatalystStateValidationSteps: ValidationSteps {
    associatedtype TrackingState: AnalyticsValidatorParameters
}

extension SiteCatalystStateValidationSteps {
    func validateState(_ param: TrackingState, _ file: StaticString, _ line: UInt) -> Self
}
```

Action
```swift
protocol SiteCatalystActionValidationSteps: ValidationSteps {
    associatedtype TrackingAction: AnalyticsValidatorParameters
}

extension SiteCatalystActionValidationSteps {
    func validateAction(_ param: TrackingAction, _ file: StaticString, _ line: UInt) -> Self {
}
```

Adjust
```swift
protocol AdjustValidationSteps: ValidationSteps {
    associatedtype TrackingAdjust: AnalyticsValidatorParameters
}

extension AdjustValidationSteps {
    func validateAdjust(_ param: TrackingAdjust, _ file: StaticString, _ line: UInt) -> Self
}
```

#### Usage 
```swift
extension MagicLinkSteps {

    enum TrackingAction: AnalyticsValidatorParameters {
        static let type: AnalyticsParameterType = .action

        case checkMailbox
        case typePassword
        case changeEmail

        var name: String {
            let trackingProvider = UITestsTrackingValueProvider.build()
            switch self {
            case .checkMailbox: return trackingProvider.magicLinkCheckMailboxClick
            case .typePassword: return trackingProvider.magicLinkTypePasswordClick
            case .changeEmail: return trackingProvider.magicLinkChangeEmailClick
            }
        }
    }

    enum TrackingState: AnalyticsValidatorParameters {
        static let type: AnalyticsParameterType = .state

        case magicLinkViewDidAppear

        var name: String {
            let trackingProvider = UITestsTrackingValueProvider.build()
            switch self {
            case .magicLinkViewDidAppear: return trackingProvider.magicLinkConfirmationPage
            }
        }
    }
}
```
More advanced examples:<br/>
LoginSteps, ResultListSteps, ListingDetailsSteps


### Snapshot
Similar to tracks, snapshots have their protocol with their namespace `SnapshotName`.
Snapshot parameters defined by the `SnapshotValue` protocol:
- id - is used during initialization. A template looks like this - `<id> - <test name>`
- name - describes a concrete screen snapshot.
```swift
protocol SnapshotSteps: Steps where PageType: SnapshotPage {
    associatedtype SnapshotName: SnapshotValue
}

extension SnapshotSteps {
    func initializeSnapshot(name: String) -> Self
    func takeSnapshot(_ name: SnapshotName) -> Self
}

protocol SnapshotValue {
    static var id: String { get }
    var name: String { get }
```

#### Usage
```swift
extension HomeSteps {

    enum SnapshotName: SnapshotValue {

        static let id = "Home"

        case view
        case search

        var name: String {
            switch self {
            case .view:
                return "Home"
            case .search:
                return "Home - search action"
            }
        }
    }
}
```
More examples:<br/>
OnboardingSteps, ResultListSteps, LoginSteps


## Paths
A path is an object defining set of steps (actions) on steps as one unit. <br/>
For example: tap a button, send tracking, take snapshot.

### Base
Each step has its corresponding page. `OnboardingPaths -> OnboardingSteps`
```swift
protocol Paths: AnyObject {
    associatedtype StepsType: Steps

    var steps: StepsType { get }
    var factory: StepsFactory { get }
}
```

# Elements' validation

## Element Validator

## Verifiable Element





