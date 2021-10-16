
protocol MockupServerPaths: Paths {
    var mockupServer: MockupServer { get }
}

extension MockupServerPaths {

    @discardableResult
    func mockResponse(_ api: MockAPI) -> Self {
        api.files.forEach(mockupServer.add)

        return self
    }

    @discardableResult
    func mockResponse(_ files: [MockFile]) -> Self {
        files.forEach(mockupServer.add)

        return self
    }
}
