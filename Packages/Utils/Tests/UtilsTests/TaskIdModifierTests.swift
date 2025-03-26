@testable import Utils
import SwiftUI
import ViewInspector
import XCTest

@MainActor
final class TaskIdModifierTests: XCTestCase {
    enum Event: Hashable {
        case idle
        case onAppear
        case onFirstAppear
        case onTap
    }
    
    override func tearDown() {
        ViewHosting.expel()
        super.tearDown()
    }

    func test_onChange_string() throws {
        var expectedValue: String?
        let val = "hey"
        let sut = EmptyView()
            .onChange(of: val) { oldVal, value in
                print("OLD \(oldVal), NEW \(value)")
                expectedValue = value
            }
        try sut.inspect().emptyView()
            .callOnChange(oldValue: "hey", newValue: "expected")
        XCTAssertEqual(expectedValue, "expected")
    }
    
    func test_onChange_value() throws {
        struct TestValue: Equatable {
            let value: String
        }

        var expectedValue: TestValue?
        let val = TestValue(value: "initial")
        
        let sut = EmptyView()
            .onChange(of: val) { _, newValue in
                expectedValue = newValue
            }
        
        try sut.inspect().emptyView()
            .callOnChange(oldValue: TestValue(value: "initial"), newValue: TestValue(value: "expected"))
        XCTAssertEqual(expectedValue, TestValue(value: "expected"))
    }
    
    func testTaskIdInspection() async throws {
        var expectedValue: String?
        var val = "hey"
        let sut = EmptyView()
            .padding()
            .task(id: val) {
                expectedValue = val
            }
        val = "expected"
        try await sut.inspect()
            .emptyView()
            .callTask(id: val)
        XCTAssertEqual(expectedValue, "expected")
    }

    func testOnFirstEventTriggersTask() async throws {
        var trigger = UniqueId(wrappedValue: "initial")
        let binding = Binding<UniqueId<String>>(
            get: { trigger },
            set: { trigger = $0 }
        )
        let expectation = XCTestExpectation(description: "Task ran with first event")
        
        let view = EmptyView()
                .task(
                    uniqueEvent: binding,
                    onFirstEvent: "first",
                    onAppearEvent: "appearing",
                    onDisappearEvent: "disappearing",
                    action: { value in
                        print("Value received: \(value)")
                        XCTAssertEqual(value, "first")
                        expectation.fulfill()
                    }
                )

        ViewHosting.host(view: view)

        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testManualTrigger() async throws {
        let expectation = XCTestExpectation(description: "Task ran with first event")
        var trigger = UniqueId(wrappedValue: "initial")
        let binding = Binding<UniqueId<String>>(
            get: { trigger },
            set: { trigger = $0 }
        )

        let view = Text("Test")
            .modifier(TaskIDModifier(
                uniqueEvent: binding,
                onFirstEvent: "dum",
                action: { value in
                    print("value received: \(value)")
                    XCTAssertEqual(value, "test")
                    expectation.fulfill()
                }
            ))

        ViewHosting.host(view: view)

        trigger = UniqueId(wrappedValue: "test") // simulate a manual change
        
        defer { ViewHosting.expel() }
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func test_onFirstAppear() async throws {
        var trigger = UniqueId(wrappedValue: Event.idle)
        let binding = Binding<UniqueId<Event>>(
            get: { trigger },
            set: { trigger = $0 }
        )
        var expectedEvent: Event?
        
        let view = EmptyView().task(
            uniqueEvent: binding,
            onFirstEvent: .onFirstAppear,
            onAppearEvent: .onAppear,
            action: { value in
                print("Value received: \(value)")
                expectedEvent = value
            }
        )

        // Why ViewHosting is used to actually renders the view in a real SwiftUI environment.
        //It triggers .onAppear, .task, etc., naturally and help us avoid having to fake .callOnAppear().
        ViewHosting.host(view: view)
        
        // The .task(id:) modifier runs after the view appears,
        // but ViewInspector's .callOnAppear() doesn't synchronously await .task.
        // Adding a Task.sleep() gives the system time to start the task.
        try await Task.sleep(for: .seconds(0.1))
        XCTAssertEqual(expectedEvent, .onFirstAppear)
    }
    
    func test_onAppear() async throws {
        var trigger = UniqueId(wrappedValue: Event.idle)
        let binding = Binding<UniqueId<Event>>(
            get: { trigger },
            set: { trigger = $0 }
        )
        var expectedEvent: Event?
        
        let view = EmptyView().task(
            uniqueEvent: binding,
            onFirstEvent: nil,
            onAppearEvent: .onAppear,
            action: { value in
                print("Value received: \(value)")
                expectedEvent = value
            }
        )
        
        ViewHosting.host(view: view)
        
        try await Task.sleep(for: .seconds(0.1))
        XCTAssertEqual(expectedEvent, .onAppear)
    }
    
    func test_new_event() async throws {
        var trigger = UniqueId(wrappedValue: Event.idle)
        let binding = Binding<UniqueId<Event>>(
            get: { trigger },
            set: { trigger = $0 }
        )
        
        var expectedEvent: Event?
        
        let view = EmptyView().task(
            uniqueEvent: binding,
            onFirstEvent: .onFirstAppear,
            onAppearEvent: .onAppear,
            action: { value in
                print("Value received: \(value)")
                expectedEvent = value
            }
        )
        
        ViewHosting.host(view: view)
        
        trigger = .init(wrappedValue: .onTap)
        
        try await Task.sleep(for: .seconds(0.1))
        XCTAssertEqual(expectedEvent, .onTap)
    }
}
