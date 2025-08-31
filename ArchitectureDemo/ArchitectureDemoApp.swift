import SwiftUI
import Animals

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
                .navigationDestination(for: AnimalsNavigationDestination.self) {
                    switch $0 {
                    case .detail(let animal):
                        AnimalDetailScreen(animal: animal)
                    }
                }
            }
        }
    }
}
