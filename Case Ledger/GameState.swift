import SwiftUI
import AudioToolbox

// MARK: - Achievements catalog

struct AchievementDef: Identifiable {
    let id: String
    let title: String
    let detail: String
}

enum AchievementCatalog {
    static let all: [AchievementDef] = [
        AchievementDef(id: "glc.ach.firstSteps", title: "First Steps in the Fog",
                       detail: "Close the training case at the Yard."),
        AchievementDef(id: "glc.ach.firstArrest", title: "First Arrest",
                       detail: "Solve your first commissioned case."),
        AchievementDef(id: "glc.ach.act1", title: "Streets Made Safer",
                       detail: "Close every case in Act I."),
        AchievementDef(id: "glc.ach.act2", title: "Dark Waters Charted",
                       detail: "Close every case in Act II."),
        AchievementDef(id: "glc.ach.act3", title: "The Lamps Go Quiet",
                       detail: "Close every case in Act III."),
        AchievementDef(id: "glc.ach.firstThread", title: "Loose Thread",
                       detail: "Expose your first contradiction."),
        AchievementDef(id: "glc.ach.fiftyThreads", title: "Web of Lies",
                       detail: "Expose 50 contradictions in total."),
        AchievementDef(id: "glc.ach.reader", title: "Patient Listener",
                       detail: "Hear 150 statements from suspects."),
        AchievementDef(id: "glc.ach.evidenceHound", title: "Evidence Hound",
                       detail: "Recover every piece of evidence in a single case."),
        AchievementDef(id: "glc.ach.noHints", title: "Unaided Mind",
                       detail: "Solve a case without using a single hint."),
        AchievementDef(id: "glc.ach.flawless", title: "Flawless Verdict",
                       detail: "Earn an S rank on any case."),
        AchievementDef(id: "glc.ach.fourS", title: "A Reputation Forms",
                       detail: "Hold S ranks on four cases at once."),
        AchievementDef(id: "glc.ach.perfectDozen", title: "The Perfect Dozen",
                       detail: "Hold S ranks on all twelve cases."),
        AchievementDef(id: "glc.ach.hasty", title: "Hasty Conclusion",
                       detail: "Have an accusation dismissed by the magistrate."),
        AchievementDef(id: "glc.ach.secondLook", title: "A Second Look",
                       detail: "Reopen a solved case from the archive."),
        AchievementDef(id: "glc.ach.inspector", title: "Promoted: Inspector",
                       detail: "Reach the rank of Inspector."),
        AchievementDef(id: "glc.ach.chief", title: "Promoted: Chief Inspector",
                       detail: "Reach the rank of Chief Inspector."),
        AchievementDef(id: "glc.ach.master", title: "Master Detective",
                       detail: "Reach the highest rank of the craft.")
    ]
}

// MARK: - Store

final class CasebookStore: ObservableObject {
    static let storageKey = "glc.state"

    @Published var state: PlayerState {
        didSet { persist() }
    }

    /// Achievement ids unlocked since last drain — used for toasts.
    @Published var freshAchievements: [String] = []

    init() {
        if let data = UserDefaults.standard.data(forKey: Self.storageKey),
           let decoded = try? JSONDecoder().decode(PlayerState.self, from: data) {
            state = decoded
        } else {
            state = PlayerState()
        }
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(data, forKey: Self.storageKey)
        }
    }

    // MARK: Settings

    var textScale: CGFloat {
        switch state.textSizeIndex {
        case 0: return 0.9
        case 2: return 1.14
        default: return 1.0
        }
    }

    func scaled(_ base: CGFloat) -> CGFloat { base * textScale }

    // MARK: Feedback

    func tapFeedback() {
        if state.soundOn { AudioServicesPlaySystemSound(1104) }
        if state.hapticsOn {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }

    func revealFeedback() {
        if state.soundOn { AudioServicesPlaySystemSound(1057) }
        if state.hapticsOn {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }

    func failFeedback() {
        if state.soundOn { AudioServicesPlaySystemSound(1053) }
        if state.hapticsOn {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }

    // MARK: Progress accessors

    func progress(for caseId: Int) -> CaseProgressState {
        state.progress[caseId] ?? CaseProgressState()
    }

    private func mutateProgress(_ caseId: Int, _ change: (inout CaseProgressState) -> Void) {
        var p = state.progress[caseId] ?? CaseProgressState()
        change(&p)
        state.progress[caseId] = p
    }

    func isCaseUnlocked(_ caseId: Int) -> Bool {
        if caseId <= 1 { return true }          // tutorial + first case always open
        return caseEverSolved(caseId - 1)
    }

    var solvedCaseCount: Int {
        CaseLibrary.cases.filter { $0.id >= 1 && caseEverSolved($0.id) }.count
    }

    func actSolved(_ act: Int) -> Bool {
        let ids = CaseLibrary.cases.filter { $0.act == act }.map { $0.id }
        return !ids.isEmpty && ids.allSatisfy { caseEverSolved($0) }
    }

    var detectivePoints: Int {
        CaseLibrary.cases.filter { $0.id >= 1 }.reduce(0) { total, gameCase in
            guard let idx = progress(for: gameCase.id).bestRankIndex,
                  let rank = CaseRank(rawValue: idx) else { return total }
            return total + rank.points
        }
    }

    var detectiveRank: DetectiveRank { DetectiveRank.forPoints(detectivePoints) }

    var sRankCount: Int {
        CaseLibrary.cases.filter { $0.id >= 1 && progress(for: $0.id).bestRankIndex == 0 }.count
    }

    // MARK: Statement visibility

    func isStatementVisible(_ st: CaseStatement, progress p: CaseProgressState) -> Bool {
        switch st.unlock {
        case .initial: return true
        case .evidence(let eid): return p.foundEvidence.contains(eid)
        case .contradiction(let cid): return p.foundContradictions.contains(cid)
        }
    }

    func visibleStatements(of gameCase: GameCase, for suspectId: String) -> [CaseStatement] {
        let p = progress(for: gameCase.id)
        return gameCase.statements.filter { $0.suspectId == suspectId && isStatementVisible($0, progress: p) }
    }

    func hiddenStatementCount(of gameCase: GameCase, for suspectId: String) -> Int {
        let p = progress(for: gameCase.id)
        return gameCase.statements.filter { $0.suspectId == suspectId && !isStatementVisible($0, progress: p) }.count
    }

    /// All clue refs currently usable on the deduction board.
    func availableClues(of gameCase: GameCase) -> [ClueRef] {
        let p = progress(for: gameCase.id)
        var refs: [ClueRef] = []
        for st in gameCase.statements where isStatementVisible(st, progress: p) {
            refs.append(.statement(st.id))
        }
        for ev in gameCase.evidence where p.foundEvidence.contains(ev.id) {
            refs.append(.evidence(ev.id))
        }
        return refs
    }

    func isClueAvailable(_ ref: ClueRef, in gameCase: GameCase) -> Bool {
        let p = progress(for: gameCase.id)
        switch ref {
        case .statement(let sid):
            guard let st = gameCase.statement(sid) else { return false }
            return isStatementVisible(st, progress: p)
        case .evidence(let eid):
            return p.foundEvidence.contains(eid)
        }
    }

    // MARK: Mutations

    func markBriefOpened(_ caseId: Int) {
        guard !progress(for: caseId).openedBrief else { return }
        mutateProgress(caseId) { $0.openedBrief = true }
    }

    func discoverEvidence(_ evidenceId: String, in gameCase: GameCase) {
        guard !progress(for: gameCase.id).foundEvidence.contains(evidenceId) else { return }
        mutateProgress(gameCase.id) { $0.foundEvidence.insert(evidenceId) }
        state.lifetimeEvidenceFound += 1
        revealFeedback()
        if progress(for: gameCase.id).foundEvidence.count == gameCase.evidence.count {
            unlock("glc.ach.evidenceHound")
        }
    }

    func markStatementsRead(_ ids: [String], caseId: Int) {
        let p = progress(for: caseId)
        let newOnes = ids.filter { !p.readStatements.contains($0) }
        guard !newOnes.isEmpty else { return }
        mutateProgress(caseId) { prog in
            for id in newOnes { prog.readStatements.insert(id) }
        }
        state.lifetimeStatementsRead += newOnes.count
        if state.lifetimeStatementsRead >= 150 { unlock("glc.ach.reader") }
    }

    /// Attempts to pair two clues. Returns the matched contradiction, if any.
    func tryPair(_ a: ClueRef, _ b: ClueRef, in gameCase: GameCase) -> Contradiction? {
        guard let match = gameCase.contradictions.first(where: { $0.matches(a, b) }) else {
            failFeedback()
            return nil
        }
        if !progress(for: gameCase.id).foundContradictions.contains(match.id) {
            mutateProgress(gameCase.id) { $0.foundContradictions.insert(match.id) }
            state.lifetimeContradictions += 1
            unlock("glc.ach.firstThread")
            if state.lifetimeContradictions >= 50 { unlock("glc.ach.fiftyThreads") }
        }
        revealFeedback()
        return match
    }

    /// Picks a hintable contradiction: one not yet found whose both halves are available.
    func hintCandidate(in gameCase: GameCase) -> Contradiction? {
        let p = progress(for: gameCase.id)
        return gameCase.contradictions.first { c in
            !p.foundContradictions.contains(c.id)
                && isClueAvailable(c.a, in: gameCase)
                && isClueAvailable(c.b, in: gameCase)
        }
    }

    func consumeHint(_ caseId: Int) {
        mutateProgress(caseId) { $0.hintsUsed += 1 }
        state.lifetimeHintsUsed += 1
    }

    func hintsLeft(_ caseId: Int) -> Int {
        max(0, 3 - progress(for: caseId).hintsUsed)
    }

    /// Returns the earned rank when the accusation is correct, nil otherwise.
    func makeAccusation(caseId: Int, culpritId: String, motive: String,
                        evidenceId: String) -> CaseRank? {
        guard let gameCase = CaseLibrary.find(caseId) else { return nil }
        let s = gameCase.solution
        let correct = s.culpritId == culpritId && s.motive == motive && s.keyEvidenceId == evidenceId
        if correct {
            let p = progress(for: caseId)
            let rank = CaseRank.compute(wrongAccusations: p.wrongAccusations, hintsUsed: p.hintsUsed)
            mutateProgress(caseId) { prog in
                prog.solved = true
                if let existing = prog.bestRankIndex {
                    prog.bestRankIndex = min(existing, rank.rawValue)
                } else {
                    prog.bestRankIndex = rank.rawValue
                }
            }
            handleSolveAchievements(caseId: caseId, rank: rank, hintsUsed: p.hintsUsed)
            revealFeedback()
            return rank
        } else {
            mutateProgress(caseId) { $0.wrongAccusations += 1 }
            state.lifetimeWrongAccusations += 1
            unlock("glc.ach.hasty")
            failFeedback()
            return nil
        }
    }

    private func handleSolveAchievements(caseId: Int, rank: CaseRank, hintsUsed: Int) {
        if caseId == 0 { unlock("glc.ach.firstSteps") }
        if caseId >= 1 { unlock("glc.ach.firstArrest") }
        if actSolved(1) { unlock("glc.ach.act1") }
        if actSolved(2) { unlock("glc.ach.act2") }
        if actSolved(3) { unlock("glc.ach.act3") }
        if hintsUsed == 0 && caseId >= 1 { unlock("glc.ach.noHints") }
        if rank == .s && caseId >= 1 { unlock("glc.ach.flawless") }
        if sRankCount >= 4 { unlock("glc.ach.fourS") }
        if sRankCount >= 12 { unlock("glc.ach.perfectDozen") }
        let dRank = detectiveRank
        if dRank.rawValue >= DetectiveRank.inspector.rawValue { unlock("glc.ach.inspector") }
        if dRank.rawValue >= DetectiveRank.chiefInspector.rawValue { unlock("glc.ach.chief") }
        if dRank == .masterDetective { unlock("glc.ach.master") }
    }

    /// Reopen a solved case: wipes its working progress but keeps the best rank.
    func replayCase(_ caseId: Int) {
        let best = progress(for: caseId).bestRankIndex
        let wasSolved = progress(for: caseId).solved
        var fresh = CaseProgressState()
        fresh.bestRankIndex = best
        state.progress[caseId] = fresh
        if wasSolved {
            state.casesReplayed += 1
            unlock("glc.ach.secondLook")
        }
    }

    /// A solved case re-opened for replay is still considered "solved" for unlock
    /// chains via bestRankIndex.
    func caseEverSolved(_ caseId: Int) -> Bool {
        progress(for: caseId).solved || progress(for: caseId).bestRankIndex != nil
    }

    func resetAllProgress() {
        let sound = state.soundOn
        let haptics = state.hapticsOn
        let textSize = state.textSizeIndex
        state = PlayerState(soundOn: sound, hapticsOn: haptics, textSizeIndex: textSize)
    }

    // MARK: Achievements

    func unlock(_ id: String) {
        guard !state.unlockedAchievements.contains(id) else { return }
        state.unlockedAchievements.insert(id)
        freshAchievements.append(id)
    }

    func drainFreshAchievement() -> String? {
        guard !freshAchievements.isEmpty else { return nil }
        return freshAchievements.removeFirst()
    }
}

extension PlayerState {
    init(soundOn: Bool, hapticsOn: Bool, textSizeIndex: Int) {
        self.init()
        self.soundOn = soundOn
        self.hapticsOn = hapticsOn
        self.textSizeIndex = textSizeIndex
    }
}
