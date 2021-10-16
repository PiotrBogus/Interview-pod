//
//import XCTest
//
//final class TrackingValidationExpectation: XCTestExpectation {
//    
//    private let validator: AnalyticsValidator
//    private let event: AnalyticsEvent
//    private(set) var isFullfilled = false
//    private var timer: Timer?
//    private(set) var lastResult: AnalyticsValidator.Result?
//    
//    init(validator: AnalyticsValidator, event: AnalyticsEvent) {
//        self.validator = validator
//        self.event = event
//        
//        super.init(description: "TrackingValidation - \(event.name)")
//        
//        start()
//    }
//
//    convenience init<Param: AnalyticsValidatorParameters>(validator: AnalyticsValidator, param: Param) {
//        let event = AnalyticsEvent(type: Param.type.eventType, name: param.name, contextData: param.contextData)
//
//        self.init(validator: validator, event: event)
//    }
//    
//    func validate() -> Bool {
//        let result = validator.validate(event)
//        
//        lastResult = result
//        
//        return result.isValid
//    }
//    
//    func stop() {
//        guard timer != nil else { return }
//        
//        timer?.invalidate()
//        timer = nil
//        
//        if isFullfilled == false {
//            logErrorMessage()
//        }
//    }
//    
//    override func fulfill() {
//        super.fulfill()
//        
//        isFullfilled = true
//    }
//    
//    private func start() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//            if self.validate() {
//                self.fulfill()
//                self.stop()
//            }
//        }
//    }
//    
//    private func logErrorMessage() {
//        guard let result = lastResult else { return }
//        
//        print(errorMessage(for: result))
//    }
//    
//    private func errorMessage(for result: AnalyticsValidator.Result) -> String {
//        """
//        
//        Tracking validation failed
//        \(result.event)
//
//        All event names \(result.events.enumerated().map { "\($0): \($1.name)" })
//        
//        """
//    }
//}
//
//private extension AnalyticsParameterType {
//
//    var eventType: AnalyticsEvent.EventType {
//        switch self {
//        case .adjust: return .adjust
//        case .action: return .action
//        case .state: return .state
//        }
//    }
//}
