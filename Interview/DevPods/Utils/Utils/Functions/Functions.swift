
public func undefined(name: StaticString = #function) -> Never {
    fatalError("\(name) should be implemented.")
}

public func undefined<T>(name: StaticString = #function) -> T {
    fatalError("\(name) should be implemented.")
}

public func notNil<A>(_ array: [A?]) -> [A] {
    array.compactMap(identity)
}

public func identity<A>(_ a: A) -> A { a }

public func invoke(closure: @escaping (()) -> Void) { closure(()) }

public func firstMatch<A>(of options: Func<A, Bool>...) -> Func<A, Bool> { { a in
    a |> firstMatch(of: options)
}}

public func firstMatch<A>(of options: [Func<A, Bool>]) -> Func<A, Bool> { { a in
    for option in options {
        if option(a) {
            return true
        }
    }

    return false
}}

public func firstMatch<A, B>(of options: Func<A, B?>...) -> Func<A, B?> { { a in
    a |> firstMatch(of: options)
}}

public func firstMatch<A, B>(of options: [Func<A, B?>]) -> Func<A, B?> { { a in
    for option in options {
        if let b = option(a) {
            return b
        }
    }

    return nil
}}

public func pass<A>(_ f: @autoclosure @escaping () -> Void) -> (Lazy<A>) -> Lazy<A> { { a in
    f()

    return a
} }

public func pass<A>(_ f: @escaping () -> Void) -> (Lazy<A>) -> Lazy<A> { { a in
    pass(f())(a)
} }

public func flow<A>(_ f: ((A) -> Void)?...) -> (Lazy<A>) -> Void { { a in
    a.run { _ = ($0 |> f) }
} }

public func flow<A>(_ f: ((A) -> Void)?...) -> (A) -> Void { {
    _ = ($0 |> f)
} }

public func handleLazy<A>(_ f: @escaping (A) -> Void) -> (A) -> Lazy<A> { { a in
    .init { callback in
        f(a)
        callback(a)
    }
} }
