import SwiftUI

extension AnimalsScreen {
    enum AccessibilityId: String, AccessibilityIdentifiable {
        case card = "card_view"
        case retryButton = "retry_button"
    }
}

struct AnimalsScreen: View {
    enum Event: Hashable {
        case didAppear
        case didSelect(Animal)
        case didRetry
    }

    @StateObject private var viewModel: ViewModel
    @State private var currentEvent: Event? = .didAppear
    
    init(viewModel: ViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        ContentView(
            animals: viewModel.state.animals,
            onEvent: { currentEvent = $0 }
        )
        .navigationTitle("Animals")
        .navigationBarTitleDisplayMode(.inline)
        .task(event: $currentEvent) { value in
            await viewModel.handle(event: value)
        }
    }
}
