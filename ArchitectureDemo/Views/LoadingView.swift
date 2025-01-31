import SwiftUI

public struct LoadingView: View {
    public var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(Color.secondary)
    }
}
