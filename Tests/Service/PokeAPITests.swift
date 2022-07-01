import Foundation
import XCTest

@testable import Service

// MARK: - PokeAPI.pokemon

final class PokeAPIPokemonTests: XCTestCase {
    private var httpClientMock: HttpClientMock!
    private var decoderMock: DecoderMock!
    private var sut: PokeAPI!

    override func setUp() {
        httpClientMock = HttpClientMock()
        decoderMock = DecoderMock()

        decoderMock.decodeWith = {
            try JSONDecoder().decode(PokemonInfoDto.self, from: $0)
        }

        httpClientMock.getWith = { _ in
            // swiftlint:disable force_try
            .success(try! JSONEncoder().encode(SampleData.pokemonInfoDto))
            // swiftlint:enable force_try
        }

        sut = PokeAPI(
            httpClient: httpClientMock,
            decoder: decoderMock
        )
    }

    // MARK: pokemon(nationalDexId:)

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

    func testPokemonNationalDexIdShouldDecodeTheDataReturnedByTheHttpClient() async {
        // Act
        let result = await sut.pokemon(nationalDexId: SampleData.pokemonInfoDto.id)

        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, SampleData.pokemonInfoDto.id)
        XCTAssertEqual(result?.name, SampleData.pokemonInfoDto.name)
    }

    // MARK: pokemon(name:)

    func testPokemonNameShouldCallHttpClientGetWithCorrectData() async {
        // Arrange
        let name = "torchic"

        var httpClientGetWasCalled = false
        var urlRequestedByClient: URL!

        httpClientMock.getWith = { url in
            httpClientGetWasCalled = true
            urlRequestedByClient = url
            return .success(Data())
        }

        // Act
        _ = await sut.pokemon(name: name)

        // Assert
        XCTAssertTrue(httpClientGetWasCalled)
        XCTAssertEqual(
            urlRequestedByClient,
            URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)")!
        )
    }

    func testPokemonNameShouldDecodeTheDataReturnedByTheHttpClient() async {
        // Act
        let result = await sut.pokemon(name: SampleData.pokemonInfoDto.name)

        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, SampleData.pokemonInfoDto.id)
        XCTAssertEqual(result?.name, SampleData.pokemonInfoDto.name)
        XCTAssertEqual(result?.types, SampleData.pokemonInfoDto.types)
    }
}

// MARK: - PokeAPI.pokemonSpecies

final class PokeAPIPokemonSpeciesTests: XCTestCase {
    private var httpClientMock: HttpClientMock!
    private var decoderMock: DecoderMock!
    private var sut: PokeAPI!

    override func setUp() {
        httpClientMock = HttpClientMock()
        decoderMock = DecoderMock()

        decoderMock.decodeWith = {
            try JSONDecoder().decode(PokemonSpeciesInfoDto.self, from: $0)
        }

        httpClientMock.getWith = { _ in
            // swiftlint:disable force_try
            .success(try! JSONEncoder().encode(SampleData.pokemonSpeciesInfoDto))
            // swiftlint:enable force_try
        }

        sut = PokeAPI(
            httpClient: httpClientMock,
            decoder: decoderMock
        )
    }

    // MARK: - pokemonSpecies(nationalDexId:)

    func testPokemonSpeciesNationalDexShouldDecodeTheDataReturnedByTheHttpClient() async {
        // Act
        let result = await sut.pokemonSpecies(
            nationalDexId: SampleData.pokemonSpeciesInfoDto.id
        )

        // Assert
        XCTAssertEqual(result?.id, SampleData.pokemonSpeciesInfoDto.id)
    }
}
