
typealias Email = String

extension Email {

    static var existingOne: Email { .email }
    static var randomOne: Email { generateNewEmail() }
    static var wrongOne: Email { generateNewEmail(in: "ff.ff") }

    var isExisting: Bool { self == Email.existingOne }
    var isWrong: Bool { hasSuffix("ff.ff") }
    var password: String { "test123!" }

    private static func generateNewEmail(in domain: String = "mail.com") -> Email {
        let randomNumber = String(Int.random(in: 0 ... 999))
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let randomString = String((0 ... 3).compactMap { _ in letters.randomElement() })

        let newEmail = "test\(randomNumber + randomString)@\(domain)"

        return newEmail
    }
}
