import AnimalsDomain
import AnimalsData
import Factory

extension Container {
    var animalsUsecase: Factory<AnimalsUseCase> {
        Factory(self) {
            AnimalsUseCase(repo: self.animalsRepository())
        }
    }
}
