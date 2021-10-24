
final class MovieListPaths: MockupServerPaths {

    let mockupServer: MockupServer
    let factory: StepsFactory
    var steps: MovieListSteps { factory.movieList }

    init(factory: StepsFactory, mockupServer: MockupServer) {
        self.factory = factory
        self.mockupServer = mockupServer
    }

    @discardableResult
    func searchMovie(file: StaticString = #file, line: UInt = #line) -> Self {
        steps
            .waitForAppearance(file: file, line: line)
            .fillSearchField(with: "Marvel", file: file, line: line)

        return self
    }
}
