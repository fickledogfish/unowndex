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
        name: "quilava",
        flavorTextEntries: [ .init(
            flavorText: "Be careful if it turns its back during battle. " +
                "It means that it will attack with the fire on its back.",
            language: .init(
                name: .english,
                url: URL(string: "https://pokeapi.co/api/v2/language/9/")!
            ),
            version: .init(
                name: .gold,
                url: URL(string: "https://pokeapi.co/api/v2/version/4/")!
            )
        ) ]
    )
}
