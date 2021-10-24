
// MARK: Side effect

precedencegroup EffectfulComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator >=>: EffectfulComposition

public func >=> <A, B>(_ a: Lazy<A>, _ f: @escaping (A) -> B) -> Lazy<B> { a.map(f) }

public func >=> <A, B>(_ a: Lazy<A>, _ f: @escaping (A) -> Lazy<B>) -> Lazy<B> { a.flatMap(f) }

public func >=> <A>(_ a: Lazy<A>, _ f: @escaping (A) -> Void) { a.run(f) }

public func >=> <A, B>(_ a: Lazy<A>?, _ f: ((A) -> B)?) -> (Lazy<B>)? {
    guard let f = f else { return nil }

    return a?.map(f)
}

public func >=> <A, B>(_ a: Lazy<A>?, _ f: ((A) -> Lazy<B>)?) -> (Lazy<B>)? {
    guard let f = f else { return nil }

    return a?.flatMap(f)
}

public func >=> <A>(_ a: Lazy<A>?, _ f: ((A) -> Void)?) {
    guard let f = f else { return }

    a?.run(f)
}

// MARK: Forward

precedencegroup Composition {
    associativity: left
    higherThan: EffectfulComposition
}

infix operator >>>: Composition

public func >>> <A, B, C>(_ f: @escaping Func<A, B>, _ g: @escaping Func<B, C>) -> Func<A, C> { { a in g(f(a)) } }

// MARK: Backward

infix operator <<<: Composition

public func <<< <A, B, C>(_ f: @escaping Func<B, C>, _ g: @escaping Func<A, B>) -> Func<A, C> { { a in f(g(a)) } }

// MARK: Single type composition

precedencegroup SingleTypeComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator <>: SingleTypeComposition

public func <> <A>(f: @escaping IdentityFunc<A>, g: @escaping IdentityFunc<A>) -> IdentityFunc<A> { f >>> g }

public func <> <A: AnyObject>(f: @escaping Handler<A>, g: @escaping Handler<A>) -> Handler<A> { { a in
    f(a)
    g(a)
} }
