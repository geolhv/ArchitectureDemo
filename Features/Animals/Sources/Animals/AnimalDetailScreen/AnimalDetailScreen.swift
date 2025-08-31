import AnimalsDomain
import SwiftUI

public struct AnimalDetailScreen: View {
    private let animal: Animal
    
    public init(animal: Animal) {
        self.animal = animal
    }

    public var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: animal.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .accessibilityIdentifierWithContext(.image)
            Text(animal.characteristic.name)
                .accessibilityIdentifierWithContext(.name)
            Spacer()
        }
        .padding()
        .navigationTitle(animal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
