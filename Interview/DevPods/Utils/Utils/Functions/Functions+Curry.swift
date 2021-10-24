
public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> Func2Args<A, B, C> { { a in { b in f(a, b) } } }
public func curry<A, B, C>(_ f: ((A, B) -> C)?) -> Func2Args<A, B, C?> { { a in { b in f?(a, b) } } }
public func curry<A, B>(_ f: ((A, B) -> Void)?) -> Func2Args<A, B, Void> { { a in { b in f?(a, b) } } }
public func curry<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> Func3Args<A, B, C, D> { { a in { b in { c in f(a, b, c) } } } }
public func curry<A, B, C, D, E>(_ f: @escaping (A, B, C, D) -> E) -> Func4Args<A, B, C, D, E> { { a in { b in { c in { d in f(a, b, c, d) } } } } }
public func curry<A, B, C, D, E, F>(_ f: @escaping (A, B, C, D, E) -> F) -> Func5Args<A, B, C, D, E, F> { { a in { b in { c in { d in { e in f(a, b, c, d, e) } } } } } }
public func curry<A, B, C, D, E, F, G>(_ fun: @escaping (A, B, C, D, E, F) -> G) -> Func6Args<A, B, C, D, E, F, G> { { a in { b in { c in { d in { e in { f in fun(a, b, c, d, e, f) } } } } } } }
public func curryFirst<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B, C) -> D { { a in uncurry(curry(f)(a)) } }

// Revert func arguments' order
public func flip<A, C>(_ f: @escaping (A) -> () -> C) -> () -> (A) -> C { { { a in f(a)() } } }
public func flip<A, C>(_ f: ((A) -> () -> C)?) -> () -> (A) -> C? { { { a in f?(a)() } } }
public func flip<A, B, C>(_ f: @escaping Func2Args<A, B, C>) -> Func2Args<B, A, C> { { b in { a in f(a)(b) } } }
public func flip<A, B, C>(_ f: Func2Args<A, B, C>?) -> Func2Args<B, A, C?> { { b in { a in f?(a)(b) } } }
public func flip<A, B, C, D>(_ f: @escaping Func3Args<A, B, C, D>) -> Func3Args<C, B, A, D> { { c in { b in { a in f(a)(b)(c) } } } }
public func flip<A, B, C, D, E>(_ f: @escaping Func4Args<A, B, C, D, E>) -> Func4Args<D, C, B, A, E> { { d in { c in { b in { a in f(a)(b)(c)(d) } } } } }

public func flipCurry<A, B, C>(_ f: @escaping (A, B) -> C) -> Func2Args<B, A, C> { flip(curry(f)) }
public func flipCurry<A, B, C>(_ f: ((A, B) -> C)?) -> Func2Args<B, A, C?> { flip(curry(f)) }
public func flipCurry<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> Func3Args<C, B, A, D> { flip(curry(f)) }
public func flipCurry<A, B, C, D, E>(_ f: @escaping (A, B, C, D) -> E) -> Func4Args<D, C, B, A, E> { flip(curry(f)) }

public func uncurry<A, B, C>(_ f: @escaping Func2Args<A, B, C>) -> (A, B) -> C { { a, b in f(a)(b) } }
public func uncurry<A, B, C, D>(_ f: @escaping Func3Args<A, B, C, D>) -> (A, B, C) -> D { { a, b, c in f(a)(b)(c) } }
public func uncurry<A, B, C, D, E>(_ f: @escaping Func4Args<A, B, C, D, E>) -> (A, B, C, D) -> E { { a, b, c, d in f(a)(b)(c)(d) } }
public func uncurry<A, B, C, D, E, F>(_ f: @escaping Func5Args<A, B, C, D, E, F>) -> (A, B, C, D, E) -> F { { a, b, c, d, e in f(a)(b)(c)(d)(e) } }
public func uncurry<A, B, C, D, E, F, G>(_ fun: @escaping Func6Args<A, B, C, D, E, F, G>) -> (A, B, C, D, E, F) -> G { { a, b, c, d, e, f in fun(a)(b)(c)(d)(e)(f) } }
