import SwiftUI

public struct LoadingView: View {
    
    public init() {}
    
    public var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(Color.secondary)
    }
}
