import Data

public protocol PokemonServiceable {
    func info(nationalDexId: Int) async -> PokemonInfo?
}

public struct PokemonService: PokemonServiceable {
    private let api: PokeAPIQueryable

    public init() {
        self.init(PokeAPI())
    }

    internal init(_ api: PokeAPIQueryable) {
        self.api = api
    }

    public func info(nationalDexId: Int) async -> PokemonInfo? {
        guard
            let pokemonDto = await api.pokemon(nationalDexId: nationalDexId)
        else {
            return nil
        }

        return PokemonInfo(dto: pokemonDto)
    }
}
