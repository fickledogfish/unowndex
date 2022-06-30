import Foundation

@testable import Service

struct SampleData {
    private init() {}

    public static let pokemonInfoDto = PokemonInfoDto(
        id: 618,
        name: "stunfisk",
        types: [ .init(
            slot: 1,
            type: .init(
                name: .ground,
                url: URL(string: "https://pokeapi.co/api/v2/type/5/")!
            )
        ), .init(
            slot: 2,
            type: .init(
                name: .electric,
                url: URL(string: "https://pokeapi.co/api/v2/type/13/")!
            )
        ) ]
    )

    public static let pokemonSpeciesInfoDto = PokemonSpeciesInfoDto(
        id: 156,
        name: "quilava"
    )
}
