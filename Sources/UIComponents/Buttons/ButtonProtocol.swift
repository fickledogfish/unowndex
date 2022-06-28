import SwiftUI

@available(iOS 13, macOS 10.15, *)
public protocol ButtonProtocol {
    associatedtype Label: View

    init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    )
}

@available(iOS 13, macOS 10.15, *)
public extension ButtonProtocol where Label == Text {
    init<S: StringProtocol>(_ label: S, action: @escaping () -> Void) {
        self.init(action: action, label: {
            Text(label)
        })
    }
}
