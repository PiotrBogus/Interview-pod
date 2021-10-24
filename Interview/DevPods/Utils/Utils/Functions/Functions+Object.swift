
public func weak<T: AnyObject>(_ obj: T, _ fun: @escaping (T) -> () -> Void) -> () -> Void { { [weak obj] in
    guard let obj = obj else { return }

    fun(obj)()
} }

public func weak<T: AnyObject, A>(_ obj: T, _ fun: @escaping (T) -> Func<A, Void>) -> Func<A, Void> { { [weak obj] in
    guard let obj = obj else { return }

    fun(obj)($0)
} }

public func weakVoidHandler<T: AnyObject, A>(_ obj: T, _ fun: @escaping (T) -> Func<A, Void>) -> (A) -> VoidHandler { { a in { weak(obj, fun)(a) } } }

public func weak<T: AnyObject, A, B>(_ obj: T, _ fun: @escaping (T) -> FuncTuple2Args<A, B, Void>) -> FuncTuple2Args<A, B, Void> { { [weak obj] in
    guard let obj = obj else { return }

    fun(obj)($0, $1)
} }

public func weak<T: AnyObject, A, B, C>(_ obj: T, _ fun: @escaping (T) -> FuncTuple3Args<A, B, C, Void>) -> FuncTuple3Args<A, B, C, Void> { { [weak obj] in
    guard let obj = obj else { return }

    fun(obj)($0, $1, $2)
} }

public func weakCurry<T: AnyObject, A, B>(_ obj: T, _ fun: @escaping (T) -> FuncTuple2Args<A, B, Void>) -> Func2Args<A, B, Void> { { a in { b in
    curry(weak(obj, fun))(a)(b)
} } }

public func weakCurry<T: AnyObject, A, B, C>(_ obj: T, _ fun: @escaping (T) -> FuncTuple3Args<A, B, C, Void>) -> Func3Args<A, B, C, Void> { { a in { b in { c in
    curry(weak(obj, fun))(a)(b)(c)
} } } }

public func call<T>(_ fun: @escaping (T) -> () -> Void) -> Func<T, Void> { { obj in
    fun(obj)()
} }

public func call<T, A, B>(_ fun: @escaping (T) -> Func<A, B>, with arg: A) -> Func<T, B> { { obj in
    fun(obj)(arg)
} }
