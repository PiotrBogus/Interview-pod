
import Foundation

public enum NetworkingError: Error {
    case jsonParseError
    case requestParseError
    case other(localizedDescription: String)
    
    public var readableError: String {
        switch self {
        case .other(let desc):
            return desc
            
        default:
            return "Please try again later"
        }
    }
}
