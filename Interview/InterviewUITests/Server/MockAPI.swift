
@testable import Interview
import Foundation
import Utils

enum MockAPI {
    case movieList

    var files: [MockFile] {
        switch self {
        case .movieList: return [
                MockFile(path: "/movieList/.*", fileName: "movieList", usingRegex: true)
            ]
        }
    }
}
