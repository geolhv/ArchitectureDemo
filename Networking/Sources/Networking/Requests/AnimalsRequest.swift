protocol AnimalsClient {
    func getAnimals() -> [AnimalsResponse]
}

struct AnimalsClientImpl: AnimalsClient {
    func getAnimals() -> [AnimalsResponse] {
        []
    }
}
