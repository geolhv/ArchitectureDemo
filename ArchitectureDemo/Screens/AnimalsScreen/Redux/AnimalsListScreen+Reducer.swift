import Foundation

extension AnimalsListScreen {
    struct State {
        var animals: LoadingState<[Animal]> = .idle
        var selectedAnimal: Animal?
    }

    enum Action: Hashable {
        case didAppear
        case didSelect(Animal)
        case didRetry
    }
    
    struct Environment {
        let usecase: AnimalsUseCase
    }

    static func reducer(
        state: inout State,
        action: Action,
        environment: Environment
    ) async {
        switch action {
        case .didAppear, .didRetry:
            print("On Appeared")
            state.animals = .loading()
            do {
                let animals = try await environment.usecase.get()
                state.animals = .loaded(animals)
            } catch {
                state.animals = .failed(error)
            }
        case let .didSelect(animal):
            print("Going to \(animal.name)")
            state.selectedAnimal = animal
        }
    }
}
