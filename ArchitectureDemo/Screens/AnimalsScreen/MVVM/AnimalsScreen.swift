import SwiftUI
import Domain
import Utils
import Foundation

extension AnimalsScreen {
    enum AccessibilityId: String, AccessibilityIdentifiable {
        case card = "card_view"
        case retryButton = "retry_button"
    }
}

struct AnimalsScreen: View {
    enum Event: Hashable {
        case didFirstAppear
        case didAppear
        case didSelect(Animal)
        case didRetry
    }

    @StateObject private var viewModel: ViewModel
    @TaskID private var currentEvent: Event = .didFirstAppear
    
    init(viewModel: ViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        ContentView(
            animals: viewModel.state.animals,
            onEvent: { currentEvent = $0 }
        )
        .navigationTitle("screen.title")
        .navigationBarTitleDisplayMode(.inline)
        .task(
            uniqueEvent: $currentEvent,
            onFirstEvent: .didFirstAppear,
            onAppearEvent: .didAppear
        ) { value in
            await viewModel.handle(event: value)
        }
    }
}
