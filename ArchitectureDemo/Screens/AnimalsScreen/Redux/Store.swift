// https://swiftwithmajid.com/2022/02/17/redux-like-state-container-in-swiftui-part5/
// https://www.kodeco.com/22096649-getting-a-redux-vibe-into-swiftui
// https://medium.com/neudesic-innovation/managing-swiftui-state-using-redux-525a8879c1be
// https://anuragajwani.medium.com/redux-architecture-adaption-in-swiftui-1b8d36acd177
// https://fatbobman.com/en/posts/async-await-store/

import Foundation

final class Store<State, Action, Environment>: ObservableObject {
    typealias Reducer = (_: inout State, Action, Environment) async -> Void
    
    @Published private(set) var state: State
    private let reducer: Reducer
    private let environment: Environment
    
    init(
        initialState: State,
        reducer: @escaping Reducer,
        environment: Environment
    ) {
        self.state = initialState
        self.reducer = reducer
        self.environment = environment
    }

    @MainActor
    func send(action: Action) async {
        await reducer(&state, action, environment)
    }
}
