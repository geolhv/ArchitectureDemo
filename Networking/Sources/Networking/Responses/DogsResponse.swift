public struct DogsResponse: Decodable {
    public let name: String
    public let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_link"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
}
