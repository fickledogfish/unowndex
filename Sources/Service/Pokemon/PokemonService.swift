public struct PokemonService {
    private let api: PokeAPIQueryable

    public init() {
        self.init(PokeAPI())
    }

    internal init(
        _ api: PokeAPIQueryable
    ) {
        self.api = api
    }
}
