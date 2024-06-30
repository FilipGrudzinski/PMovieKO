import XCTest

@testable import PMovieKO

final class MovieDetailCoordinatorTests: XCTestCase {
    private var sut: MovieDetailCoordinator?
    private var parentNavigationController: CoordinatorNavigationControllerSpy?

    override func setUp() {
        super.setUp()
        let parentNavigationController = CoordinatorNavigationControllerSpy()
        let movieDetailNavigationDelegate = MovieDetailNavigationDelegateMock()
        let movie = Movie(
            id: 1,
            overview: "",
            title: "",
            voteAverage: 0.0,
            releaseDate: "",
            posterLink: nil,
            isFavorite: false)
        
        let sut = MovieDetailCoordinator(
            parentNavigation: parentNavigationController,
            movie: movie,
            callBack: { })

        self.sut = sut
        self.parentNavigationController = parentNavigationController
    }

    override func tearDown() {
        sut = nil
        parentNavigationController = nil
        super.tearDown()
    }
    
    func test_startMethod() throws {
        let parentNavigationController = try XCTUnwrap(parentNavigationController)
        let startExpectation = expectation(description: "Modal called")
        parentNavigationController.modalClosure = { viewController, animated, completion in
            XCTAssertEqual(viewController, parentNavigationController.modalReceivedArguments?.viewController)
            XCTAssertEqual(animated, parentNavigationController.modalReceivedArguments?.animated)
            startExpectation.fulfill()
        }
        
        sut?.start()
        
        waitForExpectations(timeout: 1)
        XCTAssertTrue(parentNavigationController.modalCalled)
    }
}
