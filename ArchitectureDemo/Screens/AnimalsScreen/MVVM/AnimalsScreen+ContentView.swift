import SwiftUI
import Domain
import Utils

extension AnimalsScreen {
    struct ContentView: View {
        let animals: LoadingState<[Animal]>
        let onEvent: (Event) -> Void
        
        var body: some View {
            VStack {
                switch animals {
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
                                action: { onEvent(.didSelect(animal)) }
                            )
                            .accessibilityIdentifierWithContext(AccessibilityId.card)
                        }
                        .padding()
                    }
                case .failed(let error):
                    ErrorView(error: error) {
                        Button {
                            onEvent(.didRetry)
                        } label:{
                            Text("Retry &#8594;")
                        }
                        .accessibilityIdentifierWithContext(AccessibilityId.retryButton)
                    }
                }
            }
        }
    }
}

#Preview {
    AnimalsScreen.ContentView(
        animals: .failed(URLError.init(.unknown)),//.loaded(Animal.fixture()),
        onEvent: { _ in }
    )
}
