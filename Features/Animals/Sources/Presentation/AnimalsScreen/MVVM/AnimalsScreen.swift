import SwiftUI
import Utils
import Foundation

public struct AnimalsScreen: View {
    enum Event: Hashable & Sendable {
        case didFirstAppear
        case didAppear
        case didSelect(Animal)
        case didRetry
    }

    @StateObject private var viewModel: ViewModel
    @TaskID private var currentEvent: Event = .didFirstAppear
    
    public init(viewModel: ViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    public var body: some View {
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
