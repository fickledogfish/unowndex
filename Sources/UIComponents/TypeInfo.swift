import SwiftUI

public enum TypeInfo: String, CaseIterable {
    case normal
    case fire
    case water
    case grass
    case electric
    case ice
    case fighting
    case poision
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dark
    case dragon
    case steel
    case fairy

    public var foregroundColor: Color {
        guard let bgColor = self.backgroundColor.cgColor?.components else {
            return .black
        }

        let luminosity = sqrt(
            zip(bgColor, [0.299, 0.587, 0.114]).reduce(0) { acc, next in
                let (component, weight) = next
                return acc + component * component * weight
            }
        )

        return luminosity > (186/255) ? .black : .white
    }

    public var backgroundColor: Color {
        switch self {
        case .normal:
            return Color(hex: 0xA8A878)

        case .fire:
            return Color(hex: 0xF08030)

        case .water:
            return Color(hex: 0x6890F0)

        case .grass:
            return Color(hex: 0x78C850)

        case .electric:
            return Color(hex: 0xF8D030)

        case .ice:
            return Color(hex: 0x98D8D8)

        case .fighting:
            return Color(hex: 0xC03028)

        case .poision:
            return Color(hex: 0xA040A0)

        case .ground:
            return Color(hex: 0xE0C068)

        case .flying:
            return Color(hex: 0xA890F0)

        case .psychic:
            return Color(hex: 0xF85888)

        case .bug:
            return Color(hex: 0xA8B820)

        case .rock:
            return Color(hex: 0xB8A038)

        case .ghost:
            return Color(hex: 0x705898)

        case .dark:
            return Color(hex: 0x705848)

        case .dragon:
            return Color(hex: 0x7038F8)

        case .steel:
            return Color(hex: 0xB8B8D0)

        case .fairy:
            return Color(hex: 0xF0B6BC)
        }
    }
}

@available(iOS 13, macOS 10.15, *)
internal extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255
        )
    }
}

#if DEBUG
@available(iOS 13, macOS 11.0, *)
struct TypeInfoColor_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(TypeInfo.allCases, id: \.self) { type in
            Text(type.rawValue)
                .frame(width: 120, height: 30, alignment: .center)
                .foregroundColor(type.foregroundColor)
                .background(
                    Capsule()
                        .fill(type.backgroundColor)
                )
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
#endif
