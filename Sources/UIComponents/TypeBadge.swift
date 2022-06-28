import SwiftUI

@available(iOS 13, macOS 10.15, *)
public struct TypeBadge: View {
    private let type1: PokemonType
    private let type2: PokemonType?

    private let font = Font.caption
        .weight(.semibold)

    private let typeCellWidth = 60.0
    private let height = 25.0
    private let horizontalPadding = 6.0

    init(_ type: PokemonType) {
        self.type1 = type
        self.type2 = nil
    }

    init(_ type1: PokemonType, _ type2: PokemonType) {
        self.type1 = type1
        self.type2 = type1 == type2 ? nil : type2
    }

    public var body: some View {
        HStack {
            Text(type1.rawValue)
                .font(font)
                .foregroundColor(type1.foregroundColor)
                .padding(.horizontal, type2 == nil ? 0 : horizontalPadding)
                .frame(
                    width: type2 == nil ? typeCellWidth * 2 : typeCellWidth + horizontalPadding,
                    height: height,
                    alignment: .center
                )

            if let type2 = type2 {
                Text(type2.rawValue)
                    .font(font)
                    .foregroundColor(type2.foregroundColor)
                    .padding(.trailing, horizontalPadding)
                    .frame(
                        width: typeCellWidth,
                        height: height,
                        alignment: .center
                    )
            }
        }
        .frame(
            width: (typeCellWidth + horizontalPadding) * 2,
            height: height,
            alignment: .center
        )
        .background(
            Capsule().fill(LinearGradient(
                gradient: Gradient(stops: [ .init(
                    color: type1.backgroundColor,
                    location: 0.46
                ), .init(
                    color: type2?.backgroundColor ?? type1.backgroundColor,
                    location: 0.54
                ) ] ),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
        )
    }
}

#if DEBUG
@available(iOS 13, macOS 11.0, *)
struct TypeInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                TypeBadge(.grass)

                TypeBadge(.fighting, .electric)
            }
            .preferredColorScheme(.light)

            Group {
                TypeBadge(.grass)

                TypeBadge(.water, .ice)
            }
            .preferredColorScheme(.dark)

            Group { VStack { ForEach(
                PokemonType.allCases.shuffled().prefix(3),
                id: \.self
            ) { type1 in
                HStack { ForEach(
                    PokemonType.allCases.shuffled().prefix(2),
                    id: \.self
                ) { type2 in
                    TypeBadge(type1, type2)
                } }
            } } }
            .previewDisplayName("Random combinations")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
