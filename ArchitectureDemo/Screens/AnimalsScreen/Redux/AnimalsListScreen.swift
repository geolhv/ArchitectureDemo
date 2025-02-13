import SwiftUI

struct AnimalsListScreen: View {
    @StateObject private var store: Store<State, Action, Environment>
    @TaskID private var currentAction: Action? = .didAppear
    private let onNavigation: (Animal) -> Void

    init(
        usecase: AnimalsUseCase = AnimalsUseCaseImpl(),
        onNavigation: @escaping (Animal) -> Void
    ) {
        self._store = .init(wrappedValue: .init(
            initialState: .init(),
            reducer: Self.reducer(state:action:environment:),
            environment: .init(usecase: usecase))
        )
        self.onNavigation = onNavigation
    }

    var body: some View {
        ContentView(
            state: store.state.animals,
            onEvent: { currentAction = $0 }
        )
        .navigationTitle("Animals")
        .navigationBarTitleDisplayMode(.inline)
        .task(uniqueEvent: $currentAction) { value in
            await store.send(action: value)
        }
        .onChange(of: store.state.selectedAnimal) { _, animal in
            guard let animal else { return }
            onNavigation(animal)
        }
    }
}
