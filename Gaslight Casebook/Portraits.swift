import SwiftUI

/// Renders a Victorian bust portrait from a PortraitSpec using only shapes.
struct PortraitView: View {
    let spec: PortraitSpec
    var size: CGFloat

    private static let skins: [Color] = [
        Color(red: 0.91, green: 0.76, blue: 0.62),
        Color(red: 0.82, green: 0.64, blue: 0.48),
        Color(red: 0.66, green: 0.48, blue: 0.35),
        Color(red: 0.47, green: 0.33, blue: 0.24)
    ]
    private static let hairColors: [Color] = [
        Color(red: 0.16, green: 0.13, blue: 0.11),   // black-brown
        Color(red: 0.38, green: 0.26, blue: 0.16),   // chestnut
        Color(red: 0.62, green: 0.46, blue: 0.26),   // fair
        Color(red: 0.72, green: 0.71, blue: 0.68),   // grey
        Color(red: 0.50, green: 0.24, blue: 0.14)    // auburn
    ]
    private static let coats: [Color] = [
        Color(red: 0.16, green: 0.18, blue: 0.20),   // charcoal
        Color(red: 0.22, green: 0.16, blue: 0.12),   // brown
        Color(red: 0.12, green: 0.20, blue: 0.18),   // bottle green
        Color(red: 0.16, green: 0.16, blue: 0.26),   // navy
        Color(red: 0.32, green: 0.12, blue: 0.12),   // oxblood
        Color(red: 0.30, green: 0.26, blue: 0.20),   // tweed
        Color(red: 0.24, green: 0.22, blue: 0.28),   // plum grey
        Color(red: 0.36, green: 0.32, blue: 0.26)    // sand wool
    ]

    private var skin: Color { Self.skins[max(0, min(3, spec.skin))] }
    private var hairC: Color { Self.hairColors[max(0, min(4, spec.hairColor))] }
    private var coatC: Color { Self.coats[max(0, min(7, spec.coat))] }

    var body: some View {
        ZStack {
            // Backplate: oval cameo on dim panel
            RoundedRectangle(cornerRadius: size * 0.10)
                .fill(Ink.panelLight)
            Ellipse()
                .fill(Ink.deep)
                .frame(width: size * 0.84, height: size * 0.92)
                .offset(y: size * 0.04)

            bust
            head
            hairBack
            face
            hairFront
            facialHair
            collar
            hatView
            eyewear

            RoundedRectangle(cornerRadius: size * 0.10)
                .stroke(Ink.line, lineWidth: 1)
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: size * 0.10))
    }

    // MARK: components

    private var bust: some View {
        ZStack {
            // shoulders / coat
            Path { p in
                let w = size, h = size
                p.move(to: CGPoint(x: w * 0.10, y: h))
                p.addQuadCurve(to: CGPoint(x: w * 0.50, y: h * 0.66),
                               control: CGPoint(x: w * 0.16, y: h * 0.70))
                p.addQuadCurve(to: CGPoint(x: w * 0.90, y: h),
                               control: CGPoint(x: w * 0.84, y: h * 0.70))
                p.closeSubpath()
            }
            .fill(coatC)
            // lapel shading
            Path { p in
                let w = size, h = size
                p.move(to: CGPoint(x: w * 0.5, y: h * 0.70))
                p.addLine(to: CGPoint(x: w * 0.40, y: h))
                p.addLine(to: CGPoint(x: w * 0.60, y: h))
                p.closeSubpath()
            }
            .fill(Color.black.opacity(0.22))
        }
    }

    private var head: some View {
        // neck
        Rectangle()
            .fill(skin)
            .frame(width: size * 0.16, height: size * 0.18)
            .offset(y: size * 0.20)
    }

    private var face: some View {
        ZStack {
            Ellipse()
                .fill(skin)
                .frame(width: size * 0.40, height: size * 0.48)
                .offset(y: -size * 0.04)
            // ears
            Circle().fill(skin).frame(width: size * 0.08, height: size * 0.08)
                .offset(x: -size * 0.20, y: -size * 0.03)
            Circle().fill(skin).frame(width: size * 0.08, height: size * 0.08)
                .offset(x: size * 0.20, y: -size * 0.03)
            // eyes
            Capsule().fill(Ink.charcoal)
                .frame(width: size * 0.055, height: size * 0.035)
                .offset(x: -size * 0.085, y: -size * 0.07)
            Capsule().fill(Ink.charcoal)
                .frame(width: size * 0.055, height: size * 0.035)
                .offset(x: size * 0.085, y: -size * 0.07)
            // brows
            Capsule().fill(hairC.opacity(0.85))
                .frame(width: size * 0.09, height: size * 0.022)
                .offset(x: -size * 0.085, y: -size * 0.115)
            Capsule().fill(hairC.opacity(0.85))
                .frame(width: size * 0.09, height: size * 0.022)
                .offset(x: size * 0.085, y: -size * 0.115)
            // nose
            Path { p in
                p.move(to: CGPoint(x: size * 0.5, y: size * 0.42))
                p.addLine(to: CGPoint(x: size * 0.475, y: size * 0.50))
                p.addLine(to: CGPoint(x: size * 0.515, y: size * 0.505))
            }
            .stroke(Color.black.opacity(0.30), lineWidth: max(1, size * 0.012))
            // mouth (hidden under big facial hair anyway)
            if spec.facial == FacialHairKind.none || spec.facial == .sideburns {
                Capsule().fill(Color(red: 0.62, green: 0.36, blue: 0.30))
                    .frame(width: size * 0.11, height: size * 0.024)
                    .offset(y: size * 0.085)
            }
            // cheek shading
            Ellipse().fill(Color.black.opacity(0.05))
                .frame(width: size * 0.40, height: size * 0.16)
                .offset(y: size * 0.12)
        }
    }

    private var hairBack: some View {
        Group {
            switch spec.hair {
            case .long:
                Ellipse().fill(hairC)
                    .frame(width: size * 0.50, height: size * 0.66)
                    .offset(y: size * 0.02)
            case .bun:
                ZStack {
                    Ellipse().fill(hairC)
                        .frame(width: size * 0.46, height: size * 0.40)
                        .offset(y: -size * 0.16)
                    Circle().fill(hairC)
                        .frame(width: size * 0.16, height: size * 0.16)
                        .offset(x: size * 0.16, y: -size * 0.27)
                }
            case .wave:
                Ellipse().fill(hairC)
                    .frame(width: size * 0.50, height: size * 0.50)
                    .offset(y: -size * 0.08)
            default:
                EmptyView()
            }
        }
    }

    private var hairFront: some View {
        Group {
            switch spec.hair {
            case .bald:
                Path { p in
                    p.addArc(center: CGPoint(x: size * 0.5, y: size * 0.30),
                             radius: size * 0.205,
                             startAngle: .degrees(190), endAngle: .degrees(225), clockwise: false)
                }
                .stroke(hairC, lineWidth: size * 0.035)
            case .cropped:
                CrownArc(extra: 0.0).fill(hairC)
            case .side:
                ZStack {
                    CrownArc(extra: 0.02).fill(hairC)
                    Path { p in
                        p.move(to: CGPoint(x: size * 0.30, y: size * 0.20))
                        p.addQuadCurve(to: CGPoint(x: size * 0.62, y: size * 0.135),
                                       control: CGPoint(x: size * 0.40, y: size * 0.115))
                        p.addLine(to: CGPoint(x: size * 0.62, y: size * 0.19))
                        p.addQuadCurve(to: CGPoint(x: size * 0.32, y: size * 0.245),
                                       control: CGPoint(x: size * 0.42, y: size * 0.175))
                        p.closeSubpath()
                    }
                    .fill(hairC)
                }
            case .curly:
                ZStack {
                    CrownArc(extra: 0.02).fill(hairC)
                    ForEach(0..<5, id: \.self) { i in
                        Circle().fill(hairC)
                            .frame(width: size * 0.12, height: size * 0.12)
                            .offset(x: size * (-0.20 + 0.10 * CGFloat(i)),
                                    y: -size * (0.205 + (i % 2 == 0 ? 0.02 : 0.045)))
                    }
                }
            case .bun, .wave, .long:
                CrownArc(extra: 0.03).fill(hairC)
            case .slick:
                CrownArc(extra: -0.01).fill(hairC)
            }
        }
    }

    private struct CrownArcShapeProxy: View { var body: some View { EmptyView() } }

    private func CrownArc(extra: CGFloat) -> Path {
        var p = Path()
        let cx = size * 0.5
        let cy = size * 0.27
        let rx = size * (0.205 + extra)
        p.addArc(center: CGPoint(x: cx, y: cy), radius: rx,
                 startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
        p.addQuadCurve(to: CGPoint(x: cx - rx, y: cy),
                       control: CGPoint(x: cx, y: cy - rx * 0.4))
        p.closeSubpath()
        return p
    }

    private var facialHair: some View {
        Group {
            switch spec.facial {
            case .none:
                EmptyView()
            case .moustache:
                MoustacheShape().fill(hairC)
                    .frame(width: size * 0.20, height: size * 0.06)
                    .offset(y: size * 0.055)
            case .walrus:
                MoustacheShape().fill(hairC)
                    .frame(width: size * 0.28, height: size * 0.10)
                    .offset(y: size * 0.07)
            case .fullBeard:
                ZStack {
                    Path { p in
                        let w = size
                        p.move(to: CGPoint(x: w * 0.315, y: w * 0.40))
                        p.addQuadCurve(to: CGPoint(x: w * 0.685, y: w * 0.40),
                                       control: CGPoint(x: w * 0.5, y: w * 0.78))
                        p.addQuadCurve(to: CGPoint(x: w * 0.315, y: w * 0.40),
                                       control: CGPoint(x: w * 0.5, y: w * 0.62))
                        p.closeSubpath()
                    }
                    .fill(hairC)
                    MoustacheShape().fill(hairC)
                        .frame(width: size * 0.22, height: size * 0.07)
                        .offset(y: size * 0.055)
                }
            case .goatee:
                ZStack {
                    Ellipse().fill(hairC)
                        .frame(width: size * 0.10, height: size * 0.10)
                        .offset(y: size * 0.155)
                    MoustacheShape().fill(hairC)
                        .frame(width: size * 0.18, height: size * 0.05)
                        .offset(y: size * 0.055)
                }
            case .sideburns:
                ZStack {
                    Capsule().fill(hairC)
                        .frame(width: size * 0.055, height: size * 0.17)
                        .offset(x: -size * 0.185, y: size * 0.01)
                    Capsule().fill(hairC)
                        .frame(width: size * 0.055, height: size * 0.17)
                        .offset(x: size * 0.185, y: size * 0.01)
                }
            }
        }
    }

    private struct MoustacheShape: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            p.move(to: CGPoint(x: rect.midX, y: rect.height * 0.4))
            p.addQuadCurve(to: CGPoint(x: 0, y: rect.height * 0.55),
                           control: CGPoint(x: rect.width * 0.2, y: -rect.height * 0.3))
            p.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.height),
                           control: CGPoint(x: rect.width * 0.25, y: rect.height * 1.1))
            p.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height * 0.55),
                           control: CGPoint(x: rect.width * 0.75, y: rect.height * 1.1))
            p.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.height * 0.4),
                           control: CGPoint(x: rect.width * 0.8, y: -rect.height * 0.3))
            p.closeSubpath()
            return p
        }
    }

    private var collar: some View {
        Group {
            switch spec.collar {
            case .highCollar:
                HStack(spacing: size * 0.055) {
                    CollarWing().fill(Ink.parchment)
                        .frame(width: size * 0.085, height: size * 0.10)
                    CollarWing().fill(Ink.parchment)
                        .frame(width: size * 0.085, height: size * 0.10)
                        .scaleEffect(x: -1, y: 1)
                }
                .offset(y: size * 0.315)
            case .cravat:
                ZStack {
                    Path { p in
                        p.move(to: CGPoint(x: size * 0.40, y: size * 0.79))
                        p.addQuadCurve(to: CGPoint(x: size * 0.60, y: size * 0.79),
                                       control: CGPoint(x: size * 0.5, y: size * 0.74))
                        p.addLine(to: CGPoint(x: size * 0.56, y: size * 0.97))
                        p.addLine(to: CGPoint(x: size * 0.44, y: size * 0.97))
                        p.closeSubpath()
                    }
                    .fill(Ink.parchment)
                    Circle().fill(Ink.amberDim)
                        .frame(width: size * 0.045, height: size * 0.045)
                        .offset(y: size * 0.335)
                }
            case .shawl:
                Path { p in
                    p.move(to: CGPoint(x: size * 0.24, y: size))
                    p.addQuadCurve(to: CGPoint(x: size * 0.5, y: size * 0.72),
                                   control: CGPoint(x: size * 0.28, y: size * 0.76))
                    p.addQuadCurve(to: CGPoint(x: size * 0.76, y: size),
                                   control: CGPoint(x: size * 0.72, y: size * 0.76))
                }
                .stroke(Ink.parchmentDim, lineWidth: size * 0.05)
            case .uniform:
                ZStack {
                    Rectangle().fill(Ink.parchment.opacity(0.0))
                    ForEach(0..<3, id: \.self) { i in
                        Circle().fill(Ink.amber)
                            .frame(width: size * 0.038, height: size * 0.038)
                            .offset(y: size * (0.78 + 0.085 * CGFloat(i)) - size * 0.5)
                    }
                    Rectangle().fill(Ink.amberDim)
                        .frame(width: size * 0.30, height: size * 0.022)
                        .offset(y: size * 0.30)
                }
            case .apron:
                Path { p in
                    p.move(to: CGPoint(x: size * 0.34, y: size))
                    p.addLine(to: CGPoint(x: size * 0.36, y: size * 0.80))
                    p.addLine(to: CGPoint(x: size * 0.64, y: size * 0.80))
                    p.addLine(to: CGPoint(x: size * 0.66, y: size))
                    p.closeSubpath()
                }
                .fill(Ink.parchmentDim)
            case .clerical:
                Rectangle().fill(Color.white.opacity(0.92))
                    .frame(width: size * 0.13, height: size * 0.045)
                    .offset(y: size * 0.305)
            case .lace:
                ZStack {
                    ForEach(0..<5, id: \.self) { i in
                        Circle().fill(Ink.parchment)
                            .frame(width: size * 0.07, height: size * 0.07)
                            .offset(x: size * (-0.14 + 0.07 * CGFloat(i)), y: size * 0.31)
                    }
                    Circle().fill(Ink.bloodWax)
                        .frame(width: size * 0.05, height: size * 0.05)
                        .offset(y: size * 0.345)
                }
            }
        }
    }

    private struct CollarWing: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            p.move(to: CGPoint(x: 0, y: 0))
            p.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.35))
            p.addLine(to: CGPoint(x: rect.width * 0.55, y: rect.height))
            p.addLine(to: CGPoint(x: 0, y: rect.height * 0.7))
            p.closeSubpath()
            return p
        }
    }

    private var hatView: some View {
        Group {
            switch spec.hat {
            case .none:
                EmptyView()
            case .topHat:
                VStack(spacing: 0) {
                    Rectangle().fill(Ink.charcoal)
                        .frame(width: size * 0.34, height: size * 0.22)
                    Rectangle().fill(Ink.amberDim)
                        .frame(width: size * 0.34, height: size * 0.028)
                    Capsule().fill(Ink.charcoal)
                        .frame(width: size * 0.52, height: size * 0.05)
                }
                .offset(y: -size * 0.295)
            case .bowler:
                VStack(spacing: 0) {
                    Circle()
                        .trim(from: 0.5, to: 1.0)
                        .fill(Ink.charcoal)
                        .frame(width: size * 0.38, height: size * 0.38)
                        .frame(height: size * 0.19, alignment: .top)
                        .clipped()
                    Capsule().fill(Ink.charcoal)
                        .frame(width: size * 0.52, height: size * 0.05)
                }
                .offset(y: -size * 0.245)
            case .flatCap:
                ZStack {
                    Ellipse().fill(coatC.opacity(0.9))
                        .frame(width: size * 0.46, height: size * 0.20)
                        .offset(y: -size * 0.235)
                    Capsule().fill(Ink.charcoal)
                        .frame(width: size * 0.30, height: size * 0.045)
                        .offset(x: size * 0.06, y: -size * 0.16)
                }
            case .bonnet:
                ZStack {
                    Circle()
                        .trim(from: 0.5, to: 1.0)
                        .fill(Ink.bloodWax.opacity(0.85))
                        .frame(width: size * 0.50, height: size * 0.50)
                        .offset(y: -size * 0.10)
                    Capsule().fill(Ink.bloodWax.opacity(0.85))
                        .frame(width: size * 0.05, height: size * 0.16)
                        .rotationEffect(.degrees(25))
                        .offset(x: size * 0.20, y: -size * 0.02)
                }
            case .policeHelmet:
                VStack(spacing: 0) {
                    Circle().fill(Ink.amber)
                        .frame(width: size * 0.05, height: size * 0.05)
                    DomeShape().fill(Ink.charcoal)
                        .frame(width: size * 0.40, height: size * 0.26)
                    Capsule().fill(Ink.charcoal)
                        .frame(width: size * 0.50, height: size * 0.045)
                }
                .offset(y: -size * 0.27)
            case .wideBrim:
                ZStack {
                    Ellipse().fill(Ink.charcoal)
                        .frame(width: size * 0.62, height: size * 0.10)
                        .offset(y: -size * 0.165)
                    DomeShape().fill(Ink.charcoal)
                        .frame(width: size * 0.34, height: size * 0.18)
                        .offset(y: -size * 0.245)
                }
            case .nurseCap:
                DomeShape().fill(Color.white.opacity(0.92))
                    .frame(width: size * 0.34, height: size * 0.14)
                    .offset(y: -size * 0.245)
            }
        }
    }

    private struct DomeShape: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            p.move(to: CGPoint(x: 0, y: rect.height))
            p.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height),
                           control: CGPoint(x: rect.width / 2, y: -rect.height * 0.8))
            p.closeSubpath()
            return p
        }
    }

    private var eyewear: some View {
        Group {
            switch spec.eyewear {
            case .none:
                EmptyView()
            case .monocle:
                ZStack {
                    Circle().stroke(Ink.amberDim, lineWidth: max(1, size * 0.015))
                        .frame(width: size * 0.105, height: size * 0.105)
                        .offset(x: size * 0.085, y: -size * 0.07)
                    Path { p in
                        p.move(to: CGPoint(x: size * 0.625, y: size * 0.46))
                        p.addQuadCurve(to: CGPoint(x: size * 0.67, y: size * 0.62),
                                       control: CGPoint(x: size * 0.69, y: size * 0.52))
                    }
                    .stroke(Ink.amberDim, lineWidth: max(1, size * 0.010))
                }
            case .spectacles:
                ZStack {
                    Circle().stroke(Ink.charcoal, lineWidth: max(1, size * 0.015))
                        .frame(width: size * 0.105, height: size * 0.105)
                        .offset(x: -size * 0.085, y: -size * 0.07)
                    Circle().stroke(Ink.charcoal, lineWidth: max(1, size * 0.015))
                        .frame(width: size * 0.105, height: size * 0.105)
                        .offset(x: size * 0.085, y: -size * 0.07)
                    Rectangle().fill(Ink.charcoal)
                        .frame(width: size * 0.07, height: max(1, size * 0.012))
                        .offset(y: -size * 0.07)
                }
            case .pinceNez:
                ZStack {
                    Ellipse().stroke(Ink.amberDim, lineWidth: max(1, size * 0.014))
                        .frame(width: size * 0.095, height: size * 0.085)
                        .offset(x: -size * 0.075, y: -size * 0.07)
                    Ellipse().stroke(Ink.amberDim, lineWidth: max(1, size * 0.014))
                        .frame(width: size * 0.095, height: size * 0.085)
                        .offset(x: size * 0.075, y: -size * 0.07)
                }
            }
        }
    }
}
