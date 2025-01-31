import SwiftUI

struct TaskEvent<E: Hashable>: ViewModifier {
    @Binding var currentEvent: E?
    let action: (E) async -> Void

    func body(content: Content) -> some View {
        content
            .task(id: currentEvent) {
                guard let currentEvent else { return }
                await action(currentEvent)
                self.currentEvent = nil
            }
    }
}

extension View {
    func task<E: Hashable>(
        event: Binding<E?>,
        action: @escaping (E) async -> Void
    ) -> some View {
        modifier(TaskEvent(currentEvent: event, action: action))
    }
}
