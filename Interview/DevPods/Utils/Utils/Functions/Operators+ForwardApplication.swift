
precedencegroup ForwardApplication {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator |>: ForwardApplication

@discardableResult
public func |> <A, B>(_ x: A, f: Func<A, B>) -> B { f(x) }

@discardableResult
public func |> <A, B>(_ x: A, f: Func<A, B>?) -> B? { f?(x) }

@discardableResult
public func |> <A, B>(_ x: A?, f: Func<A, B>) -> B? {
    guard let x = x else { return nil }

    return f(x)
}

@discardableResult
public func |> <A, B>(_ x: [A], f: Func<A, B>) -> [B] { x.map(f) }

@discardableResult
public func |> <A, B>(_ x: A, f: [Func<A, B>]) -> [B] { f.map { $0(x) } }

@discardableResult
public func |> <A, B>(_ x: A, f: [Func<A, B>?]) -> [B?] { f.map { $0?(x) } }

@discardableResult
public func |> <A, B>(f: Func<A, B>, _ x: A) -> B { f(x) }

@discardableResult
public func |> <A, B>(f: Func<A, B>?, _ x: A) -> B? { f?(x) }

@discardableResult
public func |> <A, B, C>(_ x: (A, B), f: Func2Args<A, B, C>) -> C { f(x.0)(x.1) }

@discardableResult
public func |> <A, B, C, D>(_ x: (A, B, C), f: Func3Args<A, B, C, D>) -> D { f(x.0)(x.1)(x.2) }

infix operator |>>: ForwardApplication

// use for example, for dead-end functions like (A) -> Void to pass value forward
public func |>> <A>(x: A, f: @escaping Func<A, Void>) -> A {
    f(x)

    return x
}

public func |> (f: @escaping Flow, g: @escaping Flow) -> Flow {
    { h in f { g(h) } }
}

public func |> (f: @escaping Flow, g: @escaping VoidHandler) -> Flow {
    { h in f { g(); h() } }
}

public func |> (f: @escaping VoidHandler, g: @escaping Flow) -> Flow {
    { h in f(); g(h) }
}
