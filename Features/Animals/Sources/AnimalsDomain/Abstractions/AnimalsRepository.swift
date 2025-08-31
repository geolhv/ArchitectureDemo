public protocol AnimalsRepository: Sendable {
    func animals(name: String) async throws -> [Animal]
}
