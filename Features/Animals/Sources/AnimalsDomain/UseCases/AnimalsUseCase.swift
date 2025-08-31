public struct AnimalsUseCase: Sendable {
    private let repo: AnimalsRepository

    public init(repo: AnimalsRepository) {
        self.repo = repo
    }
    
    public func get(name: String) async throws -> [Animal] {
        try await repo.animals(name: name)
    }
}
