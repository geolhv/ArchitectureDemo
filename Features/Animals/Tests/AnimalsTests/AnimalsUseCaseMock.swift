@testable import Animals
import Foundation

final class AnimalsUseCaseMock: AnimalsUseCase {
    let results: Result<[Animal], Error>
    
    init(results: Result<[Animal], Error>) {
        self.results = results
    }
    
    func get() async throws -> [Animal] {
        switch results {
        case .success(let animals):
            return animals
        case .failure(let error):
            throw error
        }
    }
}
