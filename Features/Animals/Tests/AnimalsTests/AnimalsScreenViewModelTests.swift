@testable import Animals
import Foundation
import Testing

struct AnimalsScreenViewModelTests {
    @Test("on didAppear getAnimals fails")
    func didAppear_getAnimalsFails() async {
        let error = URLError(.badURL)
        let viewModel = sut(animals: .failure(error))
//        await viewModel.handle(event: .didAppear)
//        #expect(viewModel.state.animals == .failed(error))
    }
    
    @Test("on didAppear getAnimals succeeds")
    func didAppear_getAnimalsSucceed() async {
        let animals: [Animal] = Animal.fixture()
        let viewModel = sut(animals: .success(Animal.fixture()))
//        await viewModel.handle(event: .didAppear)
//        #expect(viewModel.state.animals == .loaded(animals))
    }
    
    @Test("on didSelect animal")
    func didSelectAnimal() async {
        let result: Animal = .fixture()
        var selectedAnimal: Animal?
        let viewModel = sut(
            animals: .success(Animal.fixture()),
            selectedAnimal: { selectedAnimal = $0 }
        )
        await viewModel.handle(event: .didSelect(result))
        #expect(selectedAnimal == result)
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
