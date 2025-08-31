import AnimalsDomain
import DesignSystem
import SwiftUI
import Utils

extension AnimalsListScreen {
    struct ContentView: View {
        let state: LoadingState<[Animal]>
        let onEvent: (Action) -> Void

        var body: some View {
            VStack {
                switch state {
                case .idle:
                    Color.clear
                case .loading:
                    LoadingView()
                case .loaded(let animals):
                    ScrollView {
                        ForEach(animals) { animal in
                            AnimalView(
                                name: animal.name,
                                imageUrl: animal.imageUrl,
                                characteristic: animal.characteristic.name,
                                accessibilityId: .card,
                                action: { onEvent(.didSelect(animal)) }
                            )
                        }
                        .padding()
                    }
                case .failed(let error):
                    ErrorView(error: error, accessibilityId: .retryButton) {
                        Button {
                            onEvent(.didRetry)
                        } label:{
                            Text("Retry")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AnimalsListScreen.ContentView(
        state: .loaded(Animal.fixture()),
        onEvent: { _ in }
    )
}
