@testable import Service

final class PokeAPIMock: PokeAPIQueryable {
    // MARK: - /pokemon

    public var pokemonNationalDexIdWith: (Int) -> PokemonInfoDto? = { _ in nil }

    public func pokemon(nationalDexId: Int) async -> PokemonInfoDto? {
        pokemonNationalDexIdWith(nationalDexId)
    }

    public var pokemonNameWith: (String) -> PokemonInfoDto? = { _ in nil}

    public func pokemon(name: String) async -> PokemonInfoDto? {
        pokemonNameWith(name)
    }

    // MARK: - /pokemon-species

    public var pokemonSpeciesNationalDexIdWith: (Int) -> PokemonSpeciesInfoDto? = { _ in nil }

    public func pokemonSpecies(nationalDexId: Int) async -> PokemonSpeciesInfoDto? {
        pokemonSpeciesNationalDexIdWith(nationalDexId)
    }
}
