import SwiftUI

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
            Text(animal.characteristic.name)
            Spacer()
        }
        .padding()
        .navigationTitle(animal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
