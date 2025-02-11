enum LoadingState<Value: Equatable> {
    case idle
    case loading(previous: Value? = nil)
    case loaded(Value)
    case failed(Error)
}

extension LoadingState: Equatable {
    var error: Error? {
        guard case let .failed(error) = self else { return nil }
        return error
    }

    var loaded: Value? {
        guard case let .loaded(value) = self else { return nil }
        return value
    }

    var isLoading: Bool {
        guard case .loading = self else { return false }
        return true
    }

    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case let (.loading(left), .loading(right)):
            return left == right
        case let (.loaded(left), .loaded(right)):
            return left == right
        case (.failed(let left), .failed(let right)):
            return type(of: left) == type(of: right) && left.localizedDescription == right.localizedDescription
        default:
            return false
        }
    }
}
