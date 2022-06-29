import Foundation

internal protocol HttpGettable {
    func get(_ url: URL) async -> Result<Data, Error>
}

internal struct HttpClient {
    // TODO: Better errors
    internal enum HttpError: Error {
        case cannotGet
    }

    private let session: URLSession

    init(
        urlSessionConfig: URLSessionConfiguration = {
            let config = URLSessionConfiguration.ephemeral
            config.httpAdditionalHeaders = [
                "Accept": "application/json"
            ]

            return config
        }()
    ) {
        self.session = URLSession(configuration: urlSessionConfig)
    }
}

extension HttpClient: HttpGettable {
    func get(_ url: URL) async -> Result<Data, Error> {
        guard
            let (data, _) = try? await session.data(from: url)
        else {
            return .failure(HttpError.cannotGet)
        }

        return .success(data)
    }
}
