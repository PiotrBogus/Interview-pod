//
//@testable import Interview
//import Utils
//import XCTest
//
//class ResultListTests: BaseTest {
//
//    lazy var resultList = resultListPaths
//    lazy var home = pathsFactory.home
//    lazy var autosuggest = pathsFactory.autosuggest
//    lazy var login = pathsFactory.login
//    lazy var settings = pathsFactory.settings
//
//    var numberOfJobsToSave: Int { 2 }
//    var resultListPaths: ResultListPaths { pathsFactory.resultList }
//
//    override func setUpCustomFeatures(on controller: FeatureController) {
//        controller
//            .update(launchArguments: testCaseConfiguration.compactMap(\.launchArgument))
//            .update(features: [.resultList.apis(testCaseAPI)])
//    }
//
//    func test_PresentResultList_MakeNewSearch() {
//        startWithResultList()
//
//        performSearch(for: .iOS)
//
//        resultList
//            .verifyList(option: .iOS)
//    }
//
//    func test_PresentResultList_EmptyList() {
//        startWithEmptyResultList()
//    }
//
//    func test_SavedJobs_ShouldBeSelected_WhenReturnOnResultList() {
//        startWithResultList()
//            .saveJobs(identifiers: Array(JobList.jobIdentifiers[0 ..< numberOfJobsToSave]))
//
//        performSearch()
//
//        resultList
//            .verifySavedJobs(count: numberOfJobsToSave)
//    }
//
//    func test_ExtendedResults_ShouldBeVisible_AfterLoadMore() {
//        startWithResultList()
//            .loadMore(of: .iOS)
//    }
//
//    @discardableResult
//    func startWithResultList(file: StaticString = #file, line: UInt = #line) -> ResultListPaths {
//        resultList
//            .start(file: file, line: line)
//            .verifyList(source: .fromRecentSearches, file: file, line: line)
//    }
//
//    @discardableResult
//    func startWithEmptyResultList(file: StaticString = #file, line: UInt = #line) -> ResultListPaths {
//        resultList
//            .start(file: file, line: line)
//            .verifyEmptyList(file: file, line: line)
//    }
//
//    func performSearch(for option: SearchAPIOption = .all, file: StaticString = #file, line: UInt = #line) {
//        resultList
//            .showHome(file: file, line: line)
//
//        home
//            .start(file: file, line: line)
//            .verifyView(file: file, line: line)
//
//        fillWhatWhere(option: option, file: file, line: line)
//
//        home
//            .performSearch(for: option, file: file, line: line)
//    }
//
//    private func fillWhatWhere(option: SearchAPIOption, file: StaticString, line: UInt) {
//        guard option != .all else { return }
//
//        fillWhat(file: file, line: line)
//        fillWhere(file: file, line: line)
//    }
//
//    private func fillWhat(file: StaticString, line: UInt) {
//        home.openWhatField(file: file, line: line)
//
//        if featureController.contains(feature: .autosuggest) {
//            autosuggest.typeText(.jobTitle, usage: .what(), file: file, line: line)
//        } else {
//            home.typeWhat(.jobTitle, file: file, line: line)
//        }
//    }
//
//    private func fillWhere(file: StaticString, line: UInt) {
//        if featureController.contains(feature: .locations) {
//            home.openLocation(file: file, line: line)
//            autosuggest.selectLocation(file: file, line: line)
//        } else {
//            home.openWhereField(file: file, line: line)
//            autosuggest.typeText(.jobLocation, usage: .where(), file: file, line: line)
//        }
//    }
//}
//
//private extension FeatureConfiguration {
//
//    static let resultList = FeatureConfiguration(configuration: [.onboarding: false])
//}
//
//extension ResultListTests: TestConfigurable {
//
//    enum API: String, TestCaseAPIConfiguration {
//        case emptyList, withRecommendations, jobsSynchronization
//
//        var api: [MockAPI] {
//            switch self {
//            case .emptyList:
//                return [.emptySearch]
//            case .withRecommendations:
//                return [.userRecommendations()]
//            case .jobsSynchronization:
//                return [.applications]
//            }
//        }
//    }
//
//    enum Configuration: String, TestCaseConfiguration {
//        case zeroResultsRecommendations
//        case userIsLoggedIn
//        case magicLink
//        case jobsSynchronization
//
//        var launchArgument: UITestLaunchArguments? {
//            [.jobsSynchronization, .userIsLoggedIn].contains(self) ? .userLoggedIn : nil
//        }
//    }
//}
