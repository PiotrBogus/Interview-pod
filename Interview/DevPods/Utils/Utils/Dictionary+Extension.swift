
public extension Collection {

    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension Dictionary {

    subscript(unsafe key: Key) -> Value { self[key]! }

    mutating func appendDictionary(_ right: [Key: Value]) {
        for (k, v) in right {
            updateValue(v, forKey: k)
        }
    }

    mutating func safeAddNotEmptyString(key: Key, value: String?) {
        guard let trimmedValue = value?.trimmed(),
              trimmedValue.count > 0 else { return }

        safeAdd(key: key, value: value as? Value)
    }

    mutating func safeAdd(key: Key, value: Value?) {
        guard let value = value else { return }

        self[key] = value
    }
}

public func + <Key, Value>(lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    rhs.reduce(lhs) { lhs, rhs in
        lhs |> set(\[Key: Value].[rhs.key], rhs.value)
    }
}
