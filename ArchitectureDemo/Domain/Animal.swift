struct Animal: Hashable, Identifiable {
    var id: String { "\(name)\(characteristic)" }
    let name: String
    let imageUrl: String
    let characteristic: Characteristic
}

extension Animal {
    enum Characteristic: String {
        case amphibian
        case fish
        case mammal
        case bird
        case reptile
        
        var name: String {
            rawValue.capitalized
        }
    }
}
