import AnimalsDomain
import Factory
import Networking

public extension Container {
    var animalsRepository: Factory<AnimalsRepository> {
        Factory(self) {
            AnimalsRepositoryImpl(apiClient: self.networkClient())
        }
    }
}
