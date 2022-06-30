import Data

internal extension PokemonInfo {
    init(dto: PokemonInfoDto) {
        let types: PokemonInfo.Types
        switch dto.types.count {
        case 1:
            types = .single(dto.types[0].type.name)

        case 2:
            types = .double(
                dto.types[0].type.name,
                dto.types[1].type.name
            )

        default:
            fatalError()
        }

        self.init(
            id: dto.id,
            types: types
        )
    }
}
