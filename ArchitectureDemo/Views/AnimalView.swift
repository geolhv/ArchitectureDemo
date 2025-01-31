import SwiftUI

struct AnimalView: View {
    let name: String
    let imageUrl: String
    let characteristic: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .padding(.leading, 8)
                Text(name)
                    .foregroundStyle(Color.black)
                Spacer()
                Text(characteristic)
                    .foregroundStyle(Color.black)
                    .font(.caption2)
                    .padding(8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 4)
        }
    }
}
