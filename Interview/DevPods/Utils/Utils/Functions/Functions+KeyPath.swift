
public func != <Root, Value: Equatable>(_ keyPath: KeyPath<Root, Value>, _ value: Value) -> (Root?) -> Bool { { root in
    root?[keyPath: keyPath] != value
} }

public func == <Root, Value: Equatable>(_ keyPath: KeyPath<Root, Value>, _ value: Value) -> (Root?) -> Bool { { root in
    root?[keyPath: keyPath] == value
} }

public func unsafeCast<Root, Value, T>(_ keyPath: KeyPath<Root, Value>, to _: T.Type) -> (Root) -> T { { root in
    root[keyPath: keyPath] as! T
}}

// MARK: Immutable

public func get<Root, Value>(_ kp: KeyPath<Root, Value>) -> (Root) -> Value { { root in root[keyPath: kp] } }

prefix operator ^
public prefix func ^ <Root, Value>(_ kp: KeyPath<Root, Value>) -> (Root) -> Value { { root in get(kp)(root) } }

public func set<Root, Value>(_ kp: WritableKeyPath<Root, Value>, _ value: Value) -> (Root) -> Root { { root in
    var root = root
    root[keyPath: kp] = value

    return root
} }

// MARK: Mutable

public func mutate<Root, Value>(_ kp: ReferenceWritableKeyPath<Root, Value>, _ value: Value) -> (Root?) -> Void { { root in
    root?[keyPath: kp] = value
} }
