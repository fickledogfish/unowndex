import Foundation

@testable import Service

final class HttpClientMock: HttpGettable {
    public enum MockError: Error {
        case genericError
    }

    public var getWith: (URL) -> Result<Data, Error> = { _ in .success(Data()) }

    func get(_ url: URL) async -> Result<Data, Error> {
        getWith(url)
    }
}
