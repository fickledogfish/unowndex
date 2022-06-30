import Foundation

import Data

internal struct PokemonSpeciesInfoDto: Decodable {
    let id: Int
    let name: String
    let flavorTextEntries: [FlavorTextEntryDto]

    internal struct FlavorTextEntryDto: Decodable {
        let flavorText: String
        let language: LanguageDto
        let version: VersionDto
    }

    internal struct LanguageDto: Decodable {
        let name: Language
        let url: URL
    }

    internal struct VersionDto: Decodable {
        let name: PokemonGame
        let url: URL
    }
}
