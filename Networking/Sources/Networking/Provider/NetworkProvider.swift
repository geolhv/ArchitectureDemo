import Foundation

public enum NetworkProvider {
    case apiNinja

    var baseUrl: URL? {
        switch self {
        case .apiNinja:
            URL(string: "https://api.api-ninjas.com")
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .apiNinja:
            ["X-Api-Key": "tmR1wsKntalX3I14QIp2ZQ==xPyfmtpo0ibAEiHM"]
        }
    }
}
