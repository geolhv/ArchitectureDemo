public protocol AnimalsUseCase: Sendable {
    func get() async throws -> [Animal]
}

public struct AnimalsUseCaseImpl: AnimalsUseCase {
    public init() {}
    public func get() async throws -> [Animal] {
        return Animal.fixture()
    }
}
