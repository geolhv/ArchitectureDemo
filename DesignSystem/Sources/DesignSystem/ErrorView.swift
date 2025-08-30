import SwiftUI

public struct ErrorView<Content: View>: View {
    private let error: Error
    private let accessibilityId: AccessibilityIdentifierType
    private let content: () -> Content
    
    public init(
        error: Error,
        accessibilityId: AccessibilityIdentifierType,
        content: @escaping () -> Content
    ) {
        self.error = error
        self.accessibilityId = accessibilityId
        self.content = content
    }
    
    public var body: some View {
        VStack {
            Text("Something went wrong: \(error.localizedDescription)\nPlease try again later.")
                .multilineTextAlignment(.center)
                .padding()
            content()
        }
        .accessibilityIdentifierWithContext(accessibilityId)
    }
}
