import Foundation

extension AnimalsScreen {

    @MainActor
    final class ViewModel: ObservableObject {
        @Published private(set) var state: LoadingState<[Animal]> = .idle
        private let usecase: AnimalsUseCase
        private let onNavigation: (Animal) -> Void

        init(
            usecase: AnimalsUseCase = AnimalsUseCaseImpl(),
            onNavigation: @escaping (Animal) -> Void
        ) {
            self.usecase = usecase
            self.onNavigation = onNavigation
        }

        func handle(event: Event) async {
            switch event {
            case .didAppear:
                print("On Appeared")
                await getAnimals()
            case let .didSelect(animal):
                print("Going to \(animal.name)")
                onNavigation(animal)
            case .didRetry:
                await getAnimals()
            }
        }

        private func getAnimals() async {
            state = .loading
            do {
                let animals = try await usecase.get()
                state = .loaded(animals)
            } catch {
                state = .failed(error)
            }
        }
    }
}
