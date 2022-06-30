@testable import Service

extension PokemonSpeciesInfoDto: Encodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
