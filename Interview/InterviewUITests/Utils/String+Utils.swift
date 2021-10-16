
import Foundation

// MARK: Document Type

extension String {

    enum DocumentType: String {
        case pdf, rtf, doc, docx, jpeg, jpg, png, txt, odt
    }

    func fileManagerName(for type: DocumentType) -> String { appending(".\(type.rawValue)") }

    func documentPickerName(for type: DocumentType) -> String { appending(", \(type.rawValue)") }
}

//

// MARK: User Credentials

extension String {

    static let email = "test@google.com"
    static let privateRelayEmail = "test@privaterelay.appleid.com"
    static let password = "test123!"

    static let firstName = "firstNameTest"
    static let lastName = "lastNameTest"

    var capitalizedFirstLetter: String {
        prefix(1).capitalized + dropFirst()
    }

    func substring(regex: String) -> String? {
        guard let range = range(of: regex, options: .regularExpression) else { return nil }

        return String(self[range])
    }
}

extension Optional where Wrapped == String {

    var boolValue: Bool {
        if let value = self {
            return Bool(value) ?? false
        }

        return false
    }
}
