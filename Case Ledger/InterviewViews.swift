import SwiftUI

// MARK: - Suspect roster

struct InterviewListView: View {
    @EnvironmentObject var store: CasebookStore
    let caseId: Int

    var body: some View {
        Group {
            if let gc = CaseLibrary.find(caseId) {
                CasebookScreen(title: "Interviews", subtitle: gc.title) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(gc.suspects) { suspect in
                                NavigationLink(destination:
                                    SuspectInterviewView(caseId: caseId, suspectId: suspect.id)) {
                                    suspectRow(gc, suspect)
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
                CasebookScreen(title: "Interviews") { Spacer() }
            }
        }
    }

    private func suspectRow(_ gc: GameCase, _ suspect: Suspect) -> some View {
        let visible = store.visibleStatements(of: gc, for: suspect.id)
        let prog = store.progress(for: gc.id)
        let unread = visible.filter { !prog.readStatements.contains($0.id) }.count
        let hidden = store.hiddenStatementCount(of: gc, for: suspect.id)
        return HStack(spacing: 13) {
            PortraitView(spec: suspect.portrait, size: 56)
            VStack(alignment: .leading, spacing: 2) {
                Text(suspect.name)
                    .font(Quill.serifBold(15))
                    .foregroundColor(Ink.parchment)
                Text(suspect.role)
                    .font(Quill.serifItalic(12))
                    .foregroundColor(Ink.parchmentDim)
                HStack(spacing: 8) {
                    Text("\(visible.count) statement\(visible.count == 1 ? "" : "s")")
                        .font(Quill.serif(11))
                        .foregroundColor(Ink.parchmentFaint)
                    if unread > 0 {
                        Text("\(unread) unheard")
                            .font(Quill.serifBold(11))
                            .foregroundColor(Ink.amber)
                    }
                    if hidden > 0 {
                        Text("\(hidden) withheld")
                            .font(Quill.serif(11))
                            .foregroundColor(Ink.waxBright)
                    }
                }
            }
            Spacer(minLength: 0)
            ChevronIcon(size: 11, color: Ink.parchmentFaint, pointingLeft: false)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .fill(Ink.panel)
                .overlay(
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .stroke(unread > 0 ? Ink.amberDim.opacity(0.55) : Ink.line, lineWidth: 1)
                )
        )
    }
}

// MARK: - Single suspect interview

struct SuspectInterviewView: View {
    @EnvironmentObject var store: CasebookStore
    let caseId: Int
    let suspectId: String

    var body: some View {
        Group {
            if let gc = CaseLibrary.find(caseId), let suspect = gc.suspect(suspectId) {
                interviewBody(gc, suspect)
            } else {
                CasebookScreen(title: "Interview") { Spacer() }
            }
        }
    }

    private func interviewBody(_ gc: GameCase, _ suspect: Suspect) -> some View {
        let visible = store.visibleStatements(of: gc, for: suspect.id)
        let hidden = store.hiddenStatementCount(of: gc, for: suspect.id)
        return CasebookScreen(title: suspect.name, subtitle: suspect.role) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    headerCard(suspect)
                    ForEach(visible) { st in
                        statementCard(st)
                    }
                    if hidden > 0 {
                        withheldCard(hidden)
                    }
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
                .padding(.top, 6)
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            store.markStatementsRead(visible.map { $0.id }, caseId: gc.id)
        }
    }

    private func headerCard(_ suspect: Suspect) -> some View {
        HStack(alignment: .top, spacing: 14) {
            PortraitView(spec: suspect.portrait, size: 84)
            VStack(alignment: .leading, spacing: 4) {
                Text(suspect.name)
                    .font(Quill.serifBold(17))
                    .foregroundColor(Ink.parchment)
                Text(suspect.role)
                    .font(Quill.serifItalic(12))
                    .foregroundColor(Ink.amberDim)
                Text(suspect.bio)
                    .font(Quill.serif(store.scaled(12)))
                    .foregroundColor(Ink.parchmentDim)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .inkCard()
    }

    private func statementCard(_ st: CaseStatement) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 7) {
                QuillIcon(size: 13, color: Ink.amberDim)
                Text(unlockLabel(st))
                    .font(Quill.serifItalic(11))
                    .foregroundColor(Ink.parchmentFaint)
                Spacer(minLength: 0)
            }
            Text("\u{201C}\(st.text)\u{201D}")
                .font(Quill.serif(store.scaled(14)))
                .foregroundColor(Ink.parchment)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inkCard(fill: Ink.panel)
    }

    private func unlockLabel(_ st: CaseStatement) -> String {
        switch st.unlock {
        case .initial: return "Given freely"
        case .evidence: return "Drawn out by evidence"
        case .contradiction: return "Forced by a contradiction"
        }
    }

    private func withheldCard(_ count: Int) -> some View {
        HStack(spacing: 10) {
            LockIcon(size: 16, color: Ink.parchmentFaint)
            Text(count == 1
                 ? "One statement is being withheld. Find evidence or expose contradictions to draw it out."
                 : "\(count) statements are being withheld. Find evidence or expose contradictions to draw them out.")
                .font(Quill.serifItalic(12))
                .foregroundColor(Ink.parchmentFaint)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .inkCard(fill: Ink.deep)
    }
}
