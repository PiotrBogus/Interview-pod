
public typealias Func<A, B> = (A) -> B
public typealias Func2Args<A, B, C> = (A) -> (B) -> C
public typealias Func3Args<A, B, C, D> = (A) -> (B) -> (C) -> D
public typealias Func4Args<A, B, C, D, E> = (A) -> (B) -> (C) -> (D) -> E
public typealias Func5Args<A, B, C, D, E, F> = (A) -> (B) -> (C) -> (D) -> (E) -> F
public typealias Func6Args<A, B, C, D, E, F, G> = (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> G
public typealias FuncTuple2Args<A, B, C> = (A, B) -> C
public typealias FuncTuple3Args<A, B, C, D> = (A, B, C) -> D
public typealias IdentityFunc<A> = Func<A, A>

public typealias VoidHandler = () -> Void
public typealias Handler<T> = Func<T, Void> // (T) -> Void
public typealias HandlerTuple2Args<T, U> = (T, U) -> Void // (T, U) -> Void
public typealias HandlerTuple3Args<T, U, V> = (T, U, V) -> Void // (T, U, V) -> Void

public typealias VoidProvider<T> = () -> T

public typealias Flow = Handler<VoidHandler>
public typealias FlowResult<S, F: Error> = Handler<Result<S, F>> // (Result<S, F>) -> Void
public typealias FlowInitialization<S, F: Error> = Handler<FlowResult<S, F>> // ((Result<S, F>) -> Void) -> Void
public typealias DualFlowContinuation<ResultValue, CompletionValue> = Func<Handler<ResultValue>, Handler<CompletionValue>>
public typealias FlowContinuation<S, F: Error> = Func<FlowResult<S, F>, FlowResult<S, F>> // ((Result<S, F>) -> Void) -> ((Result<S, F>) -> Void)
public typealias FlowFinalization<S, F: Error> = () -> FlowResult<S, F> // () -> ((Result<S, F>) -> Void)
