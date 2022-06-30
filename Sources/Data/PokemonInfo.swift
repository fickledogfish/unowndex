public struct PokemonInfo {
    public let id: Int
    public let types: Types

    public init(
        id: Int,
        types: Types
    ) {
        self.id = id
        self.types = types
    }

    public enum Types {
        case single(PokemonType)
        case double(PokemonType, PokemonType)
    }
}
