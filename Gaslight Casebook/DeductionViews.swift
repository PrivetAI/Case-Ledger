import SwiftUI

// MARK: - Deduction Board

struct DeductionBoardView: View {
    @EnvironmentObject var store: CasebookStore
    let caseId: Int

    @State private var slotA: ClueRef? = nil
    @State private var slotB: ClueRef? = nil
    @State private var revealed: Contradiction? = nil
    @State private var noConflict = false
    @State private var hintText: String? = nil

    var body: some View {
        Group {
            if let gc = CaseLibrary.find(caseId) {
                boardBody(gc)
            } else {
                CasebookScreen(title: "Deduction Board") { Spacer() }
            }
        }
    }

    private func boardBody(_ gc: GameCase) -> some View {
        let prog = store.progress(for: gc.id)
        return CasebookScreen(title: "Deduction Board", subtitle: gc.title) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    pairingPanel(gc)
                    if let c = revealed {
                        revealCard(c)
                    } else if noConflict {
                        noConflictCard
                    }
                    if let hint = hintText {
                        hintCard(hint)
                    }
                    hintRow(gc)
                    cluesSection(gc)
                    foundSection(gc, prog: prog)
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
                .padding(.top, 6)
                .padding(.bottom, 30)
            }
        }
    }

    // MARK: Pairing panel

    private func pairingPanel(_ gc: GameCase) -> some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                slotView(gc, ref: slotA, label: "First Clue") { slotA = nil }
                LinkIcon(size: 20, color: Ink.amberDim)
                slotView(gc, ref: slotB, label: "Second Clue") { slotB = nil }
            }
            Button(action: { testPair(gc) }) {
                Text("Test the Pair")
                    .font(Quill.serifBold(15))
                    .foregroundColor(slotA != nil && slotB != nil ? Ink.night : Ink.parchmentFaint)
            }
            .buttonStyle(LampButtonStyle(prominent: slotA != nil && slotB != nil))
            .disabled(slotA == nil || slotB == nil)
        }
        .inkCard()
    }

    private func slotView(_ gc: GameCase, ref: ClueRef?, label: String,
                          clear: @escaping () -> Void) -> some View {
        Button(action: { if ref != nil { clear(); store.tapFeedback() } }) {
            VStack(spacing: 4) {
                Text(label)
                    .font(Quill.serifItalic(10))
                    .foregroundColor(Ink.parchmentFaint)
                if let ref = ref {
                    Text(gc.clueTitle(ref))
                        .font(Quill.serifBold(12))
                        .foregroundColor(Ink.amber)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    Text(gc.clueBody(ref))
                        .font(Quill.serif(10))
                        .foregroundColor(Ink.parchmentDim)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                } else {
                    Text("Empty")
                        .font(Quill.serif(12))
                        .foregroundColor(Ink.parchmentFaint)
                    Text("Choose from the clues below")
                        .font(Quill.serif(10))
                        .foregroundColor(Ink.parchmentFaint.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(8)
            .frame(maxWidth: .infinity, minHeight: 86)
            .background(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(Ink.deep)
                    .overlay(
                        RoundedRectangle(cornerRadius: 9, style: .continuous)
                            .stroke(ref != nil ? Ink.amberDim.opacity(0.6) : Ink.line,
                                    style: StrokeStyle(lineWidth: 1, dash: ref == nil ? [5, 4] : []))
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func testPair(_ gc: GameCase) {
        guard let a = slotA, let b = slotB else { return }
        hintText = nil
        if a == b {
            revealed = nil
            noConflict = true
            store.failFeedback()
            slotB = nil
            return
        }
        if let match = store.tryPair(a, b, in: gc) {
            revealed = match
            noConflict = false
            slotA = nil
            slotB = nil
        } else {
            revealed = nil
            noConflict = true
        }
    }

    private func revealCard(_ c: Contradiction) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                PulseIcon(size: 18, color: Ink.waxBright)
                Text("Contradiction Exposed")
                    .font(Quill.serifBold(13))
                    .foregroundColor(Ink.waxBright)
                Spacer(minLength: 0)
            }
            Text(c.title)
                .font(Quill.serifBold(16))
                .foregroundColor(Ink.parchment)
            Text(c.explanation)
                .font(Quill.serif(store.scaled(13)))
                .foregroundColor(Ink.parchmentDim)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(2)
            Text("Check the interviews - exposed lies can force new statements into the open.")
                .font(Quill.serifItalic(11))
                .foregroundColor(Ink.parchmentFaint)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inkCard(stroke: Ink.waxBright.opacity(0.55))
    }

    private var noConflictCard: some View {
        HStack(spacing: 10) {
            CrossIcon(size: 14, color: Ink.parchmentFaint)
            Text("These two hold together. Whatever the truth is, it is not caught between them.")
                .font(Quill.serifItalic(12))
                .foregroundColor(Ink.parchmentFaint)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .inkCard(fill: Ink.deep)
    }

    // MARK: Hints

    private func hintRow(_ gc: GameCase) -> some View {
        let left = store.hintsLeft(gc.id)
        let candidate = store.hintCandidate(in: gc)
        return Button(action: {
            guard left > 0, let c = candidate else { return }
            store.consumeHint(gc.id)
            store.tapFeedback()
            hintText = "Weigh what \(gc.clueTitle(c.a)) offers against \(gc.clueTitle(c.b)). One of the two is carrying a lie."
        }) {
            HStack(spacing: 10) {
                GasLampIcon(size: 22, color: left > 0 ? Ink.amber : Ink.parchmentFaint)
                VStack(alignment: .leading, spacing: 1) {
                    Text("Consult the Lamplighter's hunch")
                        .font(Quill.serifBold(13))
                        .foregroundColor(left > 0 && candidate != nil ? Ink.parchment : Ink.parchmentFaint)
                    Text(left > 0
                         ? (candidate != nil ? "\(left) hint\(left == 1 ? "" : "s") remaining - each costs standing"
                                             : "Nothing more can be hinted at just now")
                         : "No hints remain for this case")
                        .font(Quill.serif(11))
                        .foregroundColor(Ink.parchmentFaint)
                }
                Spacer(minLength: 0)
            }
            .padding(11)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Ink.panel)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Ink.line, lineWidth: 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(left == 0 || candidate == nil)
    }

    private func hintCard(_ hint: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            GasLampIcon(size: 20, color: Ink.amber)
            Text(hint)
                .font(Quill.serifItalic(13))
                .foregroundColor(Ink.amberGlow)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .inkCard(stroke: Ink.amberDim.opacity(0.6))
    }

    // MARK: Clue list

    private func cluesSection(_ gc: GameCase) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Statements")
                .font(Quill.serifBold(14))
                .foregroundColor(Ink.parchmentDim)
            ForEach(gc.suspects) { suspect in
                let visible = store.visibleStatements(of: gc, for: suspect.id)
                if !visible.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(suspect.name)
                            .font(Quill.serifItalic(12))
                            .foregroundColor(Ink.amberDim)
                        ForEach(visible) { st in
                            clueRow(gc, ref: .statement(st.id), text: st.text)
                        }
                    }
                }
            }
            let foundEv = gc.evidence.filter {
                store.progress(for: gc.id).foundEvidence.contains($0.id)
            }
            Text("Evidence")
                .font(Quill.serifBold(14))
                .foregroundColor(Ink.parchmentDim)
                .padding(.top, 4)
            if foundEv.isEmpty {
                Text("Nothing recovered yet. Examine the locations first.")
                    .font(Quill.serifItalic(12))
                    .foregroundColor(Ink.parchmentFaint)
            } else {
                ForEach(foundEv) { ev in
                    clueRow(gc, ref: .evidence(ev.id), text: ev.desc, name: ev.name)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func clueRow(_ gc: GameCase, ref: ClueRef, text: String, name: String? = nil) -> some View {
        let isSelected = slotA == ref || slotB == ref
        return Button(action: { select(ref) }) {
            VStack(alignment: .leading, spacing: 3) {
                if let name = name {
                    Text(name)
                        .font(Quill.serifBold(12))
                        .foregroundColor(isSelected ? Ink.amber : Ink.parchment)
                }
                Text(text)
                    .font(Quill.serif(12))
                    .foregroundColor(isSelected ? Ink.amberGlow : Ink.parchmentDim)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(isSelected ? Ink.panelLight : Ink.panel.opacity(0.7))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(isSelected ? Ink.amberDim.opacity(0.8) : Ink.line.opacity(0.6),
                                    lineWidth: 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func select(_ ref: ClueRef) {
        store.tapFeedback()
        revealed = nil
        noConflict = false
        if slotA == ref { slotA = nil; return }
        if slotB == ref { slotB = nil; return }
        if slotA == nil { slotA = ref }
        else if slotB == nil { slotB = ref }
        else { slotB = ref }
    }

    // MARK: Found contradictions

    @ViewBuilder
    private func foundSection(_ gc: GameCase, prog: CaseProgressState) -> some View {
        let found = gc.contradictions.filter { prog.foundContradictions.contains($0.id) }
        VStack(alignment: .leading, spacing: 8) {
            Text("Contradictions Exposed (\(found.count)/\(gc.contradictions.count))")
                .font(Quill.serifBold(14))
                .foregroundColor(Ink.parchmentDim)
                .padding(.top, 4)
            if found.isEmpty {
                Text("None yet. Lies survive alone; pair them and they break.")
                    .font(Quill.serifItalic(12))
                    .foregroundColor(Ink.parchmentFaint)
            } else {
                ForEach(found) { c in
                    VStack(alignment: .leading, spacing: 3) {
                        Text(c.title)
                            .font(Quill.serifBold(13))
                            .foregroundColor(Ink.waxBright)
                        Text(c.explanation)
                            .font(Quill.serif(12))
                            .foregroundColor(Ink.parchmentDim)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .inkCard(padding: 10, fill: Ink.deep)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Journal

struct JournalView: View {
    @EnvironmentObject var store: CasebookStore
    let caseId: Int
    @State private var tab = 0

    var body: some View {
        Group {
            if let gc = CaseLibrary.find(caseId) {
                journalBody(gc)
            } else {
                CasebookScreen(title: "Journal") { Spacer() }
            }
        }
    }

    private func journalBody(_ gc: GameCase) -> some View {
        let prog = store.progress(for: gc.id)
        return CasebookScreen(title: "Journal", subtitle: gc.title) {
            VStack(spacing: 0) {
                segmentBar
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        switch tab {
                        case 0: statementsTab(gc, prog: prog)
                        case 1: evidenceTab(gc, prog: prog)
                        default: contradictionsTab(gc, prog: prog)
                        }
                    }
                    .clampedContentWidth()
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                }
            }
        }
    }

    private var segmentBar: some View {
        HStack(spacing: 8) {
            segButton(0, "Statements")
            segButton(1, "Evidence")
            segButton(2, "Conflicts")
        }
        .padding(.horizontal, 20)
        .padding(.top, 4)
    }

    private func segButton(_ index: Int, _ label: String) -> some View {
        Button(action: { tab = index; store.tapFeedback() }) {
            Text(label)
                .font(Quill.serifBold(13))
                .foregroundColor(tab == index ? Ink.night : Ink.parchmentDim)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(tab == index ? Ink.amber : Ink.panel)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(tab == index ? Ink.amberGlow.opacity(0.6) : Ink.line, lineWidth: 1)
                        )
                )
        }
        .buttonStyle(PlainButtonStyle())
    }

    @ViewBuilder
    private func statementsTab(_ gc: GameCase, prog: CaseProgressState) -> some View {
        let heard = gc.statements.filter { prog.readStatements.contains($0.id) }
        if heard.isEmpty {
            emptyNote("No statements heard yet. Begin with the interviews.")
        } else {
            ForEach(gc.suspects) { suspect in
                let theirs = heard.filter { $0.suspectId == suspect.id }
                if !theirs.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(suspect.name)
                            .font(Quill.serifBold(14))
                            .foregroundColor(Ink.amberDim)
                        ForEach(theirs) { st in
                            Text("\u{201C}\(st.text)\u{201D}")
                                .font(Quill.serif(store.scaled(12)))
                                .foregroundColor(Ink.parchmentDim)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .inkCard(padding: 9, fill: Ink.deep)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }

    @ViewBuilder
    private func evidenceTab(_ gc: GameCase, prog: CaseProgressState) -> some View {
        let found = gc.evidence.filter { prog.foundEvidence.contains($0.id) }
        if found.isEmpty {
            emptyNote("Nothing recovered yet. Examine the locations.")
        } else {
            ForEach(found) { item in
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 7) {
                        FingerprintIcon(size: 15, color: Ink.amber)
                        Text(item.name)
                            .font(Quill.serifBold(13))
                            .foregroundColor(Ink.parchment)
                        Spacer(minLength: 0)
                        Text(gc.location(item.locationId)?.name ?? "")
                            .font(Quill.serifItalic(10))
                            .foregroundColor(Ink.parchmentFaint)
                    }
                    Text(item.desc)
                        .font(Quill.serif(store.scaled(12)))
                        .foregroundColor(Ink.parchmentDim)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .inkCard(padding: 10)
            }
        }
    }

    @ViewBuilder
    private func contradictionsTab(_ gc: GameCase, prog: CaseProgressState) -> some View {
        let found = gc.contradictions.filter { prog.foundContradictions.contains($0.id) }
        if found.isEmpty {
            emptyNote("No contradictions exposed yet. Work the deduction board.")
        } else {
            ForEach(found) { c in
                VStack(alignment: .leading, spacing: 4) {
                    Text(c.title)
                        .font(Quill.serifBold(13))
                        .foregroundColor(Ink.waxBright)
                    Text(c.explanation)
                        .font(Quill.serif(store.scaled(12)))
                        .foregroundColor(Ink.parchmentDim)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .inkCard(padding: 10)
            }
        }
    }

    private func emptyNote(_ text: String) -> some View {
        Text(text)
            .font(Quill.serifItalic(13))
            .foregroundColor(Ink.parchmentFaint)
            .multilineTextAlignment(.center)
            .padding(.top, 30)
    }
}
