import SwiftUI

/// Per-case hub: the brief, progress, and doors into every investigative tool.
struct CaseHubView: View {
    @EnvironmentObject var store: CasebookStore
    let caseId: Int
    @State private var showTutorialIntro = false

    private var gameCase: GameCase? { CaseLibrary.find(caseId) }

    var body: some View {
        Group {
            if let gc = gameCase {
                hubBody(gc)
            } else {
                CasebookScreen(title: "Missing File") {
                    Spacer()
                }
            }
        }
    }

    private func hubBody(_ gc: GameCase) -> some View {
        let prog = store.progress(for: gc.id)
        return ZStack {
            CasebookScreen(title: gc.id == 0 ? "Training Case" : "Case No. \(gc.id)",
                           subtitle: gc.title) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        briefCard(gc)
                        progressCard(gc, prog: prog)
                        toolLinks(gc, prog: prog)
                        if store.caseEverSolved(gc.id) {
                            solvedBanner(gc, prog: prog)
                        }
                    }
                    .clampedContentWidth()
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    .padding(.bottom, 30)
                }
            }
            if showTutorialIntro {
                tutorialIntroOverlay
            }
        }
        .onAppear {
            store.markBriefOpened(gc.id)
            if gc.id == 0 && !store.state.onboardingDone {
                showTutorialIntro = true
            }
        }
    }

    // MARK: Brief

    private func briefCard(_ gc: GameCase) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                WaxSealIcon(size: 26, letter: gc.id == 0 ? "T" : "\(gc.id)")
                Text("The Brief")
                    .font(Quill.serifBold(15))
                    .foregroundColor(Ink.amber)
                Spacer(minLength: 0)
            }
            Text(gc.subtitle)
                .font(Quill.serifItalic(13))
                .foregroundColor(Ink.parchmentDim)
            Text(gc.brief)
                .font(Quill.serif(store.scaled(14)))
                .foregroundColor(Ink.parchment)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inkCard()
    }

    // MARK: Progress

    private func progressCard(_ gc: GameCase, prog: CaseProgressState) -> some View {
        HStack(spacing: 0) {
            progressCell(value: prog.readStatements.count, total: gc.statements.count, label: "Statements")
            divider
            progressCell(value: prog.foundEvidence.count, total: gc.evidence.count, label: "Evidence")
            divider
            progressCell(value: prog.foundContradictions.count, total: gc.contradictions.count, label: "Conflicts")
            divider
            progressCell(value: store.hintsLeft(gc.id), total: 3, label: "Hints Left")
        }
        .inkCard(padding: 10)
    }

    private var divider: some View {
        Rectangle().fill(Ink.line).frame(width: 1, height: 34)
    }

    private func progressCell(value: Int, total: Int, label: String) -> some View {
        VStack(spacing: 2) {
            Text("\(value)/\(total)")
                .font(Quill.serifBold(15))
                .foregroundColor(Ink.parchment)
            Text(label)
                .font(Quill.serif(10))
                .foregroundColor(Ink.parchmentFaint)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: Tool links

    private func toolLinks(_ gc: GameCase, prog: CaseProgressState) -> some View {
        VStack(spacing: 11) {
            NavigationLink(destination: InterviewListView(caseId: gc.id)) {
                toolRow(icon: AnyView(PersonIcon(size: 24, color: Ink.amber)),
                        title: "Interviews",
                        detail: "\(gc.suspects.count) suspects await your questions")
            }
            .buttonStyle(PlainButtonStyle())
            NavigationLink(destination: ExaminationListView(caseId: gc.id)) {
                toolRow(icon: AnyView(MagnifierIcon(size: 24, color: Ink.amber)),
                        title: "Examinations",
                        detail: "\(gc.locations.count) locations to search for evidence")
            }
            .buttonStyle(PlainButtonStyle())
            NavigationLink(destination: DeductionBoardView(caseId: gc.id)) {
                toolRow(icon: AnyView(LinkIcon(size: 24, color: Ink.amber)),
                        title: "Deduction Board",
                        detail: "Pair clues to expose contradictions")
            }
            .buttonStyle(PlainButtonStyle())
            NavigationLink(destination: JournalView(caseId: gc.id)) {
                toolRow(icon: AnyView(BookIcon(size: 24, color: Ink.amber)),
                        title: "Journal",
                        detail: "Everything gathered, in one ledger")
            }
            .buttonStyle(PlainButtonStyle())
            NavigationLink(destination: AccusationView(caseId: gc.id)) {
                toolRow(icon: AnyView(ScalesIcon(size: 24, color: Ink.night)),
                        title: "Make the Accusation",
                        detail: "Name culprit, motive and proof",
                        prominent: true)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    private func toolRow(icon: AnyView, title: String, detail: String,
                         prominent: Bool = false) -> some View {
        HStack(spacing: 13) {
            ZStack {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(prominent ? Ink.amberGlow.opacity(0.85) : Ink.panelLight)
                icon
            }
            .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(Quill.serifBold(15))
                    .foregroundColor(prominent ? Ink.night : Ink.parchment)
                Text(detail)
                    .font(Quill.serif(12))
                    .foregroundColor(prominent ? Ink.night.opacity(0.7) : Ink.parchmentFaint)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
            ChevronIcon(size: 11, color: prominent ? Ink.night.opacity(0.6) : Ink.parchmentFaint,
                        pointingLeft: false)
        }
        .padding(11)
        .background(
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .fill(prominent ? Ink.amber : Ink.panel)
                .overlay(
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .stroke(prominent ? Ink.amberGlow.opacity(0.7) : Ink.line, lineWidth: 1)
                )
        )
    }

    private func solvedBanner(_ gc: GameCase, prog: CaseProgressState) -> some View {
        HStack(spacing: 12) {
            CheckIcon(size: 20, color: Ink.verdigris)
            VStack(alignment: .leading, spacing: 2) {
                Text("Case Closed")
                    .font(Quill.serifBold(14))
                    .foregroundColor(Ink.verdigris)
                if let idx = prog.bestRankIndex, let rank = CaseRank(rawValue: idx) {
                    Text("Best verdict: rank \(rank.letter)")
                        .font(Quill.serif(12))
                        .foregroundColor(Ink.parchmentDim)
                }
            }
            Spacer(minLength: 0)
        }
        .inkCard(stroke: Ink.verdigris.opacity(0.5))
    }

    // MARK: First-run tutorial overlay (Case 0)

    private var tutorialIntroOverlay: some View {
        ZStack {
            Color.black.opacity(0.72).edgesIgnoringSafeArea(.all)
            VStack(spacing: 14) {
                GasLampIcon(size: 44, color: Ink.amberDim)
                Text("Welcome to the Yard, Detective")
                    .font(Quill.serifBold(19))
                    .foregroundColor(Ink.parchment)
                    .multilineTextAlignment(.center)
                Text("The method is simple and unforgiving: read the brief, hear the suspects, search the scenes, and pair what cannot both be true on the Deduction Board. When the contradictions have done their work, make your accusation.")
                    .font(Quill.serif(14))
                    .foregroundColor(Ink.parchmentDim)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineSpacing(3)
                Text("The full method is written up under How to Investigate, on the main menu.")
                    .font(Quill.serifItalic(12))
                    .foregroundColor(Ink.parchmentFaint)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                Button(action: {
                    store.state.onboardingDone = true
                    store.tapFeedback()
                    withAnimation(.easeOut(duration: 0.25)) { showTutorialIntro = false }
                }) {
                    Text("Take the Case")
                        .font(Quill.serifBold(16))
                        .foregroundColor(Ink.night)
                }
                .buttonStyle(LampButtonStyle())
            }
            .padding(22)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Ink.panel)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Ink.amberDim.opacity(0.6), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 28)
            .frame(maxWidth: 480)
        }
    }
}
