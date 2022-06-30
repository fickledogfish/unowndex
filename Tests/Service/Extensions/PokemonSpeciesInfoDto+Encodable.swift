@testable import Service

extension PokemonSpeciesInfoDto: Encodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case flavorTextEntries
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(flavorTextEntries, forKey: .flavorTextEntries)
    }
}

extension PokemonSpeciesInfoDto.FlavorTextEntryDto: Encodable {
    enum CodingKeys: String, CodingKey {
        case flavorText
        case language
        case version
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(flavorText, forKey: .flavorText)
        try container.encode(language, forKey: .language)
        try container.encode(version, forKey: .version)
    }
}

extension PokemonSpeciesInfoDto.LanguageDto: Encodable {
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

extension PokemonSpeciesInfoDto.VersionDto: Encodable {
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
