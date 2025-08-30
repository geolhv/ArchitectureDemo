public protocol TrackableScreen: Equatable {
    var rawValue: String { get }
}

public struct Tracker {
    public init() {}
    
    public func track(screen: any TrackableScreen) {
        print("log event: screen \(screen.rawValue)")
    }
}
