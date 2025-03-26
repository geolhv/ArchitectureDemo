import XCTest
import Domain
import Utils
@testable import ArchitectureDemo

@MainActor
final class AnimalsScreenViewModelTests: XCTestCase {
    func test_didAppear_getAnimalsFails() async {
        let error = URLError(.badURL)
        let viewModel = sut(animals: .failure(error))
        await viewModel.handle(event: .didAppear)
        XCTAssertEqual(viewModel.state.animals, .failed(error))
    }
    
    func test_didAppear_getAnimalsSucceed() async {
        let animals: [Animal] = Animal.fixture()
        let viewModel = sut(animals: .success(Animal.fixture()))
        await viewModel.handle(event: .didAppear)
        XCTAssertEqual(viewModel.state.animals, .loaded(animals))
    }
    
    func test_didSelectAnimal() async {
        let result: Animal = .fixture()
        var selectedAnimal: Animal?
        let viewModel = sut(
            animals: .success(Animal.fixture()),
            selectedAnimal: { selectedAnimal = $0 }
        )
        await viewModel.handle(event: .didSelect(result))
        XCTAssertEqual(selectedAnimal, result)
    }
}

extension AnimalsScreenViewModelTests {
    func sut(
        animals: Result<[Animal], Error> = .failure(URLError(.badURL)),
        selectedAnimal: ((Animal) -> Void)? = nil
    ) -> AnimalsScreen.ViewModel {
        .init(
            usecase: AnimalsUseCaseMock(results: animals),
            onNavigation: {
                selectedAnimal?($0)
            }
        )
    }
}
