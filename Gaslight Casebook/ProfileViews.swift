import SwiftUI

// MARK: - Profile & statistics

struct ProfileView: View {
    @EnvironmentObject var store: CasebookStore

    var body: some View {
        CasebookScreen(title: "Detective's Profile", subtitle: "Your record of service") {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    rankCard
                    progressionCard
                    statsCard
                    rankLadder
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
                .padding(.top, 6)
                .padding(.bottom, 30)
            }
        }
    }

    private var rankCard: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Ink.amberGlow.opacity(0.10))
                    .frame(width: 96, height: 96)
                ScalesIcon(size: 52, color: Ink.amber)
            }
            Text(store.detectiveRank.title)
                .font(Quill.serifBold(22))
                .foregroundColor(Ink.parchment)
            Text("\(store.detectivePoints) merit points earned")
                .font(Quill.serif(13))
                .foregroundColor(Ink.parchmentDim)
        }
        .frame(maxWidth: .infinity)
        .inkCard()
    }

    private var progressionCard: some View {
        let points = store.detectivePoints
        let current = store.detectiveRank
        let next = DetectiveRank(rawValue: current.rawValue + 1)
        return VStack(alignment: .leading, spacing: 8) {
            if let next = next {
                let span = max(1, next.threshold - current.threshold)
                let into = max(0, points - current.threshold)
                let frac = min(1.0, Double(into) / Double(span))
                Text("Toward \(next.title): \(points)/\(next.threshold) points")
                    .font(Quill.serifBold(13))
                    .foregroundColor(Ink.parchment)
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Ink.deep)
                        Capsule().fill(Ink.amber)
                            .frame(width: max(8, geo.size.width * CGFloat(frac)))
                    }
                }
                .frame(height: 10)
                Text("Higher verdict ranks earn more merit. An S verdict is worth four points.")
                    .font(Quill.serifItalic(11))
                    .foregroundColor(Ink.parchmentFaint)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Text("You hold the highest rank the craft can give.")
                    .font(Quill.serifBold(13))
                    .foregroundColor(Ink.amber)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inkCard()
    }

    private var statsCard: some View {
        let s = store.state
        return VStack(alignment: .leading, spacing: 10) {
            Text("Statistics")
                .font(Quill.serifBold(15))
                .foregroundColor(Ink.amber)
            statRow("Cases closed", "\(store.solvedCaseCount) of 12")
            statRow("S-rank verdicts held", "\(store.sRankCount)")
            statRow("Statements heard", "\(s.lifetimeStatementsRead)")
            statRow("Evidence recovered", "\(s.lifetimeEvidenceFound)")
            statRow("Contradictions exposed", "\(s.lifetimeContradictions)")
            statRow("Accusations dismissed", "\(s.lifetimeWrongAccusations)")
            statRow("Hints consulted", "\(s.lifetimeHintsUsed)")
            statRow("Cases reopened", "\(s.casesReplayed)")
            statRow("Commendations earned", "\(s.unlockedAchievements.count) of \(AchievementCatalog.all.count)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inkCard()
    }

    private func statRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .font(Quill.serif(13))
                .foregroundColor(Ink.parchmentDim)
            Spacer(minLength: 8)
            Text(value)
                .font(Quill.serifBold(13))
                .foregroundColor(Ink.parchment)
        }
    }

    private var rankLadder: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("The Ladder")
                .font(Quill.serifBold(15))
                .foregroundColor(Ink.amber)
            ForEach(DetectiveRank.allCases, id: \.rawValue) { rank in
                let reached = store.detectivePoints >= rank.threshold
                HStack(spacing: 10) {
                    if reached {
                        CheckIcon(size: 14, color: Ink.verdigris)
                    } else {
                        LockIcon(size: 14, color: Ink.parchmentFaint)
                    }
                    Text(rank.title)
                        .font(Quill.serif(13))
                        .foregroundColor(reached ? Ink.parchment : Ink.parchmentFaint)
                    Spacer(minLength: 0)
                    Text("\(rank.threshold) pts")
                        .font(Quill.serif(12))
                        .foregroundColor(Ink.parchmentFaint)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inkCard()
    }
}

// MARK: - Achievements

struct AchievementsView: View {
    @EnvironmentObject var store: CasebookStore

    var body: some View {
        CasebookScreen(title: "Commendations",
                       subtitle: "\(store.state.unlockedAchievements.count) of \(AchievementCatalog.all.count) earned") {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(AchievementCatalog.all) { def in
                        achievementRow(def)
                    }
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
                .padding(.top, 6)
                .padding(.bottom, 30)
            }
        }
    }

    private func achievementRow(_ def: AchievementDef) -> some View {
        let unlocked = store.state.unlockedAchievements.contains(def.id)
        return HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(unlocked ? Ink.amberGlow.opacity(0.16) : Ink.deep)
                    .overlay(Circle().stroke(unlocked ? Ink.amberDim : Ink.line, lineWidth: 1))
                MedalIcon(size: 24, color: unlocked ? Ink.amber : Ink.parchmentFaint.opacity(0.6))
            }
            .frame(width: 46, height: 46)
            VStack(alignment: .leading, spacing: 2) {
                Text(def.title)
                    .font(Quill.serifBold(14))
                    .foregroundColor(unlocked ? Ink.parchment : Ink.parchmentFaint)
                Text(def.detail)
                    .font(Quill.serif(12))
                    .foregroundColor(Ink.parchmentFaint)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
            if unlocked {
                CheckIcon(size: 14, color: Ink.verdigris)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .fill(Ink.panel.opacity(unlocked ? 1 : 0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .stroke(unlocked ? Ink.amberDim.opacity(0.45) : Ink.line.opacity(0.6), lineWidth: 1)
                )
        )
    }
}

// MARK: - Archive

struct ArchiveView: View {
    @EnvironmentObject var store: CasebookStore

    private var solvedCases: [GameCase] {
        CaseLibrary.cases.filter { store.caseEverSolved($0.id) }
    }

    var body: some View {
        CasebookScreen(title: "Closed Archive", subtitle: "Solved files, kept under seal") {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    if solvedCases.isEmpty {
                        VStack(spacing: 12) {
                            ArchiveBoxIcon(size: 44, color: Ink.parchmentFaint)
                            Text("No files are closed yet. Solve your first case and it will be archived here for revisiting.")
                                .font(Quill.serifItalic(13))
                                .foregroundColor(Ink.parchmentFaint)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.top, 50)
                        .padding(.horizontal, 16)
                    } else {
                        ForEach(solvedCases) { gc in
                            archiveRow(gc)
                        }
                    }
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
                .padding(.top, 6)
                .padding(.bottom, 30)
            }
        }
    }

    private func archiveRow(_ gc: GameCase) -> some View {
        let prog = store.progress(for: gc.id)
        return VStack(spacing: 0) {
            NavigationLink(destination: CaseHubView(caseId: gc.id)) {
                HStack(spacing: 12) {
                    if let idx = prog.bestRankIndex, let rank = CaseRank(rawValue: idx) {
                        ZStack {
                            SealScallopShape()
                                .fill(Ink.bloodWax)
                                .frame(width: 40, height: 40)
                            Text(rank.letter)
                                .font(Quill.serifBold(17))
                                .foregroundColor(Ink.parchment)
                        }
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(gc.title)
                            .font(Quill.serifBold(15))
                            .foregroundColor(Ink.parchment)
                        Text(gc.subtitle)
                            .font(Quill.serif(12))
                            .foregroundColor(Ink.parchmentFaint)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer(minLength: 0)
                    ChevronIcon(size: 11, color: Ink.parchmentFaint, pointingLeft: false)
                }
                .padding(11)
            }
            .buttonStyle(PlainButtonStyle())

            Rectangle().fill(Ink.line.opacity(0.6)).frame(height: 1)
                .padding(.horizontal, 11)

            Button(action: {
                store.replayCase(gc.id)
                store.tapFeedback()
            }) {
                HStack(spacing: 8) {
                    QuillIcon(size: 14, color: Ink.amberDim)
                    Text(prog.solved || !prog.foundEvidence.isEmpty || !prog.readStatements.isEmpty
                         ? "Reopen the file (clears working notes, keeps the rank)"
                         : "File reopened - investigate from the case hub")
                        .font(Quill.serifItalic(12))
                        .foregroundColor(Ink.amberDim)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 9)
                .padding(.horizontal, 12)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .background(
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .fill(Ink.panel)
                .overlay(
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .stroke(Ink.line, lineWidth: 1)
                )
        )
    }
}
