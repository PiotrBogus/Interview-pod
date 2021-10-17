
import Utils
import XCTest

typealias TestConfigurable = TestCaseConfigurable & TestCaseAPIConfigurable

protocol TestCaseConfiguration: CaseIterable, RawRepresentable where RawValue == String {}

protocol TestCaseConfigurable: BaseTest {
    associatedtype Configuration: TestCaseConfiguration
}

extension TestCaseConfigurable {

    var testCaseConfiguration: [Configuration] { Configuration.allCases.filter(contains) }
}

protocol TestCaseAPIConfiguration: TestCaseConfiguration {
    var api: [MockAPI] { get }
}

protocol TestCaseAPIConfigurable: BaseTest {
    associatedtype API: TestCaseAPIConfiguration
}

extension TestCaseAPIConfigurable {

    var testCaseAPI: [MockAPI] {
        API.allCases.filter(contains) |> map(\API.api) >>> flatMap(identity)
    }
}

/// Arguments are set inside Scheme -> Tests -> Arguments
enum TestEnvironmentArgument: String {
    case analytics

    var argument: String? { ProcessInfo.processInfo.environment[rawValue] }

    var boolValue: Bool { argument.boolValue }
    var stringValue: String { argument ?? "" }
}
