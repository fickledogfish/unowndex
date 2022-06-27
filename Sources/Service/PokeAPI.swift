import Foundation

internal protocol PokeAPIQueryable {
    func pokemon(nationalDexId: Int) async -> Pokemon?
}

internal struct PokeAPI: PokeAPIQueryable {
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2")!

    private let httpClient: HttpGettable
    private let decoder: Decoder

    init(
        httpClient: HttpGettable = HttpClient(),
        decoder: Decoder = JSONDecoder()
    ) {
        self.httpClient = httpClient
        self.decoder = decoder
    }

    func pokemon(nationalDexId: Int) async -> Pokemon? {
        let url = baseUrl
            .appendingPathComponent("pokemon")
            .appendingPathComponent(String(nationalDexId))

        switch await httpClient.get(url) {
        case .success(let data):
            return try? decoder.decode(Pokemon.self, from: data)

        case .failure:
            return nil
        }
    }
}

struct Pokemon: Decodable {
    let id: Int
    let name: String
}
