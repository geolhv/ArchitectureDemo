import Foundation

public protocol HTTPRequest {
    associatedtype ResponseObject = Any
    associatedtype ErrorObject = Error
    var provider: NetworkProvider { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var timeoutInterval: TimeInterval { get }
}

public extension HTTPRequest {
    var timeoutInterval: TimeInterval { 30.0 }
}
