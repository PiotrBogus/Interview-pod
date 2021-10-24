
import Foundation
import Utils

enum HttpMethod: String {
    case get = "GET"
}

public struct CallableEndoint {
    
    public enum RequestType {
        case get(args: [String: String])
    }
    
    var endpoint: String
    var type: RequestType
    
    private let launchArguments: [UITestLaunchArguments]
    
    public init(endpoint: String, type: RequestType, launchArguments: [String] = ProcessInfo.processInfo.arguments) {
        self.endpoint = endpoint
        self.type = type
        self.launchArguments = launchArguments.compactMap(UITestLaunchArguments.init)
    }
}

public extension CallableEndoint {
    
    func makeRequest(baseURL: String) -> URLRequest? {
        switch type {
        case .get(let args):
            if launchArguments.contains(.uiTestEnabled) {
                return makeGetRequestForUiTests(baseURL: baseURL, args: args, httpMethod: .get)
            } else {
                return makeGetRequest(baseURL: baseURL, args: args, httpMethod: .get)
            }
        }
    }
    
    private func makeGetRequest(baseURL: String, args: [String: String], httpMethod: HttpMethod) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = endpoint
        components.queryItems = args.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 10
        return request
    }
    
    private func makeGetRequestForUiTests(baseURL: String, args: [String: String], httpMethod: HttpMethod) -> URLRequest? {
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 10
        return request
    }
}
