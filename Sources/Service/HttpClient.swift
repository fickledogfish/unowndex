import Foundation

internal protocol HttpGettable {
    func get(_ url: URL) async -> Result<Data, Error>
}
