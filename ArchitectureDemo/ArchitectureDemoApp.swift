import SwiftUI
import Domain

@main
struct ArchitectureDemoApp: App {
    @State private var path = NavigationPath()
    @State private var showBlue: Bool = true
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                AnimalsScreen(
                    viewModel: .init() { animal in
                        path.append(animal)
                    }
                )
////                AnimalsListScreen { animal in
////                    path.append(animal)
////                }
                .navigationDestination(for: Animal.self) {
                    AnimalDetailScreen(animal: $0)
                }
            }
        }
    }
}
