import Foundation

import Data

internal struct PokemonInfoDto: Decodable {
    let id: Int
    let name: String
    let types: [TypeSlotDto]

    internal struct TypeSlotDto: Decodable {
        let slot: Int
        let type: TypeDto
    }

    internal struct TypeDto: Decodable {
        let name: PokemonType
        let url: URL
    }
}
