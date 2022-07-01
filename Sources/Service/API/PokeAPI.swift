import Foundation
import Data

internal protocol PokeAPIQueryable {
    func pokemon(nationalDexId: Int) async -> PokemonInfoDto?
    func pokemon(name: String) async -> PokemonInfoDto?

    func pokemonSpecies(nationalDexId: Int) async -> PokemonSpeciesInfoDto?
}

internal struct PokeAPI: PokeAPIQueryable {
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2")!

    private let httpClient: HttpGettable
    private let decoder: Decoder

    internal init(
        httpClient: HttpGettable = HttpClient(),
        decoder: Decoder = JSONDecoder()
    ) {
        self.httpClient = httpClient
        self.decoder = decoder
    }

    // MARK: - /pokemon

    internal func pokemon(nationalDexId: Int) async -> PokemonInfoDto? {
        let url = baseUrl
            .appendingPathComponent("pokemon")
            .appendingPathComponent(String(nationalDexId))

        switch await httpClient.get(url) {
        case .success(let data):
            return try? decoder.decode(PokemonInfoDto.self, from: data)

        case .failure:
            return nil
        }
    }

    internal func pokemon(name: String) async -> PokemonInfoDto? {
        let url = baseUrl
            .appendingPathComponent("pokemon")
            .appendingPathComponent(name)

        switch await httpClient.get(url) {
        case .success(let data):
            return try? decoder.decode(PokemonInfoDto.self, from: data)

        case .failure:
            return nil
        }
    }

    // MARK: - /pokemon-species

    internal func pokemonSpecies(nationalDexId: Int) async -> PokemonSpeciesInfoDto? {
        let url = baseUrl
            .appendingPathComponent("pokemon-species")
            .appendingPathComponent(String(nationalDexId))

        switch await httpClient.get(url) {
        case .success(let data):
            return try? decoder.decode(PokemonSpeciesInfoDto.self, from: data)

        case .failure:
            return nil
        }
    }
}
