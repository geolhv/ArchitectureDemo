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

extension View {
    func accessibilityIdentifierWithContext<ID: AccessibilityIdentifiable>(
        _ identifier: ID
    ) -> some View {
        modifier(AccessibilityIdentifierContextViewModifier(identifier: identifier))
    }
}
