import SwiftUI

/// Accusation: pick culprit, motive and key evidence; verdict replaces the form.
struct AccusationView: View {
    @EnvironmentObject var store: CasebookStore
    @Environment(\.presentationMode) private var presentationMode
    let caseId: Int

    @State private var culpritId: String? = nil
    @State private var motive: String? = nil
    @State private var evidenceId: String? = nil
    @State private var verdictRank: CaseRank? = nil
    @State private var dismissedCount = 0
    @State private var showDismissed = false

    var body: some View {
        Group {
            if let gc = CaseLibrary.find(caseId) {
                if let rank = verdictRank {
                    VerdictView(gameCase: gc, rank: rank) {
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    accusationBody(gc)
                }
            } else {
                CasebookScreen(title: "Accusation") { Spacer() }
            }
        }
    }

    private func accusationBody(_ gc: GameCase) -> some View {
        let foundEv = gc.evidence.filter {
            store.progress(for: gc.id).foundEvidence.contains($0.id)
        }
        return CasebookScreen(title: "The Accusation", subtitle: gc.title) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    Text("Name the culprit, the motive, and the single piece of evidence that proves the charge. The magistrate accepts no half-built case - all three must hold.")
                        .font(Quill.serifItalic(store.scaled(13)))
                        .foregroundColor(Ink.parchmentDim)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if showDismissed {
                        dismissedCard
                    }

                    sectionLabel("Who is guilty?")
                    culpritGrid(gc)

                    sectionLabel("Why was it done?")
                    motiveList(gc)

                    sectionLabel("What proves it?")
                    if foundEv.isEmpty {
                        Text("You have recovered no evidence. The magistrate will hear nothing without proof in hand.")
                            .font(Quill.serifItalic(12))
                            .foregroundColor(Ink.waxBright)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        evidenceList(foundEv)
                    }

                    Button(action: { submit(gc) }) {
                        Text("Lay the Charge")
                            .font(Quill.serifBold(16))
                            .foregroundColor(canSubmit ? Ink.night : Ink.parchmentFaint)
                    }
                    .buttonStyle(LampButtonStyle(prominent: canSubmit))
                    .disabled(!canSubmit)
                    .padding(.top, 4)
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
                .padding(.top, 6)
                .padding(.bottom, 30)
            }
        }
    }

    private var canSubmit: Bool {
        culpritId != nil && motive != nil && evidenceId != nil
    }

    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(Quill.serifBold(15))
            .foregroundColor(Ink.amber)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func culpritGrid(_ gc: GameCase) -> some View {
        let columns = [GridItem(.adaptive(minimum: 96), spacing: 10)]
        return LazyVGrid(columns: columns, spacing: 10) {
            ForEach(gc.suspects) { suspect in
                Button(action: {
                    culpritId = suspect.id
                    store.tapFeedback()
                }) {
                    VStack(spacing: 6) {
                        PortraitView(spec: suspect.portrait, size: 64)
                        Text(suspect.name)
                            .font(Quill.serifBold(11))
                            .foregroundColor(culpritId == suspect.id ? Ink.amber : Ink.parchment)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.7)
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, minHeight: 116)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(culpritId == suspect.id ? Ink.panelLight : Ink.panel.opacity(0.7))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(culpritId == suspect.id ? Ink.amber : Ink.line, lineWidth: culpritId == suspect.id ? 2 : 1)
                            )
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

    private func motiveList(_ gc: GameCase) -> some View {
        VStack(spacing: 8) {
            ForEach(gc.motiveOptions, id: \.self) { option in
                selectRow(text: option, selected: motive == option) {
                    motive = option
                    store.tapFeedback()
                }
            }
        }
    }

    private func evidenceList(_ items: [EvidenceItem]) -> some View {
        VStack(spacing: 8) {
            ForEach(items) { item in
                selectRow(text: item.name, selected: evidenceId == item.id) {
                    evidenceId = item.id
                    store.tapFeedback()
                }
            }
        }
    }

    private func selectRow(text: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .stroke(selected ? Ink.amber : Ink.parchmentFaint, lineWidth: 1.6)
                        .frame(width: 18, height: 18)
                    if selected {
                        Circle().fill(Ink.amber).frame(width: 10, height: 10)
                    }
                }
                Text(text)
                    .font(Quill.serif(store.scaled(13)))
                    .foregroundColor(selected ? Ink.parchment : Ink.parchmentDim)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 0)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(selected ? Ink.panelLight : Ink.panel.opacity(0.7))
                    .overlay(
                        RoundedRectangle(cornerRadius: 9, style: .continuous)
                            .stroke(selected ? Ink.amberDim.opacity(0.8) : Ink.line, lineWidth: 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var dismissedCard: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 8) {
                CrossIcon(size: 14, color: Ink.waxBright)
                Text("Accusation Dismissed")
                    .font(Quill.serifBold(14))
                    .foregroundColor(Ink.waxBright)
                Spacer(minLength: 0)
            }
            Text("The magistrate finds the charge unproven and notes the failure against your record. Reconsider the culprit, the motive, or the proof - at least one of the three is wrong.")
                .font(Quill.serif(12))
                .foregroundColor(Ink.parchmentDim)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inkCard(stroke: Ink.waxBright.opacity(0.6))
    }

    private func submit(_ gc: GameCase) {
        guard let cid = culpritId, let m = motive, let eid = evidenceId else { return }
        if let rank = store.makeAccusation(caseId: gc.id, culpritId: cid, motive: m, evidenceId: eid) {
            withAnimation(.easeInOut(duration: 0.3)) { verdictRank = rank }
        } else {
            dismissedCount += 1
            withAnimation(.easeInOut(duration: 0.25)) { showDismissed = true }
        }
    }
}

// MARK: - Verdict

struct VerdictView: View {
    @EnvironmentObject var store: CasebookStore
    let gameCase: GameCase
    let rank: CaseRank
    let onDone: () -> Void

    var body: some View {
        ZStack {
            GaslightBackdrop()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    Text("Verdict Delivered")
                        .font(Quill.serifItalic(14))
                        .foregroundColor(Ink.amberDim)
                        .padding(.top, 28)
                    Text(gameCase.title)
                        .font(Quill.serifBold(24))
                        .foregroundColor(Ink.parchment)
                        .multilineTextAlignment(.center)

                    ZStack {
                        SealScallopShape()
                            .fill(Ink.bloodWax)
                            .frame(width: 110, height: 110)
                        SealScallopShape()
                            .stroke(Ink.waxBright.opacity(0.7), lineWidth: 2)
                            .frame(width: 110, height: 110)
                        Text(rank.letter)
                            .font(Quill.serifBold(46))
                            .foregroundColor(Ink.parchment)
                    }
                    Text(rankCaption)
                        .font(Quill.serifItalic(13))
                        .foregroundColor(Ink.parchmentDim)
                        .multilineTextAlignment(.center)

                    if let culprit = gameCase.suspect(gameCase.solution.culpritId) {
                        VStack(spacing: 10) {
                            PortraitView(spec: culprit.portrait, size: 80)
                            Text("\(culprit.name) - guilty.")
                                .font(Quill.serifBold(15))
                                .foregroundColor(Ink.waxBright)
                        }
                    }

                    Text(gameCase.solution.reveal)
                        .font(Quill.serif(store.scaled(14)))
                        .foregroundColor(Ink.parchment)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .inkCard()

                    HStack(spacing: 10) {
                        ScalesIcon(size: 22, color: Ink.amber)
                        Text("Standing: \(store.detectiveRank.title), \(store.detectivePoints) merit points")
                            .font(Quill.serif(13))
                            .foregroundColor(Ink.parchmentDim)
                        Spacer(minLength: 0)
                    }
                    .inkCard(fill: Ink.deep)

                    Button(action: onDone) {
                        Text("Close the File")
                            .font(Quill.serifBold(16))
                            .foregroundColor(Ink.night)
                    }
                    .buttonStyle(LampButtonStyle())
                    .padding(.bottom, 34)
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
            }
        }
        .navigationBarHidden(true)
    }

    private var rankCaption: String {
        switch rank {
        case .s: return "A flawless investigation. The Yard takes note."
        case .a: return "A clean case, sharply made."
        case .b: return "Justice done, if by a winding road."
        case .c: return "The truth arrived - bruised, but standing."
        }
    }
}
