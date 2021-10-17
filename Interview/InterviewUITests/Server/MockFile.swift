
struct MockFile: Hashable {

    enum FileType: Equatable {
        case js, html, json
    }

    var path: String
    var fileName: String
    var shouldAddPort = false
    var type = FileType.json
    var statusCode = 200
    var usingRegex = false

    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
}
