import AnimalsDomain
import Networking

public struct AnimalsRepositoryImpl: AnimalsRepository {
    private let apiClient: NetworkingClientRequestable

    public init(apiClient: NetworkingClientRequestable = NetworkingClient()) {
        self.apiClient = apiClient
    }

    public func animals(name: String) async throws -> [Animal] {
        let values = try await apiClient.execute(request: DogsRequest(name: name))
        return values.map(Animal.init)
    }
}

extension Animal {
    init (dog: DogsResponse) {
        self.init(
            name: dog.name,
            imageUrl: dog.imageURL,
            characteristic: .reptile
        )
    }
}
