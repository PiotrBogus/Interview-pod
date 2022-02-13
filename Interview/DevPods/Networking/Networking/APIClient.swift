import Foundation
import Combine

public struct APIClient {
    public var baseURL: String!
    public var networkDispatcher: NetworkDispatcher!
    
    public init(
        baseURL: String,
        networkDispatcher: NetworkDispatcher = NetworkDispatcher()
    ) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }
    
    public func dispatch<Request: HTTPRequest>(_ request: Request) -> AnyPublisher<Request.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            return Fail(outputType: Request.ReturnType.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        
        let requestPublisher: AnyPublisher<Request.ReturnType, NetworkRequestError> = networkDispatcher.dispatch(request: urlRequest, decoder: request.decoder)
        return requestPublisher.eraseToAnyPublisher()
    }
}
