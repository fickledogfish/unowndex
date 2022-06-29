import SwiftUI
import Kingfisher

public struct RemoteImageView<Placeholder: View>: View {
    private let url: URL
    private var placeholder: () -> Placeholder

    public init(
        _ url: URL,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.placeholder = placeholder
    }

    public init(_ url: URL) where Placeholder == ProgressView<EmptyView, EmptyView> {
        self.init(url, placeholder: { ProgressView() })
    }

    public var body: some View {
        KFAnimatedImage
            .url(url)
            .placeholder(placeholder)
            .scaledToFit()
    }

    public mutating func placeholder(
        @ViewBuilder _ view: @escaping () -> Placeholder
    ) -> Self {
        self.placeholder = view
        return self
    }
}
