import Foundation

internal protocol Decoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: Decoder {}
