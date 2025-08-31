import AnimalsDomain
import Factory
import Foundation
import Utils

public extension AnimalsScreen {
    enum TrackingEvent: String, TrackableScreen {
        case screen
    }

    struct ViewState: Equatable {
        var animals: LoadingState<[Animal]> = .idle
    }

    final class ViewModel: ObservableObject {
        @Published private(set) var state: ViewState = .init()
        @Injected(\.animalsUsecase) private var animalsUsecase
        private let tracker: Tracker
        private let onNavigation: (AnimalsNavigationDestination) -> Void

        public init(
            tracker: Tracker = .init(),
            onNavigation: @escaping (AnimalsNavigationDestination) -> Void
        ) {
            self.tracker = tracker
            self.onNavigation = onNavigation
        }

        @MainActor
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
                onNavigation(.detail(animal))
            case .didRetry:
                await getAnimals()
            }
        }

        @MainActor
        private func getAnimals() async {
            state.animals = .loading()
            do {
                let animals = try await animalsUsecase.get(name: "c")
                state.animals = .loaded(animals)
            } catch {
                state.animals = .failed(error)
            }
        }
    }
}
