import SwiftUI

@available(iOS 13, macOS 10.15, *)
public struct TypeInfoCell: View {
    private let type1: TypeInfo
    private let type2: TypeInfo?

    init(_ type1: TypeInfo, _ type2: TypeInfo) {
        self.type1 = type1
        self.type2 = type2
    }

    init(_ type: TypeInfo) {
        self.type1 = type
        self.type2 = nil
    }

    private let typeCellWidth = 70.0
    private let height = 30.0
    private let horizontalPadding = 10.0

    public var body: some View {
        HStack {
            Text(type1.rawValue)
                .foregroundColor(type1.foregroundColor)
                .padding(.horizontal, type2 == nil ? 0 : horizontalPadding)
                .frame(
                    width: type2 == nil ? typeCellWidth * 2 : typeCellWidth + horizontalPadding,
                    height: height, alignment: .center
                )

            if let type2 = type2 {
                Text(type2.rawValue)
                    .foregroundColor(type2.foregroundColor)
                    .padding(.trailing, horizontalPadding)
                    .frame(width: typeCellWidth, height: height, alignment: .center)
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
                    location: 0.48
                ), .init(
                    color: type2?.backgroundColor ?? type1.backgroundColor,
                    location: 0.52
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
                TypeInfoCell(.grass)

                TypeInfoCell(.fighting, .electric)
            }
            .preferredColorScheme(.light)

            Group {
                TypeInfoCell(.grass)

                TypeInfoCell(.water, .ice)
            }
            .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
