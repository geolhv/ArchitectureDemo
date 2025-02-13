// https://www.donnywals.com/swift-property-wrappers-explained/
// https://www.donnywals.com/writing-custom-property-wrappers-for-swiftui/
// https://gist.github.com/ricardopereira/62f337fb079a55debe602d2235553a3e
// https://github.com/ralfebert/SwiftUIBindingTransformations/blob/main/Sources/SwiftUIBindingTransformations/SwiftUI%2BBindingTransformations.swift
// https://swiftwithmajid.com/2021/08/11/how-to-create-a-property-wrapper-in-swift/
// https://www.dhiwise.com/post/swift-property-wrappers-explained-a-simple-guide
import SwiftUI

struct UniqueId<E: Hashable>: Hashable {
    private let id: UUID
    let wrappedValue: E
    
    init(wrappedValue: E) {
        self.id = UUID()
        self.wrappedValue = wrappedValue
    }
}

@propertyWrapper
struct TaskID<Value: Hashable>: DynamicProperty {
    @State private var source: UniqueId<Value>

    var wrappedValue: Value {
        get { source.wrappedValue }
        nonmutating set {
            source = .init(wrappedValue: newValue)
        }
    }

    var projectedValue: Binding<UniqueId<Value>> {
        $source
    }

    init(wrappedValue: Value) {
        self._source = State(initialValue: .init(wrappedValue: wrappedValue))
    }
}

struct TaskIDModifier<E: Hashable>: ViewModifier {
    @Binding var uniqueEvent: UniqueId<E?>
    let action: (E) async -> Void

    func body(content: Content) -> some View {
        content
            .task(id: uniqueEvent) {
                guard let value = uniqueEvent.wrappedValue else { return }
                await action(value)
            }
            .onDisappear {
                uniqueEvent = .init(wrappedValue: nil)
            }
    }
}

extension View {
    func task<E: Hashable>(
        uniqueEvent: Binding<UniqueId<E?>>,
        action: @escaping (E) async -> Void
    ) -> some View {
        modifier(TaskIDModifier(uniqueEvent: uniqueEvent, action: action))
    }
}
