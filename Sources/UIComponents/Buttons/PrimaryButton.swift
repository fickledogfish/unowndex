import SwiftUI

@available(iOS 13, macOS 10.15, *)
public struct PrimaryButton<Label: View>: ButtonProtocol, View {
    private let action: () -> Void
    private let label: () -> Label

    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.label = label
        self.action = action
    }

    public var body: some View {
        Button(action: action, label: label)
            .buttonStyle(Style())
    }

    private struct Style: ButtonStyle {
        @Environment(\.isEnabled) private var isEnabled

        private let backgroundEnabledColor = Color.red
        private let backgroundDisabledColor = Color.cyan

        private let foregroundEnabledColor = Color.white
        private let foregroundDisabledColor = Color.black

        private let width: CGFloat = 240
        private let height: CGFloat = 44

        func makeBody(configuration: Configuration) -> some View {
            configuration
                .label
                .frame(width: width, height: height, alignment: .center)
                .background(Capsule().fill(
                    isEnabled ? backgroundEnabledColor : backgroundDisabledColor
                ))
                .foregroundColor(
                    isEnabled ? foregroundEnabledColor : foregroundDisabledColor
                )
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 13, macOS 11.0, *)
struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group { // MARK: Light mode
                PrimaryButton(action: {}, label: {
                    HStack {
                        Image(systemName: "signature")
                        Text("Sell your soul")
                    }
                })
                .previewDisplayName("With custom view inside")

                PrimaryButton("Text", action: {})
                    .previewDisplayName("Using the default inner view")

                PrimaryButton("You can't click on me", action: {})
                    .disabled(true)
                    .previewDisplayName("Disabled")
            }
            .preferredColorScheme(.light)

            Group { // MARK: Dark mode
                PrimaryButton("Some text", action: {})
                    .previewDisplayName("Enabled with dark color scheme")

                PrimaryButton("Still can't click on me", action: {})
                    .disabled(true)
                    .previewDisplayName("Disabled with dark color scheme")
            }
            .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
