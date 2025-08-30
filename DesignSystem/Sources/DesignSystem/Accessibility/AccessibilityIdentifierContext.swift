import SwiftUI

protocol AccessibilityIdentifiable: Equatable {
    var rawValue: String { get }
}

struct AccessibilityIdentifierContextViewModifier<ID: AccessibilityIdentifiable>: ViewModifier {
    let identifier: ID
    
    func body(content: Content) -> some View {
        content
            .accessibilityIdentifier(identifier.rawValue)
    }
}

public extension View {
    func accessibilityIdentifierWithContext(
        _ identifier: AccessibilityIdentifierType
    ) -> some View {
        modifier(AccessibilityIdentifierContextViewModifier(identifier: identifier))
    }
}
