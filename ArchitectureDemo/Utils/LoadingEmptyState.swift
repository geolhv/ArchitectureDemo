enum LoadingEmptyState {
    case idle
    case loading
    case loaded
    case failed(Error)
}

extension LoadingEmptyState: Equatable {
    static func == (lhs: LoadingEmptyState, rhs: LoadingEmptyState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.loaded, .loaded):
            return true
        case (.failed(let left), .failed(let right)):
            return type(of: left) == type(of: right) && left.localizedDescription == right.localizedDescription
        default:
            return false
        }
    }
}
