
import Foundation

public struct MovieList: Codable {
    
    public var movies: [Movie]
    public let totalResults: String
    public let response: String
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
    
    public init(totalResults: String, response: String, movies: [Movie]) {
        self.totalResults = totalResults
        self.response = response
        self.movies = movies
    }
}
