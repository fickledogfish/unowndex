@testable import Service

final class PokeAPIMock: PokeAPIQueryable {
    public var pokemonNationalDexIdWith: (Int) -> PokemonInfoDto? = { _ in nil }

    public func pokemon(nationalDexId: Int) async -> PokemonInfoDto? {
        pokemonNationalDexIdWith(nationalDexId)
    }
}
