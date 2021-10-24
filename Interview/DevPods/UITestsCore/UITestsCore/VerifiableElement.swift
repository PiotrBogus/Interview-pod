
public protocol VerifiableElement {
    associatedtype Validator: ElementValidator

    var validator: Validator { get }
}
