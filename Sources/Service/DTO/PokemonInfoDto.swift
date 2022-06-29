import Foundation

import Data

internal struct PokemonInfoDto: Decodable {
    let id: Int
    let name: String
}

internal struct PokemonTypeSlotDto: Decodable {
    let slot: Int
    let type: PokemonTypeDto
}

internal struct PokemonTypeDto: Decodable {
    let name: PokemonType
    let url: URL
}
