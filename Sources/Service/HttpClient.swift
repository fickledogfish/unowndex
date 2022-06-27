import Foundation

internal protocol HttpGettable {
    func get(_ url: URL) async -> Result<Data, Error>
}

internal struct HttpClient {
}

extension HttpClient: HttpGettable {
    func get(_ url: URL) async -> Result<Data, Error> {
        // swiftlint:disable force_cast
        .failure("" as! Error)
        // swiftlint:enable force_cast
    }
}
