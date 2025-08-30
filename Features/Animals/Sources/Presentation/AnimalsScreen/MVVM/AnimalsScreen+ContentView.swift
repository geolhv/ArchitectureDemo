import SwiftUI
import DesignSystem
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
                            Text("Retry &#8594;")
                        }
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
