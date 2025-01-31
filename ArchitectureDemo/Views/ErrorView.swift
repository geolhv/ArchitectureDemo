import SwiftUI

struct ErrorView: View {
    let error: Error
    
    var body: some View {
        Text("Something went wrong: \(error.localizedDescription)\nPlease try again later.")
            .multilineTextAlignment(.center)
            .padding()
    }
}
