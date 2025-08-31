import Foundation

public enum NetworkError: Swift.Error, Equatable {
    case unknown
    case invalidUrl
    case invalidUrlComponent
    case noResponse
    case genericError
    
    public var localizedDescription: String {
        switch self {
        case .unknown: return "Unknown"
        case .invalidUrl: return "We encounted an error using url"
        case .invalidUrlComponent: return "We encountered an error with url component"
        case .noResponse: return "Did not get a HTTPURLResponse"
        case .genericError: return "We encountered an error with request"
        }
    }
}

extension NetworkError {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown),
            (.invalidUrl, .invalidUrl),
            (.invalidUrlComponent, .invalidUrlComponent),
            (.noResponse, .noResponse),
            (.genericError, .genericError):
            return true
        default:
            return false
        }
    }
}
