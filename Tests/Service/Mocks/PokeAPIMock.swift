@testable import Service

final class PokeAPIMock {
    // MARK: PokemonQueryable completions
    public var pokemonNationalDexIdWith: (Int) -> PokemonInfoDto? = { _ in nil }
    public var pokemonNameWith: (String) -> PokemonInfoDto? = { _ in nil}

    // MARK: PokemonSpeciesQueryable completions
    public var pokemonSpeciesNationalDexIdWith: (Int) -> PokemonSpeciesInfoDto? = { _ in nil }
}

// MARK: - PokemonQueryable

extension PokeAPIMock: PokemonQueryable {
    public func pokemon(nationalDexId: Int) async -> PokemonInfoDto? {
        pokemonNationalDexIdWith(nationalDexId)
    }

    public func pokemon(name: String) async -> PokemonInfoDto? {
        pokemonNameWith(name)
    }
}

// MARK: - PokemonSpeciesQueryable

extension PokeAPIMock: PokemonSpeciesQueryable {
    public func pokemonSpecies(nationalDexId: Int) async -> PokemonSpeciesInfoDto? {
        pokemonSpeciesNationalDexIdWith(nationalDexId)
    }
}
