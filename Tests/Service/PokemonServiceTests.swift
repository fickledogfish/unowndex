import XCTest

@testable import Service

final class PokemonServiceTests: XCTestCase {
    private var api: PokeAPIMock!
    private var sut: PokemonService!

    override func setUp() {
        api = PokeAPIMock()

        sut = PokemonService(api)
    }

    func testInfoShouldRouteTheInformationReturnedByTheAPI() async {
        // Arrange
        api.pokemonNationalDexIdWith = { _ in
            Example.pokemonInfoDto
        }

        // Act
        let pokemon = await sut.info(nationalDexId: 13)

        // Assert
        XCTAssertNotNil(pokemon)
        XCTAssertEqual(pokemon?.id, Example.pokemonInfoDto.id)
    }
}
