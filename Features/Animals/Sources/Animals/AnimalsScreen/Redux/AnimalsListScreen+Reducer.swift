import AnimalsDomain
import Factory
import Foundation
import Utils

extension AnimalsListScreen {
    struct State: Sendable {
        var animals: LoadingState<[Animal]> = .idle
        var selectedAnimal: Animal?
    }

    enum Action: Hashable, Sendable {
        case didAppear
        case didSelect(Animal)
        case didRetry
    }
    
    struct Environment: Sendable {
        @Injected(\.animalsUsecase) var animalsUsecase
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
                let animals = try await environment.animalsUsecase.get(name: "c")
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
