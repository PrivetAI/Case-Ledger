import SwiftUI

enum Ink {
    // Deep ink green / charcoal noir base
    static let night = Color(red: 0.055, green: 0.106, blue: 0.090)
    static let deep = Color(red: 0.078, green: 0.141, blue: 0.118)
    static let panel = Color(red: 0.102, green: 0.176, blue: 0.149)
    static let panelLight = Color(red: 0.133, green: 0.220, blue: 0.184)
    static let charcoal = Color(red: 0.118, green: 0.133, blue: 0.129)
    static let line = Color(red: 0.231, green: 0.318, blue: 0.275)

    // Gaslamp amber
    static let amber = Color(red: 0.957, green: 0.700, blue: 0.290)
    static let amberDim = Color(red: 0.733, green: 0.541, blue: 0.255)
    static let amberGlow = Color(red: 1.000, green: 0.870, blue: 0.560)

    // Parchment
    static let parchment = Color(red: 0.910, green: 0.855, blue: 0.720)
    static let parchmentDim = Color(red: 0.741, green: 0.682, blue: 0.553)
    static let parchmentFaint = Color(red: 0.557, green: 0.529, blue: 0.443)

    // Accents
    static let bloodWax = Color(red: 0.553, green: 0.184, blue: 0.157)
    static let waxBright = Color(red: 0.706, green: 0.255, blue: 0.216)
    static let verdigris = Color(red: 0.357, green: 0.553, blue: 0.467)
    static let fog = Color(red: 0.800, green: 0.780, blue: 0.660)
}

enum Quill {
    static func serif(_ size: CGFloat) -> Font {
        Font.custom("Georgia", size: size)
    }
    static func serifBold(_ size: CGFloat) -> Font {
        Font.custom("Georgia-Bold", size: size)
    }
    static func serifItalic(_ size: CGFloat) -> Font {
        Font.custom("Georgia-Italic", size: size)
    }
}

/// Frame helper: clamps content width so layouts stay centered and sane when the
/// app runs letterboxed or scaled on iPad (TARGETED_DEVICE_FAMILY stays iPhone-only).
struct ContentWidthClamp: ViewModifier {
    var maxW: CGFloat = 560
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: maxW)
            .frame(maxWidth: .infinity)
    }
}

extension View {
    func clampedContentWidth(_ maxW: CGFloat = 560) -> some View {
        modifier(ContentWidthClamp(maxW: maxW))
    }
}

/// Parchment-style card background.
struct InkCard: ViewModifier {
    var padding: CGFloat = 14
    var stroke: Color = Ink.line
    var fill: Color = Ink.panel
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(fill)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(stroke, lineWidth: 1)
                    )
            )
    }
}

extension View {
    func inkCard(padding: CGFloat = 14, stroke: Color = Ink.line, fill: Color = Ink.panel) -> some View {
        modifier(InkCard(padding: padding, stroke: stroke, fill: fill))
    }
}

/// Standard wide action button.
struct LampButtonStyle: ButtonStyle {
    var prominent: Bool = true
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 13)
            .padding(.horizontal, 18)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(prominent ? Ink.amber : Ink.panelLight)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .stroke(prominent ? Ink.amberGlow.opacity(0.6) : Ink.line, lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.75 : 1)
            .scaleEffect(configuration.isPressed ? 0.985 : 1)
    }
}

/// Background gradient used on every screen.
struct GaslightBackdrop: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Ink.deep, Ink.night]),
            startPoint: .top, endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}
