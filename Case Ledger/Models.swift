import Foundation

// MARK: - Clue references

enum ClueRef: Hashable, Codable {
    case statement(String)
    case evidence(String)

    var key: String {
        switch self {
        case .statement(let id): return "s:" + id
        case .evidence(let id): return "e:" + id
        }
    }
}

// MARK: - Portrait specification (rendered by PortraitView)

enum HairKind: Int { case bald, cropped, side, curly, bun, long, wave, slick }
enum FacialHairKind: Int { case none, moustache, fullBeard, sideburns, goatee, walrus }
enum HatKind: Int { case none, topHat, bowler, flatCap, bonnet, policeHelmet, wideBrim, nurseCap }
enum EyewearKind: Int { case none, monocle, spectacles, pinceNez }
enum CollarKind: Int { case highCollar, cravat, shawl, uniform, apron, clerical, lace }

struct PortraitSpec {
    var skin: Int          // 0...3
    var hair: HairKind
    var hairColor: Int     // 0...4
    var facial: FacialHairKind
    var hat: HatKind
    var eyewear: EyewearKind
    var collar: CollarKind
    var coat: Int          // 0...7
    var feminine: Bool

    init(skin: Int = 0, hair: HairKind = .side, hairColor: Int = 0,
         facial: FacialHairKind = .none, hat: HatKind = .none,
         eyewear: EyewearKind = .none, collar: CollarKind = .highCollar,
         coat: Int = 0, feminine: Bool = false) {
        self.skin = skin
        self.hair = hair
        self.hairColor = hairColor
        self.facial = facial
        self.hat = hat
        self.eyewear = eyewear
        self.collar = collar
        self.coat = coat
        self.feminine = feminine
    }
}

// MARK: - Case content

struct Suspect: Identifiable {
    let id: String
    let name: String
    let role: String
    let bio: String
    let portrait: PortraitSpec
}

enum StatementUnlock: Hashable {
    case initial
    case evidence(String)        // unlocked once this evidence id is found
    case contradiction(String)   // unlocked once this contradiction id is exposed
}

struct CaseStatement: Identifiable {
    let id: String
    let suspectId: String
    let text: String
    let unlock: StatementUnlock

    init(_ id: String, _ suspectId: String, _ text: String, unlock: StatementUnlock = .initial) {
        self.id = id
        self.suspectId = suspectId
        self.text = text
        self.unlock = unlock
    }
}

struct EvidenceItem: Identifiable {
    let id: String
    let name: String
    let desc: String
    let locationId: String
    let spotX: Double      // 0...1 relative position inside the scene
    let spotY: Double

    init(_ id: String, _ name: String, _ desc: String,
         at locationId: String, x: Double, y: Double) {
        self.id = id
        self.name = name
        self.desc = desc
        self.locationId = locationId
        self.spotX = x
        self.spotY = y
    }
}

enum SceneKind: Int {
    case study, parlour, alley, dock, shopFloor, market, garden, workshop,
         cellar, theatre, office, bankVault, churchyard, warehouse,
         printworks, boardroom, bridge, trainYard, hospitalWard, gasworks,
         kitchen, attic
}

struct CaseLocation: Identifiable {
    let id: String
    let name: String
    let desc: String
    let scene: SceneKind

    init(_ id: String, _ name: String, _ desc: String, scene: SceneKind) {
        self.id = id
        self.name = name
        self.desc = desc
        self.scene = scene
    }
}

struct Contradiction: Identifiable {
    let id: String
    let a: ClueRef
    let b: ClueRef
    let title: String
    let explanation: String

    init(_ id: String, _ a: ClueRef, _ b: ClueRef, _ title: String, _ explanation: String) {
        self.id = id
        self.a = a
        self.b = b
        self.title = title
        self.explanation = explanation
    }

    func matches(_ x: ClueRef, _ y: ClueRef) -> Bool {
        (a == x && b == y) || (a == y && b == x)
    }
}

struct CaseSolution {
    let culpritId: String
    let motive: String          // must equal one entry of motiveOptions
    let keyEvidenceId: String
    let reveal: String          // verdict narrative shown on success
}

struct GameCase: Identifiable {
    let id: Int                 // 0 = tutorial, 1...12
    let act: Int                // 0 tutorial, 1, 2, 3
    let title: String
    let subtitle: String
    let brief: String
    let suspects: [Suspect]
    let statements: [CaseStatement]
    let evidence: [EvidenceItem]
    let locations: [CaseLocation]
    let contradictions: [Contradiction]
    let motiveOptions: [String]
    let solution: CaseSolution

    func suspect(_ id: String) -> Suspect? { suspects.first { $0.id == id } }
    func statement(_ id: String) -> CaseStatement? { statements.first { $0.id == id } }
    func evidenceItem(_ id: String) -> EvidenceItem? { evidence.first { $0.id == id } }
    func location(_ id: String) -> CaseLocation? { locations.first { $0.id == id } }

    func clueTitle(_ ref: ClueRef) -> String {
        switch ref {
        case .statement(let sid):
            if let st = statement(sid), let sp = suspect(st.suspectId) {
                return sp.name
            }
            return "Statement"
        case .evidence(let eid):
            return evidenceItem(eid)?.name ?? "Evidence"
        }
    }

    func clueBody(_ ref: ClueRef) -> String {
        switch ref {
        case .statement(let sid): return statement(sid)?.text ?? ""
        case .evidence(let eid): return evidenceItem(eid)?.desc ?? ""
        }
    }
}

// MARK: - Player progress (persisted)

struct CaseProgressState: Codable {
    var foundEvidence: Set<String> = []
    var readStatements: Set<String> = []
    var foundContradictions: Set<String> = []
    var hintsUsed: Int = 0
    var wrongAccusations: Int = 0
    var solved: Bool = false
    var bestRankIndex: Int? = nil     // 0 = S, 1 = A, 2 = B, 3 = C
    var openedBrief: Bool = false
}

struct PlayerState: Codable {
    var progress: [Int: CaseProgressState] = [:]
    var unlockedAchievements: Set<String> = []
    var soundOn: Bool = true
    var hapticsOn: Bool = true
    var textSizeIndex: Int = 1        // 0 small, 1 medium, 2 large
    var onboardingDone: Bool = false
    var lifetimeContradictions: Int = 0
    var lifetimeStatementsRead: Int = 0
    var lifetimeEvidenceFound: Int = 0
    var lifetimeWrongAccusations: Int = 0
    var lifetimeHintsUsed: Int = 0
    var casesReplayed: Int = 0
}

// MARK: - Ranks

enum CaseRank: Int, CaseIterable {
    case s = 0, a = 1, b = 2, c = 3

    var letter: String {
        switch self {
        case .s: return "S"
        case .a: return "A"
        case .b: return "B"
        case .c: return "C"
        }
    }

    var points: Int {
        switch self {
        case .s: return 4
        case .a: return 3
        case .b: return 2
        case .c: return 1
        }
    }

    static func compute(wrongAccusations: Int, hintsUsed: Int) -> CaseRank {
        let score = wrongAccusations * 2 + hintsUsed
        switch score {
        case 0: return .s
        case 1...2: return .a
        case 3...4: return .b
        default: return .c
        }
    }
}

enum DetectiveRank: Int, CaseIterable {
    case constable = 0, inspector, chiefInspector, masterDetective

    var title: String {
        switch self {
        case .constable: return "Constable"
        case .inspector: return "Inspector"
        case .chiefInspector: return "Chief Inspector"
        case .masterDetective: return "Master Detective"
        }
    }

    var threshold: Int {
        switch self {
        case .constable: return 0
        case .inspector: return 12
        case .chiefInspector: return 28
        case .masterDetective: return 44
        }
    }

    static func forPoints(_ points: Int) -> DetectiveRank {
        var result: DetectiveRank = .constable
        for rank in DetectiveRank.allCases where points >= rank.threshold {
            result = rank
        }
        return result
    }
}
