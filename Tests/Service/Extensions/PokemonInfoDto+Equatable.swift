@testable import Service

extension PokemonInfoDto.TypeSlotDto: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.slot == rhs.slot &&
        lhs.type == rhs.type
    }
}

extension PokemonInfoDto.TypeDto: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name &&
        lhs.url == rhs.url
    }
}
