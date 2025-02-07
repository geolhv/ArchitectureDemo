import SwiftUI

struct ErrorView<Content: View>: View {
    let error: Error
    let content: () -> Content
    
    var body: some View {
        VStack {
            Text("Something went wrong: \(error.localizedDescription)\nPlease try again later.")
                .multilineTextAlignment(.center)
                .padding()
            content()
        }
    }
}
