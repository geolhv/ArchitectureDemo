import Foundation
import Domain
import Utils

extension AnimalsScreen {
    enum TrackingEvent: String, TrackableScreen {
        case screen
    }

    struct ViewState: Equatable {
        var animals: LoadingState<[Animal]> = .idle
    }

    @MainActor
    final class ViewModel: ObservableObject {
        @Published private(set) var state: ViewState = .init()
        private let tracker: Tracker
        private let usecase: AnimalsUseCase
        private let onNavigation: (Animal) -> Void

        init(
            usecase: AnimalsUseCase = AnimalsUseCaseImpl(),
            tracker: Tracker = .init(),
            onNavigation: @escaping (Animal) -> Void
        ) {
            self.usecase = usecase
            self.tracker = tracker
            self.onNavigation = onNavigation
        }

        func handle(event: Event) async {
            switch event {
            case .didFirstAppear:
                print("First appear triggered")
                tracker.track(screen: TrackingEvent.screen)
                await getAnimals()
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
            state.animals = .loading()
            do {
                let animals = try await usecase.get()
                state.animals = .loaded(animals)
            } catch {
                state.animals = .failed(error)
            }
        }
    }
}
