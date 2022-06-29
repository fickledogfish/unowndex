import XCTest

@testable import Service

final class PokemonServiceTests: XCTestCase {
    private let pokemonMock = PokemonInfoDto(
        id: 618,
        name: "stunfisk"
    )

    private var api: PokeAPIMock!
    private var sut: PokemonService!

    override func setUp() {
        api = PokeAPIMock()

        sut = PokemonService(api)
    }

    func testInfoShouldRouteTheInformationReturnedByTheAPI() async {
        // Arrange
        api.pokemonNationalDexIdWith = { [weak self] _ in
            self?.pokemonMock
        }

        // Act
        let pokemon = await sut.info(nationalDexId: 13)

        // Assert
        XCTAssertNotNil(pokemon)
        XCTAssertEqual(pokemon?.id, pokemonMock.id)
    }
}
