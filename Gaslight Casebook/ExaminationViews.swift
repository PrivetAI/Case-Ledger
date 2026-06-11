import SwiftUI

// MARK: - Location roster

struct ExaminationListView: View {
    @EnvironmentObject var store: CasebookStore
    let caseId: Int

    var body: some View {
        Group {
            if let gc = CaseLibrary.find(caseId) {
                CasebookScreen(title: "Examinations", subtitle: gc.title) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(gc.locations) { loc in
                                NavigationLink(destination:
                                    LocationExamineView(caseId: caseId, locationId: loc.id)) {
                                    locationRow(gc, loc)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .clampedContentWidth()
                        .padding(.horizontal, 20)
                        .padding(.top, 6)
                        .padding(.bottom, 30)
                    }
                }
            } else {
                CasebookScreen(title: "Examinations") { Spacer() }
            }
        }
    }

    private func locationRow(_ gc: GameCase, _ loc: CaseLocation) -> some View {
        let items = gc.evidence.filter { $0.locationId == loc.id }
        let found = items.filter { store.progress(for: gc.id).foundEvidence.contains($0.id) }.count
        return VStack(spacing: 0) {
            SceneIllustration(kind: loc.scene)
                .frame(height: 110)
                .clipShape(RoundedCornerTop(radius: 11))
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(loc.name)
                        .font(Quill.serifBold(15))
                        .foregroundColor(Ink.parchment)
                    Text("\(found) of \(items.count) pieces of evidence recovered")
                        .font(Quill.serif(12))
                        .foregroundColor(found == items.count && !items.isEmpty
                                         ? Ink.verdigris : Ink.parchmentFaint)
                }
                Spacer(minLength: 0)
                ChevronIcon(size: 11, color: Ink.parchmentFaint, pointingLeft: false)
            }
            .padding(11)
        }
        .background(
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .fill(Ink.panel)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .stroke(Ink.line, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
    }
}

/// Rounds only the top corners (for the scene strip atop a card).
struct RoundedCornerTop: Shape {
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        p.addQuadCurve(to: CGPoint(x: rect.minX + radius, y: rect.minY),
                       control: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        p.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + radius),
                       control: CGPoint(x: rect.maxX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

// MARK: - Scene examination with hotspots

struct LocationExamineView: View {
    @EnvironmentObject var store: CasebookStore
    let caseId: Int
    let locationId: String
    @State private var selectedEvidenceId: String? = nil

    var body: some View {
        Group {
            if let gc = CaseLibrary.find(caseId), let loc = gc.location(locationId) {
                examineBody(gc, loc)
            } else {
                CasebookScreen(title: "Examination") { Spacer() }
            }
        }
    }

    private func examineBody(_ gc: GameCase, _ loc: CaseLocation) -> some View {
        let items = gc.evidence.filter { $0.locationId == loc.id }
        let prog = store.progress(for: gc.id)
        return CasebookScreen(title: loc.name, subtitle: "Tap the glints to examine") {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    Text(loc.desc)
                        .font(Quill.serifItalic(store.scaled(13)))
                        .foregroundColor(Ink.parchmentDim)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 2)

                    sceneCanvas(gc, loc, items: items, prog: prog)

                    if let selId = selectedEvidenceId,
                       let item = gc.evidenceItem(selId),
                       prog.foundEvidence.contains(selId) {
                        evidenceDetail(item)
                    } else {
                        HStack(spacing: 10) {
                            MagnifierIcon(size: 18, color: Ink.amberDim)
                            Text("Amber glints mark something worth a closer look. Recovered evidence is entered in your journal.")
                                .font(Quill.serif(12))
                                .foregroundColor(Ink.parchmentFaint)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer(minLength: 0)
                        }
                        .inkCard(fill: Ink.deep)
                    }

                    foundList(gc, items: items, prog: prog)
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
                .padding(.top, 4)
                .padding(.bottom, 30)
            }
        }
    }

    private func sceneCanvas(_ gc: GameCase, _ loc: CaseLocation,
                             items: [EvidenceItem], prog: CaseProgressState) -> some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            ZStack {
                SceneIllustration(kind: loc.scene)
                ForEach(items) { item in
                    let found = prog.foundEvidence.contains(item.id)
                    Button(action: {
                        if found {
                            selectedEvidenceId = item.id
                            store.tapFeedback()
                        } else {
                            store.discoverEvidence(item.id, in: gc)
                            selectedEvidenceId = item.id
                        }
                    }) {
                        GlintMark(size: 30, found: found)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x: CGFloat(item.spotX) * w, y: CGFloat(item.spotY) * h)
                }
            }
            .frame(width: w, height: h)
        }
        .frame(height: 240)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Ink.line, lineWidth: 1)
        )
    }

    private func evidenceDetail(_ item: EvidenceItem) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                FingerprintIcon(size: 18, color: Ink.amber)
                Text(item.name)
                    .font(Quill.serifBold(15))
                    .foregroundColor(Ink.amber)
                Spacer(minLength: 0)
            }
            Text(item.desc)
                .font(Quill.serif(store.scaled(13)))
                .foregroundColor(Ink.parchment)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inkCard(stroke: Ink.amberDim.opacity(0.55))
    }

    private func foundList(_ gc: GameCase, items: [EvidenceItem], prog: CaseProgressState) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Evidence at this location")
                .font(Quill.serifBold(14))
                .foregroundColor(Ink.parchmentDim)
            ForEach(items) { item in
                let found = prog.foundEvidence.contains(item.id)
                Button(action: {
                    if found {
                        selectedEvidenceId = item.id
                        store.tapFeedback()
                    }
                }) {
                    HStack(spacing: 10) {
                        if found {
                            CheckIcon(size: 14, color: Ink.verdigris)
                        } else {
                            Circle()
                                .stroke(Ink.parchmentFaint, lineWidth: 1.4)
                                .frame(width: 13, height: 13)
                        }
                        Text(found ? item.name : "Undiscovered")
                            .font(Quill.serif(13))
                            .foregroundColor(found ? Ink.parchment : Ink.parchmentFaint)
                        Spacer(minLength: 0)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 11)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Ink.panel.opacity(found ? 1 : 0.55))
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
