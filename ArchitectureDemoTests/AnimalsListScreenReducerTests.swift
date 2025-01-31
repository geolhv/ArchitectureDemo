import XCTest
@testable import ArchitectureDemo

@MainActor
final class AnimalsListScreenReducerTests: XCTestCase {
    func test_didAppear_getAnimalsFails() async {
        let error = URLError(.badURL)
        let store = sut(animals: .failure(error))
        await store.send(action: .didAppear)
        XCTAssertEqual(store.state.animals, .failed(error))
    }
    
    func test_didAppear_getAnimalsSucceed() async {
        let animals: [Animal] = Animal.fixture()
        let store = sut(animals: .success(Animal.fixture()))
        await store.send(action: .didAppear)
        XCTAssertEqual(store.state.animals, .loaded(animals))
    }
    
    func test_didSelectAnimal() async {
        let result: Animal = .fixture()
        let store = sut(animals: .success(Animal.fixture()))
        await store.send(action: .didSelect(result))
        XCTAssertEqual(store.state.selectedAnimal, result)
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
