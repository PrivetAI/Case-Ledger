import SwiftUI

// MARK: - Path shapes

struct ChevronShape: Shape {
    var pointingLeft: Bool = true
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        if pointingLeft {
            p.move(to: CGPoint(x: w * 0.66, y: h * 0.12))
            p.addLine(to: CGPoint(x: w * 0.30, y: h * 0.5))
            p.addLine(to: CGPoint(x: w * 0.66, y: h * 0.88))
        } else {
            p.move(to: CGPoint(x: w * 0.34, y: h * 0.12))
            p.addLine(to: CGPoint(x: w * 0.70, y: h * 0.5))
            p.addLine(to: CGPoint(x: w * 0.34, y: h * 0.88))
        }
        return p
    }
}

struct CheckShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.width * 0.16, y: rect.height * 0.55))
        p.addLine(to: CGPoint(x: rect.width * 0.42, y: rect.height * 0.8))
        p.addLine(to: CGPoint(x: rect.width * 0.86, y: rect.height * 0.22))
        return p
    }
}

struct CrossShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.width * 0.2, y: rect.height * 0.2))
        p.addLine(to: CGPoint(x: rect.width * 0.8, y: rect.height * 0.8))
        p.move(to: CGPoint(x: rect.width * 0.8, y: rect.height * 0.2))
        p.addLine(to: CGPoint(x: rect.width * 0.2, y: rect.height * 0.8))
        return p
    }
}

struct QuillShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width, h = rect.height
        // feather blade
        p.move(to: CGPoint(x: w * 0.88, y: h * 0.06))
        p.addQuadCurve(to: CGPoint(x: w * 0.30, y: h * 0.62),
                       control: CGPoint(x: w * 0.92, y: h * 0.52))
        p.addQuadCurve(to: CGPoint(x: w * 0.62, y: h * 0.10),
                       control: CGPoint(x: w * 0.26, y: h * 0.12))
        p.closeSubpath()
        // shaft to nib
        p.move(to: CGPoint(x: w * 0.34, y: h * 0.58))
        p.addLine(to: CGPoint(x: w * 0.14, y: h * 0.86))
        p.addLine(to: CGPoint(x: w * 0.12, y: h * 0.94))
        p.addLine(to: CGPoint(x: w * 0.20, y: h * 0.92))
        p.addLine(to: CGPoint(x: w * 0.40, y: h * 0.64))
        p.closeSubpath()
        return p
    }
}

struct GearShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let c = CGPoint(x: rect.midX, y: rect.midY)
        let rOut = min(rect.width, rect.height) * 0.48
        let rIn = rOut * 0.74
        let teeth = 8
        for i in 0..<(teeth * 2) {
            let angle = (Double(i) / Double(teeth * 2)) * 2 * .pi - .pi / 2
            let r = i % 2 == 0 ? rOut : rIn
            let pt = CGPoint(x: c.x + CGFloat(cos(angle)) * r, y: c.y + CGFloat(sin(angle)) * r)
            if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
        }
        p.closeSubpath()
        p.addEllipse(in: CGRect(x: c.x - rOut * 0.30, y: c.y - rOut * 0.30,
                                width: rOut * 0.6, height: rOut * 0.6))
        return p
    }
}

struct SealScallopShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let c = CGPoint(x: rect.midX, y: rect.midY)
        let base = min(rect.width, rect.height) * 0.46
        let bumps = 11
        var first = true
        for i in 0...(bumps * 8) {
            let t = Double(i) / Double(bumps * 8)
            let angle = t * 2 * .pi
            let r = base * (1 + 0.07 * CGFloat(sin(angle * Double(bumps))))
            let pt = CGPoint(x: c.x + CGFloat(cos(angle)) * r, y: c.y + CGFloat(sin(angle)) * r)
            if first { p.move(to: pt); first = false } else { p.addLine(to: pt) }
        }
        p.closeSubpath()
        return p
    }
}

// MARK: - Composite icon views

struct MagnifierIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: size * 0.11)
                .frame(width: size * 0.62, height: size * 0.62)
                .offset(x: -size * 0.08, y: -size * 0.08)
            Capsule()
                .fill(color)
                .frame(width: size * 0.42, height: size * 0.11)
                .rotationEffect(.degrees(45))
                .offset(x: size * 0.27, y: size * 0.27)
        }
        .frame(width: size, height: size)
    }
}

struct GasLampIcon: View {
    var size: CGFloat
    var color: Color
    var flame: Color = Ink.amber
    var body: some View {
        VStack(spacing: 0) {
            Circle().fill(color).frame(width: size * 0.10, height: size * 0.10)
            Rectangle().fill(color).frame(width: size * 0.34, height: size * 0.05)
            ZStack {
                Trapezoid()
                    .fill(color)
                    .frame(width: size * 0.40, height: size * 0.34)
                Circle().fill(flame).frame(width: size * 0.16, height: size * 0.16)
            }
            Rectangle().fill(color).frame(width: size * 0.26, height: size * 0.04)
            Rectangle().fill(color).frame(width: size * 0.08, height: size * 0.30)
            Rectangle().fill(color).frame(width: size * 0.30, height: size * 0.06)
        }
        .frame(width: size, height: size)
    }

    struct Trapezoid: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            p.move(to: CGPoint(x: rect.width * 0.12, y: 0))
            p.addLine(to: CGPoint(x: rect.width * 0.88, y: 0))
            p.addLine(to: CGPoint(x: rect.width, y: rect.height))
            p.addLine(to: CGPoint(x: 0, y: rect.height))
            p.closeSubpath()
            // glass cutout middle bar
            return p
        }
    }
}

struct QuillIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        QuillShape()
            .fill(color)
            .frame(width: size, height: size)
    }
}

struct WaxSealIcon: View {
    var size: CGFloat
    var color: Color = Ink.bloodWax
    var letter: String = ""
    var letterColor: Color = Ink.parchment
    var body: some View {
        ZStack {
            SealScallopShape().fill(color)
            Circle()
                .stroke(letterColor.opacity(0.55), lineWidth: max(1, size * 0.03))
                .frame(width: size * 0.62, height: size * 0.62)
            if !letter.isEmpty {
                Text(letter)
                    .font(Quill.serifBold(size * 0.36))
                    .foregroundColor(letterColor)
            }
        }
        .frame(width: size, height: size)
    }
}

struct FingerprintIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { i in
                Circle()
                    .trim(from: 0.05 + 0.06 * Double(i), to: 0.80 - 0.05 * Double(i))
                    .stroke(color, style: StrokeStyle(lineWidth: size * 0.055, lineCap: .round))
                    .frame(width: size * (0.9 - 0.21 * CGFloat(i)),
                           height: size * (0.9 - 0.21 * CGFloat(i)))
                    .rotationEffect(.degrees(Double(i) * 14 - 60))
            }
        }
        .frame(width: size, height: size)
    }
}

struct BookIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.06)
                .stroke(color, lineWidth: size * 0.07)
                .frame(width: size * 0.66, height: size * 0.82)
            Rectangle()
                .fill(color)
                .frame(width: size * 0.07, height: size * 0.82)
                .offset(x: -size * 0.22)
            Rectangle().fill(color)
                .frame(width: size * 0.30, height: size * 0.05)
                .offset(x: size * 0.04, y: -size * 0.18)
            Rectangle().fill(color)
                .frame(width: size * 0.30, height: size * 0.05)
                .offset(x: size * 0.04, y: -size * 0.04)
        }
        .frame(width: size, height: size)
    }
}

struct ScalesIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        ZStack {
            Rectangle().fill(color).frame(width: size * 0.06, height: size * 0.74)
            Rectangle().fill(color).frame(width: size * 0.78, height: size * 0.06)
                .offset(y: -size * 0.28)
            Circle().fill(color).frame(width: size * 0.10, height: size * 0.10)
                .offset(y: -size * 0.36)
            ForEach([-1, 1], id: \.self) { side in
                Group {
                    Path { p in
                        p.move(to: .zero)
                        p.addLine(to: CGPoint(x: -size * 0.12, y: size * 0.18))
                        p.move(to: .zero)
                        p.addLine(to: CGPoint(x: size * 0.12, y: size * 0.18))
                    }
                    .stroke(color, lineWidth: size * 0.035)
                    .frame(width: 1, height: 1)
                    .offset(x: CGFloat(side) * size * 0.36, y: -size * 0.26)
                    SemiBowl()
                        .fill(color)
                        .frame(width: size * 0.28, height: size * 0.12)
                        .offset(x: CGFloat(side) * size * 0.36, y: -size * 0.04)
                }
            }
            Rectangle().fill(color).frame(width: size * 0.40, height: size * 0.06)
                .offset(y: size * 0.40)
        }
        .frame(width: size, height: size)
    }

    struct SemiBowl: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            p.move(to: CGPoint(x: 0, y: 0))
            p.addQuadCurve(to: CGPoint(x: rect.width, y: 0),
                           control: CGPoint(x: rect.width / 2, y: rect.height * 2.2))
            p.closeSubpath()
            return p
        }
    }
}

struct MapIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        ZStack {
            Path { p in
                let w = size, h = size
                p.move(to: CGPoint(x: w * 0.12, y: h * 0.22))
                p.addLine(to: CGPoint(x: w * 0.38, y: h * 0.12))
                p.addLine(to: CGPoint(x: w * 0.62, y: h * 0.22))
                p.addLine(to: CGPoint(x: w * 0.88, y: h * 0.12))
                p.addLine(to: CGPoint(x: w * 0.88, y: h * 0.78))
                p.addLine(to: CGPoint(x: w * 0.62, y: h * 0.88))
                p.addLine(to: CGPoint(x: w * 0.38, y: h * 0.78))
                p.addLine(to: CGPoint(x: w * 0.12, y: h * 0.88))
                p.closeSubpath()
            }
            .stroke(color, lineWidth: size * 0.06)
            Path { p in
                p.move(to: CGPoint(x: size * 0.30, y: size * 0.40))
                p.addQuadCurve(to: CGPoint(x: size * 0.70, y: size * 0.56),
                               control: CGPoint(x: size * 0.52, y: size * 0.30))
            }
            .stroke(color, style: StrokeStyle(lineWidth: size * 0.045, dash: [size * 0.07, size * 0.06]))
        }
        .frame(width: size, height: size)
    }
}

struct GearIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        GearShape()
            .fill(color, style: FillStyle(eoFill: true))
            .frame(width: size, height: size)
    }
}

struct MedalIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        VStack(spacing: -size * 0.06) {
            Path { p in
                p.move(to: CGPoint(x: size * 0.30, y: 0))
                p.addLine(to: CGPoint(x: size * 0.44, y: size * 0.34))
                p.addLine(to: CGPoint(x: size * 0.16, y: size * 0.34))
                p.closeSubpath()
                p.move(to: CGPoint(x: size * 0.70, y: 0))
                p.addLine(to: CGPoint(x: size * 0.84, y: size * 0.34))
                p.addLine(to: CGPoint(x: size * 0.56, y: size * 0.34))
                p.closeSubpath()
            }
            .fill(color.opacity(0.7))
            .frame(width: size, height: size * 0.36)
            ZStack {
                Circle().fill(color)
                Circle()
                    .stroke(Ink.night.opacity(0.4), lineWidth: size * 0.035)
                    .frame(width: size * 0.34, height: size * 0.34)
            }
            .frame(width: size * 0.5, height: size * 0.5)
        }
        .frame(width: size, height: size)
    }
}

struct ArchiveBoxIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        VStack(spacing: size * 0.04) {
            RoundedRectangle(cornerRadius: size * 0.04)
                .stroke(color, lineWidth: size * 0.06)
                .frame(width: size * 0.84, height: size * 0.24)
            ZStack {
                RoundedRectangle(cornerRadius: size * 0.04)
                    .stroke(color, lineWidth: size * 0.06)
                Capsule().fill(color)
                    .frame(width: size * 0.30, height: size * 0.07)
                    .offset(y: -size * 0.10)
            }
            .frame(width: size * 0.70, height: size * 0.46)
        }
        .frame(width: size, height: size)
    }
}

struct PersonIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        VStack(spacing: size * 0.04) {
            ZStack(alignment: .top) {
                Circle().fill(color).frame(width: size * 0.36, height: size * 0.36)
                Rectangle().fill(color)
                    .frame(width: size * 0.52, height: size * 0.06)
                    .offset(y: size * 0.02)
                Rectangle().fill(color)
                    .frame(width: size * 0.30, height: size * 0.10)
                    .offset(y: -size * 0.06)
            }
            .frame(height: size * 0.40)
            HalfDome()
                .fill(color)
                .frame(width: size * 0.62, height: size * 0.34)
        }
        .frame(width: size, height: size)
    }

    struct HalfDome: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            p.move(to: CGPoint(x: 0, y: rect.height))
            p.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height),
                           control: CGPoint(x: rect.width / 2, y: -rect.height * 0.9))
            p.closeSubpath()
            return p
        }
    }
}

struct DoorIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        ZStack {
            ArchDoor()
                .stroke(color, lineWidth: size * 0.06)
                .frame(width: size * 0.58, height: size * 0.84)
            Circle().fill(color)
                .frame(width: size * 0.08, height: size * 0.08)
                .offset(x: size * 0.14, y: size * 0.06)
        }
        .frame(width: size, height: size)
    }

    struct ArchDoor: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            p.move(to: CGPoint(x: 0, y: rect.height))
            p.addLine(to: CGPoint(x: 0, y: rect.height * 0.32))
            p.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height * 0.32),
                           control: CGPoint(x: rect.width / 2, y: -rect.height * 0.18))
            p.addLine(to: CGPoint(x: rect.width, y: rect.height))
            p.closeSubpath()
            return p
        }
    }
}

struct LinkIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: size * 0.09)
                .frame(width: size * 0.46, height: size * 0.46)
                .offset(x: -size * 0.15, y: -size * 0.1)
            Circle()
                .stroke(color, lineWidth: size * 0.09)
                .frame(width: size * 0.46, height: size * 0.46)
                .offset(x: size * 0.15, y: size * 0.1)
        }
        .frame(width: size, height: size)
    }
}

struct LockIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        VStack(spacing: -size * 0.02) {
            Circle()
                .trim(from: 0.5, to: 1.0)
                .stroke(color, lineWidth: size * 0.08)
                .frame(width: size * 0.4, height: size * 0.4)
            RoundedRectangle(cornerRadius: size * 0.06)
                .fill(color)
                .frame(width: size * 0.58, height: size * 0.42)
        }
        .frame(width: size, height: size)
    }
}

struct CheckIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        CheckShape()
            .stroke(color, style: StrokeStyle(lineWidth: size * 0.12, lineCap: .round, lineJoin: .round))
            .frame(width: size, height: size)
    }
}

struct CrossIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        CrossShape()
            .stroke(color, style: StrokeStyle(lineWidth: size * 0.11, lineCap: .round))
            .frame(width: size, height: size)
    }
}

struct ChevronIcon: View {
    var size: CGFloat
    var color: Color
    var pointingLeft: Bool = true
    var body: some View {
        ChevronShape(pointingLeft: pointingLeft)
            .stroke(color, style: StrokeStyle(lineWidth: size * 0.12, lineCap: .round, lineJoin: .round))
            .frame(width: size, height: size)
    }
}

struct SpeakerIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        HStack(spacing: size * 0.06) {
            Path { p in
                p.move(to: CGPoint(x: 0, y: size * 0.32))
                p.addLine(to: CGPoint(x: size * 0.16, y: size * 0.32))
                p.addLine(to: CGPoint(x: size * 0.38, y: size * 0.10))
                p.addLine(to: CGPoint(x: size * 0.38, y: size * 0.78))
                p.addLine(to: CGPoint(x: size * 0.16, y: size * 0.56))
                p.addLine(to: CGPoint(x: 0, y: size * 0.56))
                p.closeSubpath()
            }
            .fill(color)
            .frame(width: size * 0.38, height: size * 0.88)
            ForEach(0..<2, id: \.self) { i in
                Circle()
                    .trim(from: 0.875, to: 1.125)
                    .stroke(color, style: StrokeStyle(lineWidth: size * 0.07, lineCap: .round))
                    .frame(width: size * (0.36 + 0.26 * CGFloat(i)),
                           height: size * (0.36 + 0.26 * CGFloat(i)))
                    .rotationEffect(.degrees(0))
                    .offset(x: -size * (0.12 + 0.13 * CGFloat(i)))
            }
        }
        .frame(width: size, height: size)
    }
}

struct PulseIcon: View {
    var size: CGFloat
    var color: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.10)
                .stroke(color, lineWidth: size * 0.07)
                .frame(width: size * 0.42, height: size * 0.74)
            ForEach([-1, 1], id: \.self) { side in
                ForEach(0..<2, id: \.self) { i in
                    Circle()
                        .trim(from: side == 1 ? 0.875 : 0.375, to: side == 1 ? 1.125 : 0.625)
                        .stroke(color, style: StrokeStyle(lineWidth: size * 0.06, lineCap: .round))
                        .frame(width: size * (0.55 + 0.3 * CGFloat(i)),
                               height: size * (0.55 + 0.3 * CGFloat(i)))
                        .offset(x: CGFloat(side) * -size * 0.0)
                }
            }
        }
        .frame(width: size, height: size)
    }
}

/// Small amber hotspot glint used in scenes.
struct GlintMark: View {
    var size: CGFloat
    var found: Bool
    @State private var pulsing = false
    var body: some View {
        ZStack {
            if found {
                Circle().fill(Ink.panel.opacity(0.85))
                CheckIcon(size: size * 0.5, color: Ink.verdigris)
            } else {
                Circle()
                    .stroke(Ink.amber, lineWidth: 2)
                    .scaleEffect(pulsing ? 1.25 : 0.9)
                    .opacity(pulsing ? 0.25 : 0.9)
                    .animation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true), value: pulsing)
                Circle().fill(Ink.amber.opacity(0.85))
                    .frame(width: size * 0.4, height: size * 0.4)
            }
        }
        .frame(width: size, height: size)
        .onAppear { pulsing = true }
    }
}
