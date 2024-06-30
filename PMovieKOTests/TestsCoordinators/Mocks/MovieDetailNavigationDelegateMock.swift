@testable import PMovieKO

final class MovieDetailNavigationDelegateMock: MovieDetailNavigationDelegate {
    var closeMoveDetailCallsCount = 0
    var closeMoveDetailCalled: Bool {
        closeMoveDetailCallsCount > 0
    }

    func closeMoveDetail() {
        closeMoveDetailCallsCount += 1
    }
}
