import SwiftUI

extension AnimalsScreen {
    struct ContentView: View {
        let state: LoadingState<[Animal]>
        let onEvent: (Event) -> Void
        
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
                                action: { onEvent(.didSelect(animal)) }
                            )
                        }
                        .padding()
                    }
                case .failed(let error):
                    ErrorView(error: error)
                }
            }
        }
    }
}

#Preview {
    AnimalsScreen.ContentView(
        state: .loaded(Animal.fixture()),
        onEvent: { _ in }
    )
}
