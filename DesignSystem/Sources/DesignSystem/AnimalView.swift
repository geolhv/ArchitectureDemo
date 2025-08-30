import SwiftUI

public struct AnimalView: View {
    private let name: String
    private let imageUrl: String
    private let characteristic: String
    private let accessibilityId: AccessibilityIdentifierType
    private let action: () -> Void
    
    public init(
        name: String,
        imageUrl: String,
        characteristic: String,
        accessibilityId: AccessibilityIdentifierType,
        action: @escaping () -> Void
    ) {
        self.name = name
        self.imageUrl = imageUrl
        self.characteristic = characteristic
        self.accessibilityId = accessibilityId
        self.action = action
    }
    
    public var body: some View {
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
        .accessibilityIdentifierWithContext(accessibilityId)
    }
}
