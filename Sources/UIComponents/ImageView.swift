import SwiftUI
import Kingfisher

public struct RemoteImageView<Placeholder: View>: View {
    private let url: URL
    private var placeholder: () -> Placeholder

    init(
        _ url: URL,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.placeholder = placeholder
    }

    init(_ url: URL) where Placeholder == ProgressView<EmptyView, EmptyView> {
        self.init(url, placeholder: { ProgressView() })
    }

    public var body: some View {
        KFImage
            .url(url)
            .placeholder(placeholder)
    }

    public mutating func placeholder(
        @ViewBuilder _ view: @escaping () -> Placeholder
    ) -> Self {
        self.placeholder = view
        return self
    }
}
