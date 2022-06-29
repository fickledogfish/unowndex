import Foundation
import XCTest

@testable import Service

final class PokeAPITests: XCTestCase {
    private let pokemonMock = PokemonInfoDto(
        id: 495,
        name: "snivy"
    )

    private var httpClientMock: HttpClientMock!
    private var decoderMock: DecoderMock!
    private var sut: PokeAPI!

    override func setUp() {
        httpClientMock = HttpClientMock()
        decoderMock = DecoderMock()

        decoderMock.decodeWith = {
            try JSONDecoder().decode(PokemonInfoDto.self, from: $0)
        }

        httpClientMock.getWith = { [weak self] _ in
            guard let this = self else {
                return .failure(HttpClientMock.MockError.genericError)
            }

            return .success("""
                {
                    "id": \(this.pokemonMock.id),
                    "name": "\(this.pokemonMock.name)"
                }
                """.data(using: .utf8)!)
        }

        sut = PokeAPI(
            httpClient: httpClientMock,
            decoder: decoderMock
        )
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
            URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        )
    }

    func testPokemonNationalDexShouldDecodeTheDataReturnedByTheHttpClient() async {
        // Act
        let result = await sut.pokemon(nationalDexId: pokemonMock.id)

        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, pokemonMock.id)
        XCTAssertEqual(result?.name, pokemonMock.name)
    }
}
