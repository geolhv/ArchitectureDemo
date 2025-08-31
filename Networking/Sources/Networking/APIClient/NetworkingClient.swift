import Foundation

public protocol NetworkingClientRequestable: Sendable {
    func execute<T: HTTPRequest, V: Decodable>(
        request: T
    ) async throws -> V where T.ResponseObject == V
}

public struct NetworkingClient: NetworkingClientRequestable {
    private let session: HTTPSession

    public init(session: HTTPSession = URLSession.shared) {
        self.session = session
    }
    
    public func execute<T: HTTPRequest, V: Decodable>(
        request: T
    ) async throws -> V where T.ResponseObject == V {
        let urlRequest = try urlRequest(from: request)
        let result = try await session.data(of: urlRequest)
        return try process(result)
    }

    private func urlRequest<T: HTTPRequest>(from endPoint: T) throws -> URLRequest {
        let url = try urlComponent(from: endPoint)
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.timeoutInterval = endPoint.timeoutInterval
        setHeaders(with: endPoint.provider, request: &request)
        return request
    }
    
    private func setHeaders(with provider: NetworkProvider, request: inout URLRequest) {
        var values = ["Content-Type": "application/json"]
        values.merge(provider.headers) { $1 }
        for (key, value) in values {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func urlComponent<T: HTTPRequest>(from endPoint: T) throws -> URL {
        guard
            let url = endPoint.provider.baseUrl,
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            throw NetworkError.invalidUrl
        }
        urlComponents.path = endPoint.path
        urlComponents.queryItems = endPoint.queryItems
        guard let url = urlComponents.url else { throw NetworkError.invalidUrlComponent }
        return url
    }

    private func process<T: Decodable>(
        _ result: HTTPSession.DataOutput
    ) throws -> T {
        let response = result.response as? HTTPURLResponse
        switch (result.data, response) {
        case let (data, .some(value)) where 200 ..< 300 ~= value.statusCode:
            return try JSONDecoder().decode(T.self, from: data)
        default:
            throw NetworkError.noResponse
        }
    }
}
