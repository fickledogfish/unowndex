import Foundation

import Data

internal struct PokeAPI {
    private static let baseUrl = URL(string: "https://pokeapi.co/api/v2")!

    private let httpClient: HttpGettable
    private let decoder: Decoder

    internal init(
        httpClient: HttpGettable = HttpClient(),
        decoder: Decoder = JSONDecoder()
    ) {
        self.httpClient = httpClient
        self.decoder = decoder
    }
}

// MARK: - PokemonQueryable

internal protocol PokemonQueryable {
    func pokemon(nationalDexId: Int) async -> PokemonInfoDto?
    func pokemon(name: String) async -> PokemonInfoDto?
}

extension PokeAPI: PokemonQueryable {
    private static let pokemonUrl = baseUrl
        .appendingPathComponent("pokemon")

    internal func pokemon(nationalDexId: Int) async -> PokemonInfoDto? {
        let url = Self.pokemonUrl
            .appendingPathComponent(String(nationalDexId))

        switch await httpClient.get(url) {
        case .success(let data):
            return try? decoder.decode(PokemonInfoDto.self, from: data)

        case .failure:
            return nil
        }
    }

    internal func pokemon(name: String) async -> PokemonInfoDto? {
        let url = Self.pokemonUrl
            .appendingPathComponent(name)

        switch await httpClient.get(url) {
        case .success(let data):
            return try? decoder.decode(PokemonInfoDto.self, from: data)

        case .failure:
            return nil
        }
    }
}

// MARK: - PokemonSpeciesQueryable

internal protocol PokemonSpeciesQueryable {
    func pokemonSpecies(nationalDexId: Int) async -> PokemonSpeciesInfoDto?
}

extension PokeAPI: PokemonSpeciesQueryable {
    private static let pokemonSpeciesUrl = baseUrl
        .appendingPathComponent("pokemon-species")

    internal func pokemonSpecies(nationalDexId: Int) async -> PokemonSpeciesInfoDto? {
        let url = Self.pokemonSpeciesUrl
            .appendingPathComponent(String(nationalDexId))

        switch await httpClient.get(url) {
        case .success(let data):
            return try? decoder.decode(PokemonSpeciesInfoDto.self, from: data)

        case .failure:
            return nil
        }
    }
}
