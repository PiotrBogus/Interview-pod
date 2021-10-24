
import Foundation
import Shared
import Utils
import Combine

public protocol NetworkCancellable {
    func cancel()
}

extension URLSessionDataTask: NetworkCancellable {}

final class APICall<Response: Codable> {
    
    typealias Completion = (Result<Response,NetworkingError>) -> Void
    
    private let session: URLSession
    
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func call(baseURL: String, endpoint: CallableEndoint, completion: @escaping Completion) -> AnyCancellable? {
        guard let request = endpoint.makeRequest(baseURL: baseURL) else {
            Logger.error("Failed to make URL Request for endpoint: \(endpoint.endpoint)")
            completion(.failure(.requestParseError))
            return nil
        }
        
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap{ element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          Logger.error("Bad request")
                          throw URLError(.badServerResponse)
                      }
                
                return element.data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { receivedCompletion in
                switch receivedCompletion {
                case .failure(let error):
                    completion(.failure(.jsonParseError))
                    Logger.error("Networking error: \(error.localizedDescription)")
                case .finished:
                    ()
                }
            },
                  receiveValue: { value in
                completion(.success(value))
            })
        
        return publisher
    }
}
