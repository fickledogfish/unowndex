import Foundation

@testable import Service

final class DecoderMock: Decoder {
    public var decodeWith: ((Data) throws -> Any)!

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        // swiftlint:disable force_cast
        try decodeWith(data) as! T
        // swiftlint:enable force_cast
    }
}
