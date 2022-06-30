@testable import Service

extension PokemonInfoDto: Encodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(types, forKey: .types)
    }
}

extension PokemonInfoDto.TypeSlotDto: Encodable {
    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(slot, forKey: .slot)
        try container.encode(type, forKey: .type)
    }
}

extension PokemonInfoDto.TypeDto: Encodable {
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name.rawValue, forKey: .name)
        try container.encode(url, forKey: .url)
    }
}
