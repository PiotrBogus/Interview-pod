
import Foundation
import Utils
import Shared

struct BaseUrlBuilder {
    
    private let arguments: [UITestLaunchArguments]
    
    var baseURL: String {
        guard arguments.contains(.uiTestEnabled) else {
            return String.baseURL
        }
        
        return uiTestMockupURLString!
    }
    
    private var uiTestMockupURLString: String? {
        let environment = ProcessInfo.processInfo.environment
        
        return environment[UITestLaunchArguments.mockupUrl.rawValue]
    }
    
    public init(launchArguments: [String] = ProcessInfo.processInfo.arguments) {
        arguments = launchArguments.compactMap(UITestLaunchArguments.init)
    }
}
