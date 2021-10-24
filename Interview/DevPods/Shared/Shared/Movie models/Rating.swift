
import Foundation

public struct Rating: Codable, Hashable {
    
    public static func == (lhs: Rating, rhs: Rating) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    public let identifier = UUID()

    public let source: String
    public let value: String
    
    public init(source: String, value: String) {
        self.source = source
        self.value = value
    }

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
