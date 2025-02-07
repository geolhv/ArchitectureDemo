import SwiftUI

extension AnimalDetailScreen {
    enum AccessibilityId: String, AccessibilityIdentifiable {
        case image = "animal_image"
        case name = "animal_name"
    }
}

struct AnimalDetailScreen: View {
    let animal: Animal

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: animal.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .accessibilityIdentifierWithContext(AccessibilityId.image)
            Text(animal.characteristic.name)
                .accessibilityIdentifierWithContext(AccessibilityId.name)
            Spacer()
        }
        .padding()
        .navigationTitle(animal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
