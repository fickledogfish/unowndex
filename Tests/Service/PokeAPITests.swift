import Foundation
import XCTest

@testable import Service

final class PokeAPITests: XCTestCase {
    private var httpClientMock: HttpClientMock!
    private var sut: PokeAPI!

    override func setUp() {
        httpClientMock = HttpClientMock()
        sut = PokeAPI(httpClient: httpClientMock)
    }

    func testPokemonNationalDexIdShouldCallHttpClientGetWithCorrectData() async {
        // Arrange
        let id = 32 // Nidoran♂︎, in case you're wandering

        var httpClientGetWasCalled = false
        var urlRequestedByClient: URL!
        httpClientMock.getWith = { url in
            httpClientGetWasCalled = true
            urlRequestedByClient = url
            return .success(Data())
        }

        // Act
        _ = await sut.pokemon(nationalDexId: id)

        // Assert
        XCTAssertTrue(httpClientGetWasCalled)
        XCTAssertEqual(
            urlRequestedByClient,
            URL(string: "https://pokeapi.co/pokemon/\(id)")!
        )
    }
}
