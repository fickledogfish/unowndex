import SwiftUI

@available(iOS 13, macOS 10.15, *)
public struct Cell: View {
    private let id: Int
    private let name: String

    public init(
        id: Int,
        name: String
    ) {
        self.id = id
        self.name = name
    }

    public var body: some View {
        VStack {
            HStack {
                Image(systemName: "star")
                    .frame(width: 50, height: 50, alignment: .center)

                VStack(alignment: .leading) {
                    Text("\(id)")
                        .font(.footnote)
                        .fontWeight(.light)

                    Text(name)
                }
            }

            TypeBadge(.grass, .fire)
        }
    }
}

#if DEBUG
@available(iOS 13, macOS 11.0, *)
struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                Cell(id: 495, name: "Snivy")
            }
            .preferredColorScheme(.light)

            Group {
                Cell(id: 495, name: "Snivy")
            }
            .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
