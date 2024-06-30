import XCTest

final class CoordinatorTests: XCTestCase {
    private var sut: CoordinatorMock?
    
    private let expectedCallsCount = 1
    private let expectedCalled = true
    
    override func setUp() {
        super.setUp()
        
        sut = CoordinatorMock()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_coordinatorStart() throws {
        let sut = try XCTUnwrap(sut)
        sut.start()
        XCTAssertEqual(sut.startCallsCount, expectedCallsCount)
        XCTAssertEqual(sut.startCalled, expectedCalled)
    }
    
    func test_coordinatorEnd() throws {
        let sut = try XCTUnwrap(sut)
        sut.end()
        XCTAssertEqual(sut.endCallsCount, expectedCallsCount)
        XCTAssertEqual(sut.endCalled, expectedCalled)
    }
    
    func test_coordinatorStartWith() throws {
        let sut = try XCTUnwrap(sut)
        let startCoordinator = CoordinatorMock()
        sut.start(startCoordinator)
        XCTAssertEqual(sut.startWithCallsCount, expectedCallsCount)
        XCTAssertEqual(sut.startWithCalled, expectedCalled)
    }
    
    func test_coordinatorEndWith() throws {
        let sut = try XCTUnwrap(sut)
        let endCoordinator = CoordinatorMock()
        sut.end(endCoordinator)
        XCTAssertEqual(sut.endWithCallsCount, expectedCallsCount)
        XCTAssertEqual(sut.endWithCalled, expectedCalled)
    }
}

