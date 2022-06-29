import Data

internal extension PokemonInfo {
    init(dto: PokemonInfoDto) {
        self.init(
            id: dto.id
        )
    }
}
