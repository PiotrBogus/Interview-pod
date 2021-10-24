
public func map<A, B>(_ f: @escaping Func<A, B>) -> Func<A, B> { { a in f(a) } }
public func map<A, B>(_ f: @escaping Func<A, B>) -> Func<[A], [B]> { { a in a.map(f) } }
public func map<A, B>(_ keyPath: KeyPath<A, B>) -> Func<A, B> { { a in a[keyPath: keyPath] } }
public func map<A, B>(_ keyPath: KeyPath<A, B>) -> Func<[A], [B]> { { a in a.map { $0[keyPath: keyPath] } } }

public func compactMap<A, B>(_ f: @escaping Func<A, B?>) -> Func<[A], [B]> { { a in a.compactMap(f) } }
public func compactMap<A, B>(_ keyPath: KeyPath<A, B?>) -> Func<[A], [B]> { { a in a.compactMap { $0[keyPath: keyPath] } } }

public func flatMap<A, B>(_ f: @escaping Func<A, [B]>) -> Func<[A], [B]> { { a in a.flatMap(f) } }

public func filter<A>(_ f: @escaping Func<A, Bool>) -> Func<A, A?> { { a in f(a) ? a : nil } }

public func filter<A>(_ f: @escaping Func<A, Bool>) -> Func<[A], [A]> { { a in a.filter(f) } }

public func forEach<A>(_ f: @escaping Handler<A>) -> Handler<[A]> { { a in a.forEach(f) } }
