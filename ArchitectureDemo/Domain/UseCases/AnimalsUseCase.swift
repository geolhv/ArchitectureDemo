protocol AnimalsUseCase {
    func get() async throws -> [Animal]
}

struct AnimalsUseCaseImpl: AnimalsUseCase {
    func get() async throws -> [Animal] {
        return Animal.fixture()
    }
}
