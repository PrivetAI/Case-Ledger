import SwiftUI

// MARK: - Shared screen chrome

/// Custom header bar with a back chevron, used on every pushed screen.
struct CasebookHeader: View {
    let title: String
    var subtitle: String? = nil
    var onBack: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 12) {
            if let onBack = onBack {
                Button(action: onBack) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Ink.panelLight)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .stroke(Ink.line, lineWidth: 1)
                            )
                        ChevronIcon(size: 14, color: Ink.parchment, pointingLeft: true)
                    }
                    .frame(width: 38, height: 38)
                }
                .buttonStyle(PlainButtonStyle())
            }
            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(Quill.serifBold(19))
                    .foregroundColor(Ink.parchment)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                if let sub = subtitle {
                    Text(sub)
                        .font(Quill.serifItalic(12))
                        .foregroundColor(Ink.parchmentFaint)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

/// Standard screen scaffold: backdrop + header + content.
struct CasebookScreen<Content: View>: View {
    @Environment(\.presentationMode) private var presentationMode
    let title: String
    var subtitle: String? = nil
    var showBack: Bool = true
    @ViewBuilder var content: Content

    var body: some View {
        ZStack {
            GaslightBackdrop()
            VStack(spacing: 0) {
                CasebookHeader(title: title, subtitle: subtitle,
                               onBack: showBack ? { presentationMode.wrappedValue.dismiss() } : nil)
                content
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Main menu

struct MainMenuView: View {
    @EnvironmentObject var store: CasebookStore

    var body: some View {
        ZStack {
            GaslightBackdrop()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    VStack(spacing: 10) {
                        ZStack {
                            Circle()
                                .fill(Ink.amberGlow.opacity(0.10))
                                .frame(width: 120, height: 120)
                            GasLampIcon(size: 70, color: Ink.amberDim)
                        }
                        Text("Gaslight Casebook")
                            .font(Quill.serifBold(30))
                            .foregroundColor(Ink.parchment)
                            .multilineTextAlignment(.center)
                        Text("Deduction in the fog of old London")
                            .font(Quill.serifItalic(14))
                            .foregroundColor(Ink.parchmentDim)
                    }
                    .padding(.top, 26)

                    rankCard

                    VStack(spacing: 12) {
                        NavigationLink(destination: CaseMapView()) {
                            menuRow(icon: AnyView(MapIcon(size: 26, color: Ink.night)),
                                    title: "The Casebook",
                                    detail: "Open the city's unsolved files",
                                    prominent: true)
                        }
                        .buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: ProfileView()) {
                            menuRow(icon: AnyView(PersonIcon(size: 26, color: Ink.parchment)),
                                    title: "Detective's Profile",
                                    detail: "Rank, record and statistics")
                        }
                        .buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: AchievementsView()) {
                            menuRow(icon: AnyView(MedalIcon(size: 26, color: Ink.parchment)),
                                    title: "Commendations",
                                    detail: "Honours earned in service")
                        }
                        .buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: ArchiveView()) {
                            menuRow(icon: AnyView(ArchiveBoxIcon(size: 26, color: Ink.parchment)),
                                    title: "Closed Archive",
                                    detail: "Revisit solved cases")
                        }
                        .buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: TutorialView()) {
                            menuRow(icon: AnyView(BookIcon(size: 26, color: Ink.parchment)),
                                    title: "How to Investigate",
                                    detail: "The detective's method, in brief")
                        }
                        .buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: SettingsView()) {
                            menuRow(icon: AnyView(GearIcon(size: 26, color: Ink.parchment)),
                                    title: "Settings",
                                    detail: "Sound, haptics and text size")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .clampedContentWidth()
            }
        }
        .navigationBarHidden(true)
    }

    private var rankCard: some View {
        HStack(spacing: 12) {
            ScalesIcon(size: 30, color: Ink.amber)
            VStack(alignment: .leading, spacing: 2) {
                Text(store.detectiveRank.title)
                    .font(Quill.serifBold(16))
                    .foregroundColor(Ink.parchment)
                Text("\(store.solvedCaseCount) of 12 cases closed")
                    .font(Quill.serif(12))
                    .foregroundColor(Ink.parchmentDim)
            }
            Spacer(minLength: 0)
        }
        .inkCard()
        .padding(.horizontal, 20)
    }

    private func menuRow(icon: AnyView, title: String, detail: String,
                         prominent: Bool = false) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(prominent ? Ink.amberGlow.opacity(0.9) : Ink.panelLight)
                icon
            }
            .frame(width: 46, height: 46)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(Quill.serifBold(16))
                    .foregroundColor(prominent ? Ink.night : Ink.parchment)
                Text(detail)
                    .font(Quill.serif(12))
                    .foregroundColor(prominent ? Ink.night.opacity(0.7) : Ink.parchmentFaint)
            }
            Spacer(minLength: 0)
            ChevronIcon(size: 12, color: prominent ? Ink.night.opacity(0.6) : Ink.parchmentFaint,
                        pointingLeft: false)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(prominent ? Ink.amber : Ink.panel)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(prominent ? Ink.amberGlow.opacity(0.7) : Ink.line, lineWidth: 1)
                )
        )
    }
}

// MARK: - Case map

struct CaseMapView: View {
    @EnvironmentObject var store: CasebookStore

    var body: some View {
        CasebookScreen(title: "The Casebook", subtitle: "Cases of the metropolis") {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach([0, 1, 2, 3], id: \.self) { act in
                        actSection(act)
                    }
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                .padding(.top, 6)
            }
        }
    }

    private func actSection(_ act: Int) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text(CaseLibrary.actTitle(act))
                    .font(Quill.serifBold(17))
                    .foregroundColor(Ink.amber)
                Text(CaseLibrary.actSubtitle(act))
                    .font(Quill.serifItalic(12))
                    .foregroundColor(Ink.parchmentFaint)
            }
            ForEach(CaseLibrary.cases.filter { $0.act == act }) { gameCase in
                caseRow(gameCase)
            }
        }
    }

    @ViewBuilder
    private func caseRow(_ gameCase: GameCase) -> some View {
        let unlocked = store.isCaseUnlocked(gameCase.id)
        if unlocked {
            NavigationLink(destination: CaseHubView(caseId: gameCase.id)) {
                caseRowBody(gameCase, unlocked: true)
            }
            .buttonStyle(PlainButtonStyle())
        } else {
            caseRowBody(gameCase, unlocked: false)
        }
    }

    private func caseRowBody(_ gameCase: GameCase, unlocked: Bool) -> some View {
        let prog = store.progress(for: gameCase.id)
        let solved = store.caseEverSolved(gameCase.id)
        return HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(solved ? Ink.verdigris.opacity(0.25) : Ink.panelLight)
                    .overlay(Circle().stroke(solved ? Ink.verdigris : Ink.line, lineWidth: 1))
                if unlocked {
                    Text(gameCase.id == 0 ? "T" : "\(gameCase.id)")
                        .font(Quill.serifBold(16))
                        .foregroundColor(solved ? Ink.verdigris : Ink.parchment)
                } else {
                    LockIcon(size: 16, color: Ink.parchmentFaint)
                }
            }
            .frame(width: 42, height: 42)
            VStack(alignment: .leading, spacing: 2) {
                Text(unlocked ? gameCase.title : "Sealed File")
                    .font(Quill.serifBold(15))
                    .foregroundColor(unlocked ? Ink.parchment : Ink.parchmentFaint)
                Text(unlocked ? gameCase.subtitle : "Close the previous case to break the seal.")
                    .font(Quill.serif(12))
                    .foregroundColor(Ink.parchmentFaint)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
            if solved, let idx = prog.bestRankIndex, let rank = CaseRank(rawValue: idx) {
                ZStack {
                    SealScallopShape()
                        .fill(Ink.bloodWax)
                        .frame(width: 34, height: 34)
                    Text(rank.letter)
                        .font(Quill.serifBold(15))
                        .foregroundColor(Ink.parchment)
                }
            } else if unlocked {
                ChevronIcon(size: 11, color: Ink.parchmentFaint, pointingLeft: false)
            }
        }
        .padding(11)
        .background(
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .fill(Ink.panel.opacity(unlocked ? 1 : 0.55))
                .overlay(
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .stroke(Ink.line.opacity(unlocked ? 1 : 0.5), lineWidth: 1)
                )
        )
    }
}

// MARK: - Tutorial

struct TutorialView: View {
    var body: some View {
        CasebookScreen(title: "How to Investigate", subtitle: "The detective's method") {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(Array(TutorialContent.steps.enumerated()), id: \.offset) { pair in
                        TutorialStepCard(index: pair.offset + 1, step: pair.element)
                    }
                    Text("Begin with the training case at the Yard. The method will carry you through every fog in London.")
                        .font(Quill.serifItalic(13))
                        .foregroundColor(Ink.parchmentDim)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 30)
                }
                .clampedContentWidth()
                .padding(.horizontal, 20)
                .padding(.top, 6)
            }
        }
    }
}

struct TutorialStep {
    let title: String
    let body: String
    let icon: Int   // 0 book, 1 person, 2 magnifier, 3 link, 4 scales, 5 quill
}

enum TutorialContent {
    static let steps: [TutorialStep] = [
        TutorialStep(title: "Read the Brief",
                     body: "Every case opens with the facts as the Yard knows them. Read the brief closely - it tells you what was done, to whom, and what is at stake.",
                     icon: 0),
        TutorialStep(title: "Interview the Suspects",
                     body: "Hear every statement from every suspect. Liars talk, and what they say is your raw material. Some statements only surface after you confront a suspect with proof.",
                     icon: 1),
        TutorialStep(title: "Examine the Locations",
                     body: "Visit each location and tap the glinting marks to recover evidence. Every piece is recorded in your journal with its meaning.",
                     icon: 2),
        TutorialStep(title: "Work the Deduction Board",
                     body: "Pair a statement against another statement or a piece of evidence. When the two cannot both be true, you expose a contradiction - and contradictions loosen tongues.",
                     icon: 3),
        TutorialStep(title: "Make the Accusation",
                     body: "When you are sure, name the culprit, the motive and the single piece of evidence that proves the case. All three must be right. Wrong accusations cost you standing with the magistrate.",
                     icon: 4),
        TutorialStep(title: "Earn Your Rank",
                     body: "Close cases without hints or false accusations to earn the S rank. Ranks raise you from Constable toward Master Detective. Three hints wait in each case if the fog grows thick.",
                     icon: 5)
    ]
}

struct TutorialStepCard: View {
    let index: Int
    let step: TutorialStep

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle().fill(Ink.panelLight)
                    .overlay(Circle().stroke(Ink.amberDim.opacity(0.6), lineWidth: 1))
                stepIcon
            }
            .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 4) {
                Text("\(index). \(step.title)")
                    .font(Quill.serifBold(15))
                    .foregroundColor(Ink.parchment)
                Text(step.body)
                    .font(Quill.serif(13))
                    .foregroundColor(Ink.parchmentDim)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .inkCard()
    }

    @ViewBuilder
    private var stepIcon: some View {
        switch step.icon {
        case 0: BookIcon(size: 22, color: Ink.amber)
        case 1: PersonIcon(size: 22, color: Ink.amber)
        case 2: MagnifierIcon(size: 22, color: Ink.amber)
        case 3: LinkIcon(size: 22, color: Ink.amber)
        case 4: ScalesIcon(size: 22, color: Ink.amber)
        default: QuillIcon(size: 22, color: Ink.amber)
        }
    }
}
