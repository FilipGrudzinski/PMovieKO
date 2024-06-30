@testable import PMovieKO

final class CoordinatorMock: Coordinator {
    var startCallsCount = 0
    var startCalled: Bool {
        startCallsCount > 0
    }
    
    var startClosure: (() -> Void)?
    
    override func start() {
        startCallsCount += 1
        startClosure?()
    }
    
    var endCallsCount = 0
    var endCalled: Bool {
        endCallsCount > 0
    }
    
    var endClosure: (() -> Void)?
    
    override func end() {
        endCallsCount += 1
        endClosure?()
    }
    
    var startWithCallsCount = 0
    var startWithCalled: Bool {
        startWithCallsCount > 0
    }
    
    var startWithClosure: ((CoordinatorProtocol) -> Void)?
    
    override func start(_ coordinator: CoordinatorProtocol) {
        startWithCallsCount += 1
        startWithClosure?(coordinator)
    }
    
    var endWithCallsCount = 0
    var endWithCalled: Bool {
        endWithCallsCount > 0
    }
    
    var endWithClosure: ((CoordinatorProtocol) -> Void)?
    
    override func end(_ coordinator: CoordinatorProtocol) {
        endWithCallsCount += 1
        endWithClosure?(coordinator)
    }
}

