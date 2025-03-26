// https://www.donnywals.com/swift-property-wrappers-explained/
// https://www.donnywals.com/writing-custom-property-wrappers-for-swiftui/
// https://gist.github.com/ricardopereira/62f337fb079a55debe602d2235553a3e
// https://github.com/ralfebert/SwiftUIBindingTransformations/blob/main/Sources/SwiftUIBindingTransformations/SwiftUI%2BBindingTransformations.swift
// https://swiftwithmajid.com/2021/08/11/how-to-create-a-property-wrapper-in-swift/
// https://www.dhiwise.com/post/swift-property-wrappers-explained-a-simple-guide
import SwiftUI

public struct UniqueId<E: Hashable>: Hashable {
    private let id: UUID
    public let wrappedValue: E
    
    public init(wrappedValue: E) {
        self.id = UUID()
        self.wrappedValue = wrappedValue
    }
}

@propertyWrapper
public struct TaskID<Value: Hashable>: DynamicProperty {
    @State private var source: UniqueId<Value>

    public var wrappedValue: Value {
        get { source.wrappedValue }
        nonmutating set {
            source = .init(wrappedValue: newValue)
        }
    }

    public var projectedValue: Binding<UniqueId<Value>> {
        $source
    }

    public init(wrappedValue: Value) {
        self._source = State(initialValue: .init(wrappedValue: wrappedValue))
    }
}

struct TaskIDModifier<E: Hashable>: ViewModifier {
    @Binding var uniqueEvent: UniqueId<E>
    @State var onFirstEvent: E?
    let onAppearEvent: E?
    let action: (E) async -> Void

    init(
        uniqueEvent: Binding<UniqueId<E>>,
        onFirstEvent: E? = nil,
        onAppearEvent: E? = nil,
        action: @escaping (E) async -> Void
    ) {
        _uniqueEvent = uniqueEvent
        self.onFirstEvent = onFirstEvent
        self.onAppearEvent = onAppearEvent
        self.action = action
    }

    func body(content: Content) -> some View {
        content
            .task(id: uniqueEvent) {
                let value = uniqueEvent.wrappedValue
                await action(value)
            }
            .onAppear {
                if let event = onFirstEvent {
                    uniqueEvent = .init(wrappedValue: event)
                    onFirstEvent = nil
                } else {
                    guard let onAppearEvent, uniqueEvent.wrappedValue != onFirstEvent else {
                        return
                    }
                    uniqueEvent = .init(wrappedValue: onAppearEvent)
                }
            }
    }
}

public extension View {
    func task<E: Hashable>(
        uniqueEvent: Binding<UniqueId<E>>,
        onFirstEvent: E? = nil,
        onAppearEvent: E? = nil,
        action: @escaping (E) async -> Void
    ) -> some View {
        modifier(TaskIDModifier(
            uniqueEvent: uniqueEvent,
            onFirstEvent: onFirstEvent,
            onAppearEvent: onAppearEvent,
            action: action
        ))
    }
}
