
final class IntroPaths: MockupServerPaths {

    let mockupServer: MockupServer
    let factory: StepsFactory
    var steps: IntroSteps { factory.intro }

    init(factory: StepsFactory, mockupServer: MockupServer) {
        self.factory = factory
        self.mockupServer = mockupServer
    }

    @discardableResult
    func enterMovieList(file: StaticString = #file, line: UInt = #line) -> Self {
        steps
            .waitForAppearance(file: file, line: line)
            .tapEnterButton(file: file, line: line)
            .verifyMovieListAppeard(file: file, line: line)

        return self
    }

    @discardableResult
    func enterWebsite(file: StaticString = #file, line: UInt = #line) -> Self {
        steps
            .waitForAppearance(file: file, line: line)
            .tapWebsiteButton(file: file, line: line)

        return self
    }
}
