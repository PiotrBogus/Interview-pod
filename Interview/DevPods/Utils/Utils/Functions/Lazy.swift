
public struct Lazy<A> {

    public let run: (@escaping (A) -> Void) -> Void

    public init(run: @escaping (@escaping (A) -> Void) -> Void) {
        self.run = run
    }

    public func map<B>(_ f: @escaping (A) -> B) -> Lazy<B> {
        .init { callback in run(f >>> callback) }
    }

    public func flatMap<B>(_ f: @escaping (A) -> Lazy<B>) -> Lazy<B> {
        .init { callback in run { a in f(a).run(callback) } }
    }
}

public typealias AsyncResult<A, E: Error> = Lazy<Result<A, E>>
