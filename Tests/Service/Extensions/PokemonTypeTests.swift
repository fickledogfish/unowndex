import XCTest

import Data

final class PokemonTypeTests: XCTestCase {
    private var decoder: JSONDecoder!

    override func setUp() async throws {
        decoder = JSONDecoder()
    }

    func testPokemonTypeShouldBeDecodableFromAString() {
        // Arrange
        let jsonString = "\"fire\""

        // Act
        let decodedType = try? decoder.decode(
            PokemonType.self,
            from: Data(jsonString.utf8)
        )

        // Assert
        XCTAssertNotNil(decodedType)
        XCTAssertEqual(decodedType, .fire)
    }

    func testAllTypesShouldBeDecodableFromTheirStringCounterparts() {
        for type in PokemonType.allCases {
            // Arrange
            let jsonString = "\"\(type.rawValue)\"".utf8

            // Act
            let decodedType = try? decoder.decode(
                PokemonType.self,
                from: Data(jsonString)
            )

            // Assert
            XCTAssertNotNil(decodedType)
            XCTAssertEqual(decodedType, type)
        }
    }
}
