import SwiftUI

/// Stylized Victorian scene illustration for a location. All geometry is relative
/// to the rect handed to us by the PARENT (never Canvas-local size assumptions).
struct SceneIllustration: View {
    let kind: SceneKind

    var body: some View {
        GeometryReader { geo in
            let w = min(geo.size.width, UIScreen.main.bounds.width)
            let h = geo.size.height
            ZStack {
                sceneBody(w: w, h: h)
            }
            .frame(width: w, height: h)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
        .clipped()
    }

    @ViewBuilder
    private func sceneBody(w: CGFloat, h: CGFloat) -> some View {
        switch kind {
        case .study: StudyScene(w: w, h: h)
        case .parlour: ParlourScene(w: w, h: h)
        case .alley: AlleyScene(w: w, h: h)
        case .dock: DockScene(w: w, h: h)
        case .shopFloor: ShopScene(w: w, h: h)
        case .market: MarketScene(w: w, h: h)
        case .garden: GardenScene(w: w, h: h)
        case .workshop: WorkshopScene(w: w, h: h)
        case .cellar: CellarScene(w: w, h: h)
        case .theatre: TheatreScene(w: w, h: h)
        case .office: OfficeScene(w: w, h: h)
        case .bankVault: VaultScene(w: w, h: h)
        case .churchyard: ChurchyardScene(w: w, h: h)
        case .warehouse: WarehouseScene(w: w, h: h)
        case .printworks: PrintworksScene(w: w, h: h)
        case .boardroom: BoardroomScene(w: w, h: h)
        case .bridge: BridgeScene(w: w, h: h)
        case .trainYard: TrainYardScene(w: w, h: h)
        case .hospitalWard: HospitalScene(w: w, h: h)
        case .gasworks: GasworksScene(w: w, h: h)
        case .kitchen: KitchenScene(w: w, h: h)
        case .attic: AtticScene(w: w, h: h)
        }
    }
}

// MARK: - Shared props

private struct RoomBase: View {
    var w: CGFloat; var h: CGFloat
    var wall: Color
    var floor: Color
    var body: some View {
        ZStack {
            Rectangle().fill(wall).frame(width: w, height: h)
            Rectangle().fill(floor)
                .frame(width: w, height: h * 0.30)
                .offset(y: h * 0.35)
            Rectangle().fill(Color.black.opacity(0.18))
                .frame(width: w, height: 2)
                .offset(y: h * 0.20)
        }
    }
}

private struct SkyBase: View {
    var w: CGFloat; var h: CGFloat
    var ground: Color
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.10, green: 0.14, blue: 0.17),
                Color(red: 0.16, green: 0.19, blue: 0.20)
            ]), startPoint: .top, endPoint: .bottom)
            .frame(width: w, height: h)
            Circle().fill(Ink.fog.opacity(0.35))
                .frame(width: w * 0.12, height: w * 0.12)
                .offset(x: w * 0.32, y: -h * 0.34)
            Rectangle().fill(ground)
                .frame(width: w, height: h * 0.26)
                .offset(y: h * 0.37)
        }
    }
}

private struct WindowProp: View {
    var s: CGFloat
    var lit: Bool = true
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: s * 0.06)
                .fill(lit ? Ink.amberDim.opacity(0.55) : Color(red: 0.10, green: 0.13, blue: 0.15))
            Rectangle().fill(Ink.charcoal).frame(width: s * 0.06)
            Rectangle().fill(Ink.charcoal).frame(height: s * 0.06)
            RoundedRectangle(cornerRadius: s * 0.06).stroke(Ink.charcoal, lineWidth: s * 0.07)
        }
        .frame(width: s, height: s * 1.3)
    }
}

private struct TableProp: View {
    var s: CGFloat
    var wood: Color = Color(red: 0.30, green: 0.21, blue: 0.13)
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: s * 0.02).fill(wood)
                .frame(width: s, height: s * 0.10)
            HStack {
                Rectangle().fill(wood.opacity(0.85)).frame(width: s * 0.07, height: s * 0.42)
                Spacer()
                Rectangle().fill(wood.opacity(0.85)).frame(width: s * 0.07, height: s * 0.42)
            }
            .frame(width: s * 0.86)
        }
    }
}

private struct ShelfProp: View {
    var s: CGFloat
    var body: some View {
        VStack(spacing: s * 0.05) {
            ForEach(0..<3, id: \.self) { row in
                ZStack(alignment: .bottom) {
                    HStack(spacing: s * 0.025) {
                        ForEach(0..<5, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 1)
                                .fill([Ink.bloodWax, Ink.verdigris, Ink.amberDim, Ink.parchmentDim,
                                       Color(red: 0.25, green: 0.30, blue: 0.40)][(i + row * 2) % 5])
                                .frame(width: s * 0.09, height: s * (0.16 + 0.02 * CGFloat((i + row) % 3)))
                        }
                    }
                    Rectangle().fill(Color(red: 0.24, green: 0.17, blue: 0.11))
                        .frame(width: s * 0.7, height: s * 0.035)
                        .offset(y: s * 0.035)
                }
            }
        }
        .frame(width: s * 0.7)
    }
}

private struct CrateProp: View {
    var s: CGFloat
    var body: some View {
        ZStack {
            Rectangle().fill(Color(red: 0.36, green: 0.27, blue: 0.16))
            Rectangle().stroke(Color(red: 0.22, green: 0.16, blue: 0.09), lineWidth: s * 0.05)
            Path { p in
                p.move(to: .zero); p.addLine(to: CGPoint(x: s, y: s))
                p.move(to: CGPoint(x: s, y: 0)); p.addLine(to: CGPoint(x: 0, y: s))
            }
            .stroke(Color(red: 0.22, green: 0.16, blue: 0.09), lineWidth: s * 0.04)
        }
        .frame(width: s, height: s)
    }
}

private struct BarrelProp: View {
    var s: CGFloat
    var body: some View {
        ZStack {
            Capsule().fill(Color(red: 0.33, green: 0.23, blue: 0.13))
            Rectangle().fill(Ink.charcoal.opacity(0.8)).frame(height: s * 0.05)
                .offset(y: -s * 0.22)
            Rectangle().fill(Ink.charcoal.opacity(0.8)).frame(height: s * 0.05)
                .offset(y: s * 0.22)
        }
        .frame(width: s * 0.72, height: s)
    }
}

private struct StreetLampProp: View {
    var s: CGFloat
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle().fill(Ink.amberGlow.opacity(0.30))
                    .frame(width: s * 0.5, height: s * 0.5)
                GasLampIcon(size: s * 0.34, color: Ink.charcoal)
                    .offset(y: s * 0.04)
            }
            .frame(height: s * 0.4)
            Rectangle().fill(Ink.charcoal).frame(width: s * 0.045, height: s * 0.52)
            Rectangle().fill(Ink.charcoal).frame(width: s * 0.18, height: s * 0.045)
        }
    }
}

private struct CurtainProp: View {
    var s: CGFloat
    var color: Color = Ink.bloodWax
    var body: some View {
        HStack(spacing: s * 0.02) {
            ForEach(0..<4, id: \.self) { i in
                Capsule().fill(color.opacity(i % 2 == 0 ? 0.95 : 0.75))
                    .frame(width: s * 0.10, height: s)
            }
        }
    }
}

private struct GraveProp: View {
    var s: CGFloat
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: s * 0.18)
                .fill(Color(red: 0.42, green: 0.44, blue: 0.42))
                .frame(width: s * 0.6, height: s * 0.75)
            Rectangle().fill(Color(red: 0.34, green: 0.36, blue: 0.34))
                .frame(width: s * 0.8, height: s * 0.12)
        }
    }
}

private struct PaperProp: View {
    var s: CGFloat
    var body: some View {
        ZStack {
            Rectangle().fill(Ink.parchment)
            VStack(spacing: s * 0.10) {
                ForEach(0..<3, id: \.self) { _ in
                    Rectangle().fill(Ink.charcoal.opacity(0.5)).frame(height: max(1, s * 0.035))
                }
            }
            .padding(s * 0.12)
        }
        .frame(width: s * 0.75, height: s)
        .rotationEffect(.degrees(-6))
    }
}

// MARK: - Scenes (each: backdrop + a handful of props)

private struct StudyScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.16, green: 0.20, blue: 0.17),
                     floor: Color(red: 0.23, green: 0.16, blue: 0.10))
            ShelfProp(s: w * 0.34).offset(x: -w * 0.30, y: -h * 0.10)
            WindowProp(s: w * 0.16).offset(x: w * 0.30, y: -h * 0.16)
            TableProp(s: w * 0.34).offset(x: w * 0.10, y: h * 0.22)
            PaperProp(s: w * 0.07).offset(x: w * 0.06, y: h * 0.13)
            GasLampIcon(size: w * 0.085, color: Ink.charcoal).offset(x: w * 0.22, y: h * 0.10)
        }
    }
}

private struct ParlourScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.20, green: 0.16, blue: 0.18),
                     floor: Color(red: 0.26, green: 0.18, blue: 0.12))
            CurtainProp(s: h * 0.42, color: Ink.bloodWax).offset(x: -w * 0.30, y: -h * 0.12)
            WindowProp(s: w * 0.15).offset(x: -w * 0.30, y: -h * 0.14)
            // settee
            ZStack {
                RoundedRectangle(cornerRadius: w * 0.03)
                    .fill(Color(red: 0.32, green: 0.16, blue: 0.16))
                    .frame(width: w * 0.40, height: h * 0.16)
                RoundedRectangle(cornerRadius: w * 0.03)
                    .fill(Color(red: 0.38, green: 0.20, blue: 0.20))
                    .frame(width: w * 0.40, height: h * 0.07)
                    .offset(y: -h * 0.10)
            }
            .offset(x: w * 0.18, y: h * 0.20)
            // mantel clock
            VStack(spacing: 0) {
                Circle().stroke(Ink.parchment, lineWidth: 2)
                    .background(Circle().fill(Ink.charcoal))
                    .frame(width: w * 0.07, height: w * 0.07)
                Rectangle().fill(Color(red: 0.24, green: 0.17, blue: 0.11))
                    .frame(width: w * 0.16, height: h * 0.025)
            }
            .offset(x: w * 0.16, y: -h * 0.14)
            TableProp(s: w * 0.2).offset(x: -w * 0.22, y: h * 0.26)
        }
    }
}

private struct AlleyScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            SkyBase(w: w, h: h, ground: Color(red: 0.17, green: 0.18, blue: 0.18))
            // brick walls
            Rectangle().fill(Color(red: 0.22, green: 0.15, blue: 0.13))
                .frame(width: w * 0.30, height: h * 0.74)
                .offset(x: -w * 0.35, y: -h * 0.07)
            Rectangle().fill(Color(red: 0.19, green: 0.13, blue: 0.12))
                .frame(width: w * 0.26, height: h * 0.66)
                .offset(x: w * 0.37, y: -h * 0.03)
            WindowProp(s: w * 0.09, lit: false).offset(x: -w * 0.35, y: -h * 0.22)
            WindowProp(s: w * 0.08).offset(x: w * 0.37, y: -h * 0.18)
            StreetLampProp(s: h * 0.5).offset(x: w * 0.10, y: h * 0.10)
            CrateProp(s: w * 0.12).offset(x: -w * 0.24, y: h * 0.32)
            BarrelProp(s: w * 0.13).offset(x: w * 0.30, y: h * 0.30)
            // fog
            Capsule().fill(Ink.fog.opacity(0.08))
                .frame(width: w * 0.9, height: h * 0.07)
                .offset(y: h * 0.24)
        }
    }
}

private struct DockScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            SkyBase(w: w, h: h, ground: Color(red: 0.10, green: 0.15, blue: 0.18))
            // water shimmer
            ForEach(0..<3, id: \.self) { i in
                Capsule().fill(Ink.verdigris.opacity(0.25))
                    .frame(width: w * 0.24, height: 3)
                    .offset(x: w * (-0.2 + 0.2 * CGFloat(i)), y: h * (0.30 + 0.05 * CGFloat(i)))
            }
            // pier planks
            Rectangle().fill(Color(red: 0.27, green: 0.20, blue: 0.12))
                .frame(width: w, height: h * 0.14)
                .offset(y: h * 0.43)
            // mast + hull
            Path { p in
                p.move(to: CGPoint(x: w * 0.62, y: h * 0.58))
                p.addLine(to: CGPoint(x: w * 0.94, y: h * 0.58))
                p.addLine(to: CGPoint(x: w * 0.88, y: h * 0.70))
                p.addLine(to: CGPoint(x: w * 0.66, y: h * 0.70))
                p.closeSubpath()
            }
            .fill(Color(red: 0.20, green: 0.14, blue: 0.10))
            .offset(x: -w * 0.5, y: -h * 0.5)
            Rectangle().fill(Ink.charcoal).frame(width: 3, height: h * 0.34)
                .offset(x: w * 0.28, y: -h * 0.06)
            CrateProp(s: w * 0.13).offset(x: -w * 0.30, y: h * 0.30)
            CrateProp(s: w * 0.10).offset(x: -w * 0.18, y: h * 0.33)
            BarrelProp(s: w * 0.14).offset(x: -w * 0.02, y: h * 0.29)
            StreetLampProp(s: h * 0.42).offset(x: w * 0.12, y: h * 0.13)
        }
    }
}

private struct ShopScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.18, green: 0.17, blue: 0.14),
                     floor: Color(red: 0.24, green: 0.18, blue: 0.11))
            ShelfProp(s: w * 0.30).offset(x: w * 0.30, y: -h * 0.12)
            // counter
            ZStack {
                Rectangle().fill(Color(red: 0.30, green: 0.21, blue: 0.13))
                    .frame(width: w * 0.5, height: h * 0.18)
                Rectangle().fill(Color(red: 0.36, green: 0.26, blue: 0.16))
                    .frame(width: w * 0.5, height: h * 0.035)
                    .offset(y: -h * 0.075)
            }
            .offset(x: -w * 0.16, y: h * 0.22)
            // till
            RoundedRectangle(cornerRadius: 3).fill(Ink.charcoal)
                .frame(width: w * 0.10, height: h * 0.08)
                .offset(x: -w * 0.28, y: h * 0.09)
            // hanging sign
            VStack(spacing: 0) {
                Rectangle().fill(Ink.charcoal).frame(width: 2, height: h * 0.05)
                RoundedRectangle(cornerRadius: 2).fill(Ink.parchmentDim)
                    .frame(width: w * 0.16, height: h * 0.05)
            }
            .offset(x: -w * 0.12, y: -h * 0.30)
            WindowProp(s: w * 0.13).offset(x: -w * 0.34, y: -h * 0.16)
        }
    }
}

private struct MarketScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            SkyBase(w: w, h: h, ground: Color(red: 0.18, green: 0.17, blue: 0.15))
            // stall awning
            ForEach(0..<2, id: \.self) { k in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0..<4, id: \.self) { i in
                            Path { p in
                                p.move(to: .zero)
                                p.addLine(to: CGPoint(x: w * 0.07, y: 0))
                                p.addLine(to: CGPoint(x: w * 0.035, y: h * 0.05))
                                p.closeSubpath()
                            }
                            .fill(i % 2 == 0 ? Ink.bloodWax : Ink.parchment)
                            .frame(width: w * 0.07, height: h * 0.05)
                        }
                    }
                    Rectangle().fill(Color(red: 0.30, green: 0.21, blue: 0.13))
                        .frame(width: w * 0.28, height: h * 0.10)
                        .offset(y: h * 0.06)
                }
                .offset(x: w * (k == 0 ? -0.26 : 0.26), y: h * (k == 0 ? 0.05 : 0.12))
            }
            // produce baskets
            ForEach(0..<3, id: \.self) { i in
                Circle().fill([Ink.verdigris, Ink.amber, Ink.bloodWax][i])
                    .frame(width: w * 0.05, height: w * 0.05)
                    .offset(x: w * (-0.32 + 0.06 * CGFloat(i)), y: h * 0.16)
            }
            StreetLampProp(s: h * 0.44).offset(x: w * 0.02, y: h * 0.12)
            BarrelProp(s: w * 0.12).offset(x: w * 0.38, y: h * 0.32)
        }
    }
}

private struct GardenScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            SkyBase(w: w, h: h, ground: Color(red: 0.14, green: 0.20, blue: 0.13))
            // hedges
            ForEach(0..<3, id: \.self) { i in
                Ellipse().fill(Color(red: 0.12, green: 0.24, blue: 0.14))
                    .frame(width: w * 0.26, height: h * 0.16)
                    .offset(x: w * (-0.32 + 0.32 * CGFloat(i)), y: h * (0.06 + 0.02 * CGFloat(i % 2)))
            }
            // potting bench
            TableProp(s: w * 0.3, wood: Color(red: 0.27, green: 0.20, blue: 0.12))
                .offset(x: w * 0.25, y: h * 0.25)
            // flower rows
            ForEach(0..<5, id: \.self) { i in
                VStack(spacing: 1) {
                    Circle().fill(i % 2 == 0 ? Ink.bloodWax : Ink.amber)
                        .frame(width: w * 0.030, height: w * 0.030)
                    Rectangle().fill(Ink.verdigris).frame(width: 2, height: h * 0.045)
                }
                .offset(x: w * (-0.36 + 0.075 * CGFloat(i)), y: h * 0.30)
            }
            // watering can silhouette
            ZStack {
                RoundedRectangle(cornerRadius: 3).fill(Ink.charcoal)
                    .frame(width: w * 0.085, height: h * 0.06)
                Rectangle().fill(Ink.charcoal)
                    .frame(width: w * 0.07, height: 3)
                    .rotationEffect(.degrees(-30))
                    .offset(x: -w * 0.06, y: -h * 0.012)
            }
            .offset(x: w * 0.10, y: h * 0.36)
        }
    }
}

private struct WorkshopScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.17, green: 0.16, blue: 0.15),
                     floor: Color(red: 0.20, green: 0.17, blue: 0.13))
            // workbench
            TableProp(s: w * 0.44, wood: Color(red: 0.26, green: 0.19, blue: 0.11))
                .offset(x: -w * 0.16, y: h * 0.22)
            // tool silhouettes on wall
            ForEach(0..<4, id: \.self) { i in
                Capsule().fill(Ink.charcoal)
                    .frame(width: 3, height: h * 0.10)
                    .rotationEffect(.degrees(Double(i) * 14 - 20))
                    .offset(x: w * (-0.30 + 0.09 * CGFloat(i)), y: -h * 0.20)
            }
            GearIcon(size: w * 0.10, color: Ink.charcoal.opacity(0.8))
                .offset(x: w * 0.26, y: -h * 0.16)
            GearIcon(size: w * 0.07, color: Ink.charcoal.opacity(0.6))
                .offset(x: w * 0.34, y: -h * 0.10)
            CrateProp(s: w * 0.12).offset(x: w * 0.32, y: h * 0.31)
            // vice
            RoundedRectangle(cornerRadius: 2).fill(Ink.charcoal)
                .frame(width: w * 0.09, height: h * 0.05)
                .offset(x: -w * 0.30, y: h * 0.12)
        }
    }
}

private struct CellarScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.13, green: 0.13, blue: 0.13),
                     floor: Color(red: 0.16, green: 0.15, blue: 0.13))
            // arch
            Path { p in
                p.move(to: CGPoint(x: w * 0.30, y: h * 0.62))
                p.addLine(to: CGPoint(x: w * 0.30, y: h * 0.34))
                p.addQuadCurve(to: CGPoint(x: w * 0.54, y: h * 0.34),
                               control: CGPoint(x: w * 0.42, y: h * 0.16))
                p.addLine(to: CGPoint(x: w * 0.54, y: h * 0.62))
            }
            .stroke(Color(red: 0.22, green: 0.21, blue: 0.19), lineWidth: w * 0.025)
            .offset(x: -w * 0.5, y: -h * 0.5)
            BarrelProp(s: w * 0.16).offset(x: -w * 0.26, y: h * 0.27)
            BarrelProp(s: w * 0.16).offset(x: -w * 0.10, y: h * 0.29)
            CrateProp(s: w * 0.13).offset(x: w * 0.26, y: h * 0.30)
            // candle
            VStack(spacing: 0) {
                Circle().fill(Ink.amber).frame(width: w * 0.025, height: w * 0.025)
                Rectangle().fill(Ink.parchment).frame(width: w * 0.018, height: h * 0.05)
            }
            .offset(x: w * 0.30, y: h * 0.18)
            Circle().fill(Ink.amberGlow.opacity(0.12))
                .frame(width: w * 0.3, height: w * 0.3)
                .offset(x: w * 0.30, y: h * 0.16)
        }
    }
}

private struct TheatreScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.15, green: 0.10, blue: 0.12),
                     floor: Color(red: 0.22, green: 0.14, blue: 0.10))
            CurtainProp(s: h * 0.55, color: Ink.bloodWax).offset(x: -w * 0.36, y: -h * 0.08)
            CurtainProp(s: h * 0.55, color: Ink.bloodWax).offset(x: w * 0.36, y: -h * 0.08)
            // stage front
            Rectangle().fill(Color(red: 0.28, green: 0.18, blue: 0.10))
                .frame(width: w * 0.6, height: h * 0.08)
                .offset(y: h * 0.26)
            // music stand
            VStack(spacing: 0) {
                Rectangle().fill(Ink.charcoal).frame(width: w * 0.085, height: h * 0.06)
                Rectangle().fill(Ink.charcoal).frame(width: 2, height: h * 0.10)
                Rectangle().fill(Ink.charcoal).frame(width: w * 0.07, height: 2)
            }
            .offset(x: -w * 0.06, y: h * 0.10)
            // spotlight pool
            Ellipse().fill(Ink.amberGlow.opacity(0.14))
                .frame(width: w * 0.34, height: h * 0.10)
                .offset(y: h * 0.22)
            // chandelier
            VStack(spacing: 0) {
                Rectangle().fill(Ink.amberDim).frame(width: 2, height: h * 0.07)
                Ellipse().fill(Ink.amber.opacity(0.8)).frame(width: w * 0.14, height: h * 0.035)
            }
            .offset(y: -h * 0.40)
        }
    }
}

private struct OfficeScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.17, green: 0.18, blue: 0.20),
                     floor: Color(red: 0.21, green: 0.16, blue: 0.11))
            WindowProp(s: w * 0.15, lit: false).offset(x: -w * 0.28, y: -h * 0.16)
            WindowProp(s: w * 0.15, lit: false).offset(x: w * 0.04, y: -h * 0.16)
            // filing cabinet
            VStack(spacing: 2) {
                ForEach(0..<3, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.25, green: 0.22, blue: 0.18))
                        .frame(width: w * 0.14, height: h * 0.07)
                }
            }
            .offset(x: w * 0.33, y: h * 0.10)
            TableProp(s: w * 0.36).offset(x: -w * 0.12, y: h * 0.23)
            PaperProp(s: w * 0.065).offset(x: -w * 0.18, y: h * 0.135)
            PaperProp(s: w * 0.06).offset(x: -w * 0.04, y: h * 0.145)
            // inkwell
            Circle().fill(Ink.charcoal).frame(width: w * 0.035, height: w * 0.035)
                .offset(x: w * 0.02, y: h * 0.135)
        }
    }
}

private struct VaultScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.14, green: 0.15, blue: 0.16),
                     floor: Color(red: 0.17, green: 0.17, blue: 0.16))
            // vault door
            ZStack {
                Circle().fill(Color(red: 0.24, green: 0.25, blue: 0.27))
                    .frame(width: w * 0.34, height: w * 0.34)
                Circle().stroke(Ink.charcoal, lineWidth: w * 0.018)
                    .frame(width: w * 0.26, height: w * 0.26)
                ForEach(0..<4, id: \.self) { i in
                    Capsule().fill(Ink.charcoal)
                        .frame(width: w * 0.12, height: w * 0.018)
                        .rotationEffect(.degrees(Double(i) * 45))
                }
                Circle().fill(Ink.amberDim).frame(width: w * 0.04, height: w * 0.04)
            }
            .offset(x: -w * 0.20, y: -h * 0.05)
            // strongboxes
            ForEach(0..<2, id: \.self) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 0.22, green: 0.20, blue: 0.16))
                    .frame(width: w * 0.15, height: h * 0.08)
                    .offset(x: w * (0.22 + 0.04 * CGFloat(i)), y: h * (0.18 + 0.11 * CGFloat(i)))
            }
            // scattered coins
            ForEach(0..<5, id: \.self) { i in
                Circle().fill(Ink.amber)
                    .frame(width: w * 0.022, height: w * 0.022)
                    .offset(x: w * (-0.05 + 0.05 * CGFloat(i)), y: h * (0.30 + 0.015 * CGFloat(i % 2)))
            }
        }
    }
}

private struct ChurchyardScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            SkyBase(w: w, h: h, ground: Color(red: 0.13, green: 0.17, blue: 0.12))
            // church silhouette
            Path { p in
                p.move(to: CGPoint(x: w * 0.60, y: h * 0.62))
                p.addLine(to: CGPoint(x: w * 0.60, y: h * 0.30))
                p.addLine(to: CGPoint(x: w * 0.68, y: h * 0.18))
                p.addLine(to: CGPoint(x: w * 0.70, y: h * 0.06))
                p.addLine(to: CGPoint(x: w * 0.72, y: h * 0.18))
                p.addLine(to: CGPoint(x: w * 0.80, y: h * 0.30))
                p.addLine(to: CGPoint(x: w * 0.80, y: h * 0.62))
                p.closeSubpath()
            }
            .fill(Color(red: 0.12, green: 0.13, blue: 0.14))
            .offset(x: -w * 0.5, y: -h * 0.5)
            GraveProp(s: w * 0.13).offset(x: -w * 0.30, y: h * 0.26)
            GraveProp(s: w * 0.11).offset(x: -w * 0.12, y: h * 0.30)
            GraveProp(s: w * 0.12).offset(x: w * 0.05, y: h * 0.27)
            // bare tree
            Path { p in
                p.move(to: CGPoint(x: w * 0.16, y: h * 0.66))
                p.addLine(to: CGPoint(x: w * 0.15, y: h * 0.40))
                p.addLine(to: CGPoint(x: w * 0.08, y: h * 0.28))
                p.move(to: CGPoint(x: w * 0.15, y: h * 0.44))
                p.addLine(to: CGPoint(x: w * 0.22, y: h * 0.30))
                p.move(to: CGPoint(x: w * 0.155, y: h * 0.52))
                p.addLine(to: CGPoint(x: w * 0.10, y: h * 0.46))
            }
            .stroke(Ink.charcoal, lineWidth: w * 0.012)
            .offset(x: -w * 0.5, y: -h * 0.5)
            StreetLampProp(s: h * 0.40).offset(x: w * 0.34, y: h * 0.16)
        }
    }
}

private struct WarehouseScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.15, green: 0.14, blue: 0.13),
                     floor: Color(red: 0.18, green: 0.16, blue: 0.13))
            // beams
            Rectangle().fill(Ink.charcoal.opacity(0.7)).frame(width: w, height: h * 0.03)
                .offset(y: -h * 0.34)
            Rectangle().fill(Ink.charcoal.opacity(0.7)).frame(width: w * 0.03, height: h * 0.5)
                .offset(x: -w * 0.10, y: -h * 0.18)
            CrateProp(s: w * 0.16).offset(x: -w * 0.30, y: h * 0.28)
            CrateProp(s: w * 0.13).offset(x: -w * 0.30, y: h * 0.135)
            CrateProp(s: w * 0.14).offset(x: -w * 0.14, y: h * 0.30)
            BarrelProp(s: w * 0.15).offset(x: w * 0.12, y: h * 0.28)
            BarrelProp(s: w * 0.13).offset(x: w * 0.24, y: h * 0.30)
            // hook and chain
            VStack(spacing: 0) {
                Rectangle().fill(Ink.charcoal).frame(width: 2, height: h * 0.20)
                Circle().trim(from: 0.1, to: 0.7)
                    .stroke(Ink.charcoal, lineWidth: 3)
                    .frame(width: w * 0.045, height: w * 0.045)
            }
            .offset(x: w * 0.33, y: -h * 0.20)
        }
    }
}

private struct PrintworksScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.16, green: 0.16, blue: 0.17),
                     floor: Color(red: 0.19, green: 0.17, blue: 0.14))
            // printing press silhouette
            ZStack {
                Rectangle().fill(Ink.charcoal)
                    .frame(width: w * 0.26, height: h * 0.26)
                Rectangle().fill(Color(red: 0.26, green: 0.26, blue: 0.28))
                    .frame(width: w * 0.30, height: h * 0.05)
                    .offset(y: -h * 0.155)
                GearIcon(size: w * 0.09, color: Ink.amberDim)
                    .offset(x: w * 0.10, y: -h * 0.02)
                Rectangle().fill(Ink.parchment)
                    .frame(width: w * 0.10, height: h * 0.04)
                    .offset(x: -w * 0.06, y: h * 0.09)
            }
            .offset(x: -w * 0.18, y: h * 0.10)
            // stacked newspapers
            VStack(spacing: 2) {
                ForEach(0..<4, id: \.self) { _ in
                    Rectangle().fill(Ink.parchmentDim)
                        .frame(width: w * 0.16, height: h * 0.022)
                }
            }
            .offset(x: w * 0.26, y: h * 0.30)
            // hanging proofs
            ForEach(0..<3, id: \.self) { i in
                VStack(spacing: 0) {
                    Rectangle().fill(Ink.charcoal).frame(width: 1, height: h * 0.04)
                    Rectangle().fill(Ink.parchment).frame(width: w * 0.07, height: h * 0.09)
                }
                .offset(x: w * (0.06 + 0.11 * CGFloat(i)), y: -h * 0.26)
            }
        }
    }
}

private struct BoardroomScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.18, green: 0.15, blue: 0.12),
                     floor: Color(red: 0.24, green: 0.17, blue: 0.11))
            // long table
            ZStack {
                Ellipse().fill(Color(red: 0.32, green: 0.22, blue: 0.13))
                    .frame(width: w * 0.62, height: h * 0.16)
                Ellipse().fill(Color(red: 0.38, green: 0.27, blue: 0.16))
                    .frame(width: w * 0.56, height: h * 0.12)
            }
            .offset(y: h * 0.22)
            // chairs
            ForEach(0..<4, id: \.self) { i in
                RoundedRectangle(cornerRadius: 3)
                    .fill(Ink.charcoal)
                    .frame(width: w * 0.06, height: h * 0.10)
                    .offset(x: w * (-0.27 + 0.18 * CGFloat(i)), y: h * 0.10)
            }
            // portraits on wall
            ForEach(0..<3, id: \.self) { i in
                ZStack {
                    RoundedRectangle(cornerRadius: 2).fill(Ink.amberDim.opacity(0.45))
                    PersonIcon(size: w * 0.055, color: Ink.charcoal)
                }
                .frame(width: w * 0.09, height: h * 0.13)
                .offset(x: w * (-0.20 + 0.20 * CGFloat(i)), y: -h * 0.24)
            }
            // gas wall sconces
            Circle().fill(Ink.amberGlow.opacity(0.25)).frame(width: w * 0.07)
                .offset(x: -w * 0.38, y: -h * 0.18)
            Circle().fill(Ink.amberGlow.opacity(0.25)).frame(width: w * 0.07)
                .offset(x: w * 0.38, y: -h * 0.18)
        }
    }
}

private struct BridgeScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            SkyBase(w: w, h: h, ground: Color(red: 0.09, green: 0.13, blue: 0.16))
            // bridge arc
            Path { p in
                p.move(to: CGPoint(x: 0, y: h * 0.55))
                p.addQuadCurve(to: CGPoint(x: w, y: h * 0.55),
                               control: CGPoint(x: w * 0.5, y: h * 0.30))
                p.addLine(to: CGPoint(x: w, y: h * 0.46))
                p.addQuadCurve(to: CGPoint(x: 0, y: h * 0.46),
                               control: CGPoint(x: w * 0.5, y: h * 0.20))
                p.closeSubpath()
            }
            .fill(Color(red: 0.17, green: 0.17, blue: 0.18))
            .offset(x: -w * 0.5, y: -h * 0.5)
            // balustrade
            ForEach(0..<9, id: \.self) { i in
                Rectangle().fill(Color(red: 0.20, green: 0.20, blue: 0.21))
                    .frame(width: w * 0.015, height: h * 0.06)
                    .offset(x: w * (-0.4 + 0.1 * CGFloat(i)),
                            y: -h * (0.10 + 0.025 * CGFloat(abs(4 - Int(i)))))
            }
            StreetLampProp(s: h * 0.36).offset(x: -w * 0.02, y: -h * 0.22)
            // river glints
            ForEach(0..<4, id: \.self) { i in
                Capsule().fill(Ink.amber.opacity(0.18))
                    .frame(width: w * 0.18, height: 2.5)
                    .offset(x: w * (-0.3 + 0.2 * CGFloat(i)), y: h * (0.28 + 0.04 * CGFloat(i % 2)))
            }
        }
    }
}

private struct TrainYardScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            SkyBase(w: w, h: h, ground: Color(red: 0.15, green: 0.14, blue: 0.13))
            // engine silhouette
            ZStack {
                RoundedRectangle(cornerRadius: 4).fill(Ink.charcoal)
                    .frame(width: w * 0.40, height: h * 0.16)
                Rectangle().fill(Ink.charcoal)
                    .frame(width: w * 0.10, height: h * 0.10)
                    .offset(x: -w * 0.13, y: -h * 0.12)
                Circle().fill(Color(red: 0.22, green: 0.22, blue: 0.23))
                    .frame(width: w * 0.07).offset(x: -w * 0.12, y: h * 0.095)
                Circle().fill(Color(red: 0.22, green: 0.22, blue: 0.23))
                    .frame(width: w * 0.07).offset(x: w * 0.02, y: h * 0.095)
                Circle().fill(Color(red: 0.22, green: 0.22, blue: 0.23))
                    .frame(width: w * 0.07).offset(x: w * 0.13, y: h * 0.095)
            }
            .offset(x: -w * 0.16, y: h * 0.12)
            // steam puffs
            Circle().fill(Ink.fog.opacity(0.22)).frame(width: w * 0.09)
                .offset(x: -w * 0.28, y: -h * 0.10)
            Circle().fill(Ink.fog.opacity(0.14)).frame(width: w * 0.13)
                .offset(x: -w * 0.22, y: -h * 0.20)
            // rails
            Path { p in
                p.move(to: CGPoint(x: 0, y: h * 0.86))
                p.addLine(to: CGPoint(x: w, y: h * 0.80))
                p.move(to: CGPoint(x: 0, y: h * 0.94))
                p.addLine(to: CGPoint(x: w, y: h * 0.88))
            }
            .stroke(Color(red: 0.30, green: 0.30, blue: 0.31), lineWidth: 3)
            .offset(x: -w * 0.5, y: -h * 0.5)
            // signal
            VStack(spacing: 0) {
                Circle().fill(Ink.bloodWax).frame(width: w * 0.035)
                Rectangle().fill(Ink.charcoal).frame(width: 3, height: h * 0.22)
            }
            .offset(x: w * 0.36, y: h * 0.10)
        }
    }
}

private struct HospitalScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.19, green: 0.21, blue: 0.20),
                     floor: Color(red: 0.22, green: 0.22, blue: 0.20))
            // beds
            ForEach(0..<2, id: \.self) { i in
                ZStack {
                    Rectangle().fill(Ink.parchment.opacity(0.85))
                        .frame(width: w * 0.26, height: h * 0.07)
                    Rectangle().fill(Ink.charcoal)
                        .frame(width: w * 0.018, height: h * 0.12)
                        .offset(x: -w * 0.125, y: h * 0.01)
                    Rectangle().fill(Ink.charcoal)
                        .frame(width: w * 0.018, height: h * 0.10)
                        .offset(x: w * 0.125, y: h * 0.02)
                }
                .offset(x: w * (-0.22 + 0.44 * CGFloat(i)), y: h * 0.24)
            }
            // medicine cabinet
            ZStack {
                RoundedRectangle(cornerRadius: 2).stroke(Ink.parchmentDim, lineWidth: 2)
                    .frame(width: w * 0.16, height: h * 0.18)
                ForEach(0..<3, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 1)
                        .fill([Ink.verdigris, Ink.amberDim, Ink.bloodWax][i])
                        .frame(width: w * 0.025, height: h * 0.05)
                        .offset(x: w * (-0.045 + 0.045 * CGFloat(i)), y: -h * 0.02)
                }
            }
            .offset(x: 0, y: -h * 0.16)
            WindowProp(s: w * 0.13, lit: false).offset(x: w * 0.32, y: -h * 0.17)
            // privacy screen
            HStack(spacing: 1) {
                ForEach(0..<3, id: \.self) { _ in
                    Rectangle().fill(Ink.parchmentDim.opacity(0.7))
                        .frame(width: w * 0.05, height: h * 0.18)
                }
            }
            .offset(x: -w * 0.36, y: h * 0.10)
        }
    }
}

private struct GasworksScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            SkyBase(w: w, h: h, ground: Color(red: 0.14, green: 0.14, blue: 0.13))
            // gasometer (big cylinder)
            ZStack {
                RoundedRectangle(cornerRadius: w * 0.02)
                    .fill(Color(red: 0.18, green: 0.19, blue: 0.20))
                    .frame(width: w * 0.36, height: h * 0.40)
                ForEach(0..<3, id: \.self) { i in
                    Rectangle().fill(Ink.charcoal)
                        .frame(width: w * 0.36, height: 2)
                        .offset(y: h * (-0.12 + 0.12 * CGFloat(i)))
                }
                // frame towers
                Rectangle().fill(Ink.charcoal).frame(width: 3, height: h * 0.48)
                    .offset(x: -w * 0.19)
                Rectangle().fill(Ink.charcoal).frame(width: 3, height: h * 0.48)
                    .offset(x: w * 0.19)
            }
            .offset(x: -w * 0.20, y: -h * 0.02)
            // pipes
            Path { p in
                p.move(to: CGPoint(x: w * 0.62, y: h * 0.78))
                p.addLine(to: CGPoint(x: w * 0.62, y: h * 0.50))
                p.addLine(to: CGPoint(x: w * 0.84, y: h * 0.50))
                p.addLine(to: CGPoint(x: w * 0.84, y: h * 0.66))
            }
            .stroke(Color(red: 0.26, green: 0.25, blue: 0.23), lineWidth: w * 0.025)
            .offset(x: -w * 0.5, y: -h * 0.5)
            // valve wheel
            ZStack {
                Circle().stroke(Ink.amberDim, lineWidth: 3).frame(width: w * 0.07)
                CrossShape().stroke(Ink.amberDim, lineWidth: 2)
                    .frame(width: w * 0.05, height: w * 0.05)
            }
            .offset(x: w * 0.12, y: 0)
            BarrelProp(s: w * 0.12).offset(x: w * 0.34, y: h * 0.30)
            Capsule().fill(Ink.fog.opacity(0.10))
                .frame(width: w * 0.8, height: h * 0.06)
                .offset(y: h * 0.20)
        }
    }
}

private struct KitchenScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.19, green: 0.17, blue: 0.14),
                     floor: Color(red: 0.21, green: 0.18, blue: 0.14))
            // range / stove
            ZStack {
                Rectangle().fill(Ink.charcoal).frame(width: w * 0.24, height: h * 0.20)
                Circle().fill(Ink.bloodWax.opacity(0.8)).frame(width: w * 0.05)
                    .offset(y: h * 0.02)
                Rectangle().fill(Ink.charcoal).frame(width: w * 0.04, height: h * 0.16)
                    .offset(y: -h * 0.18)
            }
            .offset(x: -w * 0.26, y: h * 0.14)
            // hanging pots
            ForEach(0..<3, id: \.self) { i in
                VStack(spacing: 0) {
                    Rectangle().fill(Ink.charcoal).frame(width: 1.5, height: h * 0.05)
                    Capsule().fill(Color(red: 0.45, green: 0.42, blue: 0.38))
                        .frame(width: w * 0.07, height: h * 0.045)
                }
                .offset(x: w * (0.04 + 0.10 * CGFloat(i)), y: -h * 0.26)
            }
            TableProp(s: w * 0.32, wood: Color(red: 0.34, green: 0.26, blue: 0.16))
                .offset(x: w * 0.18, y: h * 0.24)
            // bread + knife
            Capsule().fill(Ink.amberDim).frame(width: w * 0.09, height: h * 0.035)
                .offset(x: w * 0.12, y: h * 0.155)
            Rectangle().fill(Ink.parchmentDim).frame(width: w * 0.07, height: 2)
                .rotationEffect(.degrees(18))
                .offset(x: w * 0.26, y: h * 0.16)
        }
    }
}

private struct AtticScene: View {
    var w: CGFloat; var h: CGFloat
    var body: some View {
        ZStack {
            RoomBase(w: w, h: h, wall: Color(red: 0.15, green: 0.13, blue: 0.11),
                     floor: Color(red: 0.19, green: 0.16, blue: 0.12))
            // sloped beams
            Path { p in
                p.move(to: CGPoint(x: 0, y: h * 0.45))
                p.addLine(to: CGPoint(x: w * 0.5, y: h * 0.04))
                p.addLine(to: CGPoint(x: w, y: h * 0.45))
            }
            .stroke(Color(red: 0.26, green: 0.20, blue: 0.13), lineWidth: w * 0.03)
            .offset(x: -w * 0.5, y: -h * 0.5)
            // round window
            ZStack {
                Circle().fill(Ink.amberDim.opacity(0.4))
                Circle().stroke(Ink.charcoal, lineWidth: 3)
                Rectangle().fill(Ink.charcoal).frame(width: 2)
                Rectangle().fill(Ink.charcoal).frame(height: 2)
            }
            .frame(width: w * 0.13, height: w * 0.13)
            .offset(y: -h * 0.22)
            // trunk
            ZStack {
                RoundedRectangle(cornerRadius: 4).fill(Color(red: 0.30, green: 0.20, blue: 0.12))
                    .frame(width: w * 0.22, height: h * 0.13)
                Rectangle().fill(Ink.amberDim).frame(width: w * 0.22, height: 2)
                Rectangle().fill(Ink.amberDim).frame(width: 2, height: h * 0.13)
            }
            .offset(x: -w * 0.24, y: h * 0.27)
            CrateProp(s: w * 0.11).offset(x: w * 0.10, y: h * 0.30)
            // cobweb
            Path { p in
                for i in 0..<4 {
                    p.move(to: CGPoint(x: w * 0.86, y: h * 0.08))
                    p.addLine(to: CGPoint(x: w * (0.74 + 0.08 * CGFloat(i)), y: h * (0.30 - 0.05 * CGFloat(i))))
                }
            }
            .stroke(Ink.fog.opacity(0.35), lineWidth: 1)
            .offset(x: -w * 0.5, y: -h * 0.5)
            // dress form
            VStack(spacing: 0) {
                Circle().fill(Ink.charcoal).frame(width: w * 0.025)
                PersonIcon.HalfDome().fill(Color(red: 0.32, green: 0.28, blue: 0.24))
                    .frame(width: w * 0.10, height: h * 0.14)
                Rectangle().fill(Ink.charcoal).frame(width: 2, height: h * 0.07)
            }
            .offset(x: w * 0.32, y: h * 0.18)
        }
    }
}
