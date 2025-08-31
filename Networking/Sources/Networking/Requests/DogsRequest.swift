import Foundation

/// `GET /v1/dogs`
///
/// Fetches animals starting with c
public struct DogsRequest: HTTPRequest {
    public typealias ResponseObject = [DogsResponse]
    public typealias ErrorObject = NetworkError
    
    public let provider: NetworkProvider = .apiNinja
    public let method: HTTPMethod = .get
    public let path = "/v1/dogs"
    public let queryItems: [URLQueryItem]?
    
    public init(name: String) {
        queryItems = [URLQueryItem(name: "name", value: name)]
    }
}
