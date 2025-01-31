enum LoadingState<Value: Equatable> {
    case idle
    case loading
    case loaded(Value)
    case failed(Error)
}

extension LoadingState: Equatable {
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case let (.loaded(left), .loaded(right)):
            return left == right
        case (.failed(let left), .failed(let right)):
            return type(of: left) == type(of: right) && left.localizedDescription == right.localizedDescription
        default:
            return false
        }
    }
}
