import Foundation

/// Act II, Case 6 — The Understudy's Hour.
enum Case06 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c6_viola", name: "Viola Quick", role: "Understudy",
                    bio: "Knows Marie Delorme's part to the syllable - that is her employment. The gallery papers have hanged her by breakfast.",
                    portrait: PortraitSpec(skin: 0, hair: .wave, hairColor: 4, hat: .none,
                                           collar: .lace, coat: 6, feminine: true)),
            Suspect(id: "c6_loach", name: "Mr. Loach", role: "Box-office manager",
                    bio: "Nine years counting the house in a green eyeshade. Refuses holidays, balances to the penny, and went grey as ash when auditors were mentioned.",
                    portrait: PortraitSpec(skin: 0, hair: .bald, hairColor: 3, facial: .none,
                                           hat: .none, eyewear: .spectacles, collar: .highCollar, coat: 0)),
            Suspect(id: "c6_marsh", name: "Edmund Marsh", role: "Leading man",
                    bio: "The matinee idol of the Lyceum Royal - and, very quietly since Easter, Marie Delorme's betrothed.",
                    portrait: PortraitSpec(skin: 0, hair: .side, hairColor: 1, facial: .none,
                                           hat: .none, collar: .cravat, coat: 4)),
            Suspect(id: "c6_pratt", name: "Mrs. Pratt", role: "Dresser",
                    bio: "Has mixed Marie's throat tonic at the interval bell for two hundred nights: honey, lemon, glycerine, and a careful taste.",
                    portrait: PortraitSpec(skin: 1, hair: .bun, hairColor: 3, hat: .none,
                                           collar: .apron, coat: 1, feminine: true)),
            Suspect(id: "c6_fane", name: "Sir Digby Fane", role: "Theatre owner",
                    bio: "Impresario of the Lyceum Royal, architect of the Imperial transfer, and host to the Mayor's party on the fatal night.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 3, facial: .moustache,
                                           hat: .topHat, eyewear: .monocle, collar: .cravat, coat: 3)),
            Suspect(id: "c6_carlo", name: "Carlo Beddoes", role: "Stage-door keeper",
                    bio: "Guards the stage door with a visitor book that takes every name, and a stool with a view of the prompt corner.",
                    portrait: PortraitSpec(skin: 2, hair: .curly, hairColor: 0, facial: .fullBeard,
                                           hat: .flatCap, collar: .uniform, coat: 2))
        ]

        let statements = [
            // Viola
            CaseStatement("c6s01", "c6_viola",
                          "Yes, I know her part to the syllable. That is my employment, Detective - to know it, and to pray nightly I am never needed."),
            CaseStatement("c6s02", "c6_viola",
                          "I stood in the wings through the whole of Act Two, prompt side, where the entire crew could see me."),
            CaseStatement("c6s03", "c6_viola",
                          "Marie has been kind to me - kinder than this profession ever is. Whoever did this took aim at her and shot my name in the bargain."),
            CaseStatement("c6s04", "c6_viola",
                          "An understudy who poisons her principal plays the part once and hangs for it. Even ambition can do arithmetic."),
            CaseStatement("c6s28", "c6_viola",
                          "You want what I saw? Mr. Loach's green eyeshade in the corridor mirror, during the duel. From prompt side the mirror shows the dressing-room door. I thought nothing of it - the man counts everything, even costumes."),

            // Loach
            CaseStatement("c6s05", "c6_loach",
                          "A tragedy - and a catastrophe. The house dark, refunds, the transfer imperilled... forgive me if I think in figures. Figures are my post."),
            CaseStatement("c6s06", "c6_loach",
                          "I never leave the box office between the interval bells. The window must be manned; that is iron law in this house."),
            CaseStatement("c6s07", "c6_loach",
                          "The houses have been thin, Detective - my returns book will show you. Sir Digby's transfer was always built on hope rather than receipts."),
            CaseStatement("c6s08", "c6_loach",
                          "Laudanum? I keep the medical box stocked - bandages, sal volatile. Never laudanum. The license forbids opiates backstage."),
            CaseStatement("c6s09", "c6_loach",
                          "That counterfoil - yes. I signed for laudanum. For my own sleeplessness, if you must strip a man bare. Writing 'medical box' spared me the chemist's knowing look.",
                          unlock: .contradiction("c6x3")),
            CaseStatement("c6s10", "c6_loach",
                          "Audit, transfer, exposure - you arrange words like scenery, Detective. Prove that a single grain passed from my hand to her glass.",
                          unlock: .contradiction("c6x6")),

            // Marsh
            CaseStatement("c6s11", "c6_marsh",
                          "Marie and I are engaged - quietly, since Easter. Whoever touched that glass struck at my whole life, not only hers."),
            CaseStatement("c6s12", "c6_marsh",
                          "I was on stage from the interval to her collapse - in the duel, before eight hundred witnesses. My alibi was applauded twice."),
            CaseStatement("c6s13", "c6_marsh",
                          "During the duel, Loach passed along the dressing-room corridor. I marked it from the stage - one marks a green eyeshade where no eyeshade belongs."),
            CaseStatement("c6s14", "c6_marsh",
                          "Viola wept in the wings when Marie fell. Real weeping ruins the face, Detective. Actresses know the difference, and so do I."),

            // Mrs. Pratt
            CaseStatement("c6s15", "c6_pratt",
                          "I mixed the tonic at the interval bell as I have two hundred nights: honey, lemon, glycerine. And I tasted it - habit of a careful dresser. It was clean when I set it down."),
            CaseStatement("c6s16", "c6_pratt",
                          "I left the room not three minutes, to fetch her shawl from the hamper. The corridor was empty going. Coming back, I heard the door click before I turned the corner."),
            CaseStatement("c6s17", "c6_pratt",
                          "The medical box lives on my shelf and I keep its card true: no opiates, never. And the lock has not been touched - examine it."),
            CaseStatement("c6s18", "c6_pratt",
                          "Sir Digby came down before curtain, all smiles about the Imperial. Mr. Loach went grey as ash when the word 'auditors' was said. I took it for the cold."),
            CaseStatement("c6s27", "c6_pratt",
                          "One thing more. The glass smelled of honey when I set it down. When I gathered it after, there was a bitterness under the sweet - and a wet ring on the table an inch from where I had placed it."),

            // Sir Digby
            CaseStatement("c6s19", "c6_fane",
                          "The Imperial transfer is signed: they verify our receipts within the fortnight and pay against them. Tonight's catastrophe delays the count - indefinitely, I fear."),
            CaseStatement("c6s20", "c6_fane",
                          "Loach has kept my box office nine years. Honest the way clocks are honest, I'd have said. Though lately he refuses a holiday - refuses outright. Odd, in a man so tired."),
            CaseStatement("c6s21", "c6_fane",
                          "I sat in my box with the Mayor's party the entire act. Sixty people watched me watch the play."),
            CaseStatement("c6s22", "c6_fane",
                          "Consider: if the run dies tonight, the receipts die with it - sealed, refunded, beyond any auditor's adding. You might almost call the timing bookish."),

            // Carlo
            CaseStatement("c6s23", "c6_carlo",
                          "Nobody passed my door after the interval but the theatre cat. My book takes every name that crosses the sill - look for yourself."),
            CaseStatement("c6s24", "c6_carlo",
                          "Two days back, a chemist's boy brought a packet for Mr. Loach - Allen and Drew's, signed into my delivery ledger. Mr. Loach took it himself at the door, quick-like."),
            CaseStatement("c6s25", "c6_carlo",
                          "Miss Viola stood prompt side all the act. I see the prompt corner from my stool when the door's hooked open, and she never stirred from it."),
            CaseStatement("c6s26", "c6_carlo",
                          "Mind you - Mr. Loach knows the pass-door from front of house, behind the boxes. Box-office men use it to dodge the rain. It misses my book entirely.")
        ]

        let locations = [
            CaseLocation("c6_stage", "Stage and Wings",
                         "The boards of the Lyceum Royal, the prompt corner, and the props hamper in the shadows.",
                         scene: .theatre),
            CaseLocation("c6_dressing", "Marie's Dressing Room",
                         "Mirror, shawls, telegrams of admiration - and the tonic glass on its small table.",
                         scene: .parlour),
            CaseLocation("c6_boxoffice", "The Box Office",
                         "Loach's cage of brass and ledger paper, where every seat in the house becomes a figure.",
                         scene: .office),
            CaseLocation("c6_stagedoor", "The Stage Door",
                         "Carlo's stool, his visitor book, and the alley where chemist's boys make deliveries.",
                         scene: .alley)
        ]

        let evidence = [
            EvidenceItem("c6e1", "The Tonic Glass",
                         "Marie's glass, half drunk. Beneath the honey and lemon, the unmistakable bitter spirit of laudanum - a heavy dose, meant to drop her where she stood.",
                         at: "c6_dressing", x: 0.60, y: 0.55),
            EvidenceItem("c6e8", "Marie's Letters",
                         "A ribbon-tied bundle: Marsh's letters, and a note in Marie's hand - 'After the transfer we shall tell Sir Digby everything. V. must have my part when we go; she has earned it.' The understudy was to inherit the role with Marie's blessing.",
                         at: "c6_dressing", x: 0.25, y: 0.70),
            EvidenceItem("c6e10", "The Medical Box",
                         "Mrs. Pratt's medical box: bandages, sal volatile, the inventory card true to the item. No laudanum has ever been entered - and the lock is unmarked.",
                         at: "c6_dressing", x: 0.80, y: 0.35),
            EvidenceItem("c6e2", "Scratched Vial",
                         "Pushed deep into the props hamper, steps from the dressing-room door: a chemist's vial, label scratched away but for 'ALLEN & DR-'. Empty.",
                         at: "c6_stage", x: 0.30, y: 0.68),
            EvidenceItem("c6e9", "Viola's Sides",
                         "Viola's script of Marie's role, annotated in pencil to the last breath-mark. On the flyleaf, in Marie's hand: 'To my Viola - study it well; it will be yours sooner than you think. M.D.'",
                         at: "c6_stage", x: 0.70, y: 0.45),
            EvidenceItem("c6e3", "The Returns Book",
                         "Loach's nightly returns, neat as scripture: 'House thin. House very thin. Papered freely.' Six weeks of failure, in his own unhurried hand.",
                         at: "c6_boxoffice", x: 0.35, y: 0.50),
            EvidenceItem("c6e4", "The Stub Sack",
                         "A sack of torn ticket stubs from the past six weeks, kept for the fire. Counted, they fill the pit and circle twice over - the 'thin houses' were full ones, and the difference went somewhere.",
                         at: "c6_boxoffice", x: 0.68, y: 0.68),
            EvidenceItem("c6e5", "The Transfer Contract",
                         "Sir Digby's agreement with the Imperial: payment against receipts, 'to be verified by the Imperial's auditors within the fortnight'. The fortnight ends Tuesday.",
                         at: "c6_boxoffice", x: 0.55, y: 0.30),
            EvidenceItem("c6e6", "The Visitor Book",
                         "Carlo's book for the night: company, crew, one telegram boy before curtain. After the interval - no one. Whoever reached the dressing room never passed the stage door.",
                         at: "c6_stagedoor", x: 0.30, y: 0.55),
            EvidenceItem("c6e7", "The Chemist's Counterfoil",
                         "Allen and Drew's delivery counterfoil, two days old: 'Laudanum, two drachms - for the theatre medical box - received, J. Loach.'",
                         at: "c6_stagedoor", x: 0.70, y: 0.70)
        ]

        let contradictions = [
            Contradiction("c6x1", .statement("c6s06"), .statement("c6s13"),
                          "The Eyeshade in the Corridor",
                          "Iron law keeps Loach at his window between the bells - yet Marsh, mid-duel, marked that green eyeshade passing along the dressing-room corridor where no eyeshade belongs."),
            Contradiction("c6x2", .statement("c6s07"), .evidence("c6e4"),
                          "A Thin House, Twice Filled",
                          "Loach pleads thin houses - while his own sack of torn stubs fills the pit and circle twice over. Full houses were sold; thin houses were reported; the difference wore a green eyeshade."),
            Contradiction("c6x3", .statement("c6s08"), .evidence("c6e7"),
                          "The Chemist's Counterfoil",
                          "Never laudanum, says Loach, the license forbids it - and Allen and Drew's counterfoil records two drachms of it, signed for by J. Loach, two days before the poisoning."),
            Contradiction("c6x4", .statement("c6s09"), .evidence("c6e2"),
                          "Sleeplessness in the Props Hamper",
                          "Laudanum for his own sleepless nights, he says - yet the emptied vial was not at his lodgings but scratched bare and buried in the props hamper, steps from Marie's door."),
            Contradiction("c6x5", .statement("c6s06"), .statement("c6s28"),
                          "The Corridor Mirror",
                          "A second pair of eyes: from prompt side, Viola saw the eyeshade in the corridor mirror during the duel. Two witnesses now place Loach where his iron law says he never goes."),
            Contradiction("c6x6", .evidence("c6e3"), .evidence("c6e4"),
                          "Returns Against Stubs",
                          "The returns book and the stub sack tell two different stories about the same six weeks. One of them is a forgery, and the stubs do not know how to lie."),
            Contradiction("c6x7", .evidence("c6e7"), .evidence("c6e10"),
                          "A Purchase That Never Arrived",
                          "Laudanum bought 'for the medical box' - a box whose card has never listed an opiate and whose lock is unmarked. The purchase was true; its stated purpose never was."),
            Contradiction("c6x8", .statement("c6s15"), .evidence("c6e1"),
                          "Three Minutes",
                          "The tonic was clean when Mrs. Pratt tasted and set it down; it was heavy with laudanum when Marie drank. Everything turns on three minutes and a door that clicked.")
        ]

        return GameCase(
            id: 6, act: 2,
            title: "The Understudy's Hour",
            subtitle: "Poison at the Lyceum Royal",
            brief: "Marie Delorme, the most loved voice on the London stage, collapsed in the third act with laudanum in her throat tonic. She lives - barely - and the morning papers have already convicted her understudy. But the tonic was clean at the interval bell, the stage door admitted no one, and the box office balances a little too perfectly. Sir Digby wants the truth before the Imperial's auditors arrive on Tuesday.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To stop the audit of the receipts",
                "Jealous love of the actress",
                "To give the understudy her hour",
                "Revenge for a stage slight",
                "To collect insurance on the run"
            ],
            solution: CaseSolution(
                culpritId: "c6_loach",
                motive: "To stop the audit of the receipts",
                keyEvidenceId: "c6e7",
                reveal: "For six weeks Loach sold full houses and returned thin ones, pocketing the difference - until the Imperial transfer promised auditors who would count his stubs against his scripture. A dark theatre seals its books forever. So he bought laudanum on the theatre's name, slipped through the pass-door during the duel while two pairs of eyes marked his eyeshade, and poured Marie's closing notice into her honey. She will sing again in the spring. Loach will be counting laundry tallies in Pentonville."
            )
        )
    }
}
