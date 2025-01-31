import SwiftUI

struct AnimalsScreen: View {
    enum Event: Hashable {
        case didAppear
        case didSelect(Animal)
    }

    @StateObject private var viewModel: ViewModel
    @State private var currentEvent: Event? = .didAppear
    
    init(viewModel: ViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        ContentView(
            state: viewModel.state,
            onEvent: { currentEvent = $0 }
        )
        .navigationTitle("Animals")
        .navigationBarTitleDisplayMode(.inline)
        .task(event: $currentEvent) { value in
            await viewModel.handle(event: value)
        }
    }
}
