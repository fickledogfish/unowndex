import Data

public protocol PokemonServiceable {
    func info(nationalDexId: Int) async -> PokemonInfo?
}

public struct PokemonService: PokemonServiceable {
    typealias Queryable = PokemonQueryable & PokemonSpeciesQueryable

    private let api: Queryable

    public init() {
        self.init(PokeAPI())
    }

    internal init(_ api: Queryable) {
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
