import Foundation

internal extension Encodable {
    var asJSONData: Data {
        // swiftlint:disable force_try
        try! JSONEncoder().encode(self)
        // swiftlint:enable force_try
    }
}
