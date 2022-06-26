import Foundation

internal protocol PokeAPIQueryable {
}

internal struct PokeAPI: PokeAPIQueryable {
    private let baseUrl = URL(string: "https://pokeapi.co")!

    private let httpClient: HttpGettable

    init(httpClient: HttpGettable) {
        self.httpClient = httpClient
    }

    func pokemon(nationalDexId: Int) async -> Data? {
        let url = baseUrl
            .appendingPathComponent("pokemon")
            .appendingPathComponent(String(nationalDexId))

        switch await httpClient.get(url) {
        case .success:
            return nil

        case .failure:
            return nil
        }
    }
}
