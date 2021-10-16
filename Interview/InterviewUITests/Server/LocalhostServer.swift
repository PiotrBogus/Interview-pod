
import Criollo
import Utils
import Shared

protocol MockupServer {

    func add(_ file: MockFile)
}

final class LocalhostServer: MockupServer {

    private(set) var port: UInt
    private var server: CRHTTPServer?
    private var serverError: NSError?

    var url: String { "http://localhost:\(port)" }

    init() {
        port = UInt(LocalhostPort.availablePortNumber())
    }

    func add(_ file: MockFile) {
        switch file.type {
        case .js:
            add(path: file.path, jsFileName: file.fileName)
        case .html:
            add(path: file.path, htmlFileName: file.fileName, shouldAddPortToLocalhostsUrls: file.shouldAddPort)
        case .json:
            add(path: file.path,
                jsonFileName: file.fileName,
                statusCode: file.statusCode,
                shouldAddPortToLocalhostsUrls: file.shouldAddPort)
        }
    }

    private func add(path: String, jsonFileName: String, statusCode: Int = 200, shouldAddPortToLocalhostsUrls: Bool = false) {
        add(path: path) { [weak self] request, response, completionHandler in
            guard let self = self else { return }

            var data = self.getDataFromJSONFile(jsonFileName)

            if shouldAddPortToLocalhostsUrls {
                data = self.addPortToLocalhostURLs(data)
            }

            response.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-type")
            response.setStatusCode(UInt(statusCode), description: nil)
            response.send(data)
        }
    }

    private func add(path: String, htmlFileName: String, statusCode: Int = 200, shouldAddPortToLocalhostsUrls: Bool = false) {
        add(path: path) { [weak self] request, response, completionHandler in
            guard let self = self else { return }

            var responseString = self.getStringFromFile(htmlFileName, fileExtenstion: "html")

            if shouldAddPortToLocalhostsUrls {
                responseString = responseString.replacingOccurrences(of: "localhost", with: "localhost:\(self.port)")
            }

            response.setValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-type")
            response.setValue("\(responseString.lengthOfBytes(using: String.Encoding.utf8))", forHTTPHeaderField: "Content-Length")
            response.setStatusCode(UInt(statusCode), description: nil)
            response.send(responseString)
        }
    }

    private func add(path: String, jsFileName: String, statusCode: Int = 200) {
        add(path: path) { [weak self] request, response, completionHandler in
            guard let self = self else { return }

            let responseString = self.getStringFromFile(jsFileName, fileExtenstion: "js")

            response.setValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-type")
            response.setValue("\(responseString.lengthOfBytes(using: String.Encoding.utf8))", forHTTPHeaderField: "Content-Length")
            response.setStatusCode(UInt(statusCode), description: nil)
            response.send(responseString)
        }
    }

    private func add(path: String, handler: @escaping CRRouteBlock) {
        server?.replace(path, block: handler)
    }

    public func start() {
        server = CRHTTPServer()
        server?.startListening(&serverError, portNumber: port)
    }

    public func stop() {
        server?.stopListening()
    }

    private func getDataFromJSONFile(_ filename: String) -> Data {
        let jsonFilePath = getFilePath(for: filename, extension: "json")

        if let data = try? Data(contentsOf: jsonFilePath) {
            return data
        }

        fatalError("Data of JSON file is invalid, please make sure it is valid JSON file")
    }

    private func getStringFromFile(_ filename: String, fileExtenstion: String) -> String {
        let filePath = getFilePath(for: filename, extension: fileExtenstion)

        if let string = try? String(contentsOf: filePath, encoding: .utf8) {
            return string
        }

        fatalError("Data of \(filename) file is invalid, please make sure it is valid \(fileExtenstion) file")
    }

    private func getFilePath(for filename: String, extension: String) -> URL {
        guard let filePath = Bundle.uiTestsResources.url(forResource: filename, withExtension: `extension`) else {
            fatalError("Cannot find \(filename).\(`extension`) file in bundle, make sure it is added to proper targets")
        }

        return filePath
    }

    private func addPortToLocalhostURLs(_ data: Data) -> Data {
        var jsonObject: [String: Any]?

        do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            fatalError("Cannot convert data object to json")
        }

        guard jsonObject != nil else {
            fatalError("Cannot convert data object to json")
        }

        jsonObject = replace(target: "localhost", replacement: "localhost:\(port)", dictionary: jsonObject!)

        if let data = try? JSONSerialization.data(withJSONObject: jsonObject!, options: JSONSerialization.WritingOptions.prettyPrinted) {
            return data
        }

        fatalError("Data of JSON file is invalid, please make sure it is valid JSON file")
    }

    private func replace(target: String, replacement: String, dictionary: [String: Any]) -> [String: Any] {
        var newDictionary = dictionary

        for key in dictionary.keys {
            if let nestedDictionary = dictionary[key] as? [String: Any] {
                newDictionary[key] = replace(target: target,
                                             replacement: replacement,
                                             dictionary: nestedDictionary)
            } else if let stringValue = dictionary[key] as? String, stringValue.contains(target) {
                let newStringValue = stringValue.replacingOccurrences(of: target, with: replacement)
                newDictionary[key] = newStringValue
            }
        }

        return newDictionary
    }

    private enum LocalhostPort {

        public static func availablePortNumber() -> UInt16 {
            for i in 50000 ..< 65000 {
                let (isFree, _) = checkTcpPortForListen(port: UInt16(i))
                if isFree == true {
                    return UInt16(i)
                }
            }

            return 0
        }

        static func checkTcpPortForListen(port: in_port_t) -> (Bool, descr: String) {
            let socketFileDescriptor = socket(AF_INET, SOCK_STREAM, 0)
            if socketFileDescriptor == -1 {
                return (false, "SocketCreationFailed, \(descriptionOfLastError())")
            }

            var addr = sockaddr_in()
            let sizeOfSockkAddr = MemoryLayout<sockaddr_in>.size
            addr.sin_len = __uint8_t(sizeOfSockkAddr)
            addr.sin_family = sa_family_t(AF_INET)
            addr.sin_port = Int(OSHostByteOrder()) == OSLittleEndian ? _OSSwapInt16(port) : port
            addr.sin_addr = in_addr(s_addr: inet_addr("0.0.0.0"))
            addr.sin_zero = (0, 0, 0, 0, 0, 0, 0, 0)
            var bind_addr = sockaddr()
            memcpy(&bind_addr, &addr, Int(sizeOfSockkAddr))

            if Darwin.bind(socketFileDescriptor, &bind_addr, socklen_t(sizeOfSockkAddr)) == -1 {
                let details = descriptionOfLastError()
                release(socket: socketFileDescriptor)

                return (false, "\(port), BindFailed, \(details)")
            }
            if listen(socketFileDescriptor, SOMAXCONN) == -1 {
                let details = descriptionOfLastError()
                release(socket: socketFileDescriptor)

                return (false, "\(port), ListenFailed, \(details)")
            }
            release(socket: socketFileDescriptor)

            return (true, "\(port) is free for use")
        }

        static func release(socket: Int32) {
            Darwin.shutdown(socket, SHUT_RDWR)
            close(socket)
        }

        static func descriptionOfLastError() -> String {
            String(cString: UnsafePointer(strerror(errno)))
        }
    }
}
