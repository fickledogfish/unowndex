@testable import Service

final class PokeAPIMock: PokeAPIQueryable {
    public var pokemonNationalDexIdWith: (Int) -> PokemonInfoDto? = { _ in nil }

    public func pokemon(nationalDexId: Int) async -> PokemonInfoDto? {
        pokemonNationalDexIdWith(nationalDexId)
    }

    public var pokemonSpeciesNationalDexIdWith: (Int) -> PokemonSpeciesInfoDto? = { _ in nil }

    public func pokemonSpecies(nationalDexId: Int) async -> PokemonSpeciesInfoDto? {
        pokemonSpeciesNationalDexIdWith(nationalDexId)
    }
}
