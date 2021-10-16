
import Utils
import Shared

struct FeatureConfiguration: Hashable {

    let id: String
    let configuration: [Feature: Bool]
    let api: [MockFile]

    init() {
        self.init(configuration: [:], apiFiles: [])
    }

    /// You should modify predefined configurations using `feature`, `api` functions.
    /// It is important to keep the same `id` for each feature.
    init(id: String = UUID().uuidString, configuration: [Feature: Bool], apiFiles: [MockFile] = []) {
        self.id = id
        self.configuration = configuration
        api = apiFiles
    }

    init(apis: MockAPI...) {
        self.init(configuration: [:], apiFiles: apis.flatMap(\.files))
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func features(_ features: [Feature]) -> FeatureConfiguration {
        configuration(.init(uniqueKeysWithValues: features.map { ($0, true) }))
    }

    func configuration(_ features: [Feature: Bool]) -> FeatureConfiguration {
        .init(id: id, configuration: configuration + features, apiFiles: api)
    }

    func api(_ api: MockAPI) -> FeatureConfiguration {
        self.api(files: api.files)
    }

    func apis(_ apis: [MockAPI]) -> FeatureConfiguration {
        api(files: apis.flatMap(\.files))
    }

    func api(files: [MockFile]) -> FeatureConfiguration {
        .init(id: id, configuration: configuration, apiFiles: api + files)
    }
}

func == (lhs: FeatureConfiguration, rhs: FeatureConfiguration) -> Bool { lhs.id == rhs.id }

func + <Element>(lhs: Set<Element>, rhs: [Element]) -> Set<Element> {
    rhs.reduce(into: lhs) { set, value in set.update(with: value) }
}
