@testable import Animals
import Foundation
import Testing

struct AnimalsListScreenReducerTests {
    @Test("on didAppear getAnimals fails")
    func didAppear_getAnimalsFails() async {
        let error = URLError(.badURL)
        let store = sut(animals: .failure(error))
//        await store.send(action: .didAppear)
//        #expect(store.state.animals == .failed(error))
    }
    
    @Test("on didAppear getAnimals succeeds")
    func didAppear_getAnimalsSucceed() async {
        let animals: [Animal] = Animal.fixture()
        let store = sut(animals: .success(Animal.fixture()))
//        await store.send(action: .didAppear)
//        #expect(store.state.animals == .loaded(animals))
    }
    
    @Test("on didSelect animal")
    func didSelectAnimal() async {
        let result: Animal = .fixture()
        let store = sut(animals: .success(Animal.fixture()))
//        await store.send(action: .didSelect(result))
//        #expect(store.state.selectedAnimal == result)
    }
}

extension AnimalsListScreenReducerTests {
    func sut(
        animals: Result<[Animal], Error> = .failure(URLError(.badURL))
    ) -> Store<
        AnimalsListScreen.State,
        AnimalsListScreen.Action,
        AnimalsListScreen.Environment
    > {
        .init(
            initialState: .init(),
            reducer: AnimalsListScreen.reducer(state:action:environment:),
            environment: .init(usecase: AnimalsUseCaseMock(results: animals))
        )
    }
}
