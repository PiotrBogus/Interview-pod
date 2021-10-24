
import Foundation

enum HttpMethod: String {
    case get = "GET"
}

public struct CallableEndoint {
    
    public enum RequestType {
        case get(args: [String: String])
    }
    
    var endpoint: String
    var type: RequestType
    
    public init(endpoint: String, type: RequestType) {
        self.endpoint = endpoint
        self.type = type
    }
}

public extension CallableEndoint {
    
    func makeRequest(baseURL: String) -> URLRequest? {
        switch type {
        case .get(let args):
            let request = makeGetRequest(baseURL: baseURL, args: args, httpMethod: .get)
            return request
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
}
