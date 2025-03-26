import Foundation

public struct Animal: Hashable, Identifiable {
    public var id: String { "\(name)\(characteristic)" }
    public let name: String
    public let imageUrl: String
    public let characteristic: Characteristic
}

public extension Animal {
    enum Characteristic: String {
        case amphibian
        case fish
        case mammal
        case bird
        case reptile
        
        public var name: String {
            rawValue.capitalized
        }
    }
}
