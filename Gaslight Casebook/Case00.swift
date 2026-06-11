import Foundation

/// Tutorial case — small, guided, genuinely solvable.
enum Case00 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c0_dunn", name: "Constable Dunn", role: "Duty constable",
                    bio: "A broad, earnest young officer who has held the duty desk for two years and never once lost a button, let alone a watch.",
                    portrait: PortraitSpec(skin: 0, hair: .cropped, hairColor: 1, facial: .none,
                                           hat: .policeHelmet, collar: .uniform, coat: 3)),
            Suspect(id: "c0_petty", name: "Mrs. Petty", role: "Charwoman",
                    bio: "Scrubs the Yard's floors at dawn and knows the comings and goings of every soul in the building better than the ledger does.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 3, facial: .none,
                                           hat: .none, collar: .shawl, coat: 1, feminine: true)),
            Suspect(id: "c0_snell", name: "Mr. Snell", role: "Records clerk",
                    bio: "A thin, precise man who files reports in the records cage. Lately seen at the dog races more often than at church.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 0, facial: .none,
                                           hat: .none, eyewear: .spectacles, collar: .highCollar, coat: 0))
        ]

        let statements = [
            CaseStatement("c0s01", "c0_dunn",
                          "Sergeant Bricker left his silver watch in his desk drawer at nine, same as every morning. By noon the drawer was empty."),
            CaseStatement("c0s02", "c0_dunn",
                          "Nobody came past the duty desk who didn't belong here. Only the three of us were in the building all morning."),
            CaseStatement("c0s03", "c0_dunn",
                          "I never left the front desk. The day-book shows my initials against every half hour."),
            CaseStatement("c0s04", "c0_petty",
                          "I did the floors before eight and then kept to the scullery, boiling tea towels."),
            CaseStatement("c0s05", "c0_petty",
                          "Mr. Snell came through the duty room at ten o'clock, carrying the sergeant's tea tray. I saw him plain from the corridor."),
            CaseStatement("c0s06", "c0_petty",
                          "The sergeant's drawer sticks. You must rattle it just so - everyone in the building knows the trick of it."),
            CaseStatement("c0s07", "c0_snell",
                          "I never once left the records cage all morning. The files do not sort themselves, Detective."),
            CaseStatement("c0s08", "c0_snell",
                          "A watch like that would fetch a tidy sum, I dare say. Not that I would know where one sells such things."),
            CaseStatement("c0s09", "c0_snell",
                          "Very well - I carried the sergeant his tea at ten. An act of kindness, nothing more. I touched nothing but the tray.",
                          unlock: .contradiction("c0x1")),
            CaseStatement("c0s10", "c0_snell",
                          "That ticket... my hand was forced, Detective. The dog races. I meant to buy the watch back before he ever missed it.",
                          unlock: .contradiction("c0x2"))
        ]

        let locations = [
            CaseLocation("c0_duty", "Duty Room",
                         "The sergeant's desk, the records cage, and the smell of strong tea.",
                         scene: .office)
        ]

        let evidence = [
            EvidenceItem("c0e1", "Pawnbroker's Ticket",
                         "A ticket from Croke's pawnshop, made out at twenty to eleven this morning for 'one silver hunter watch'. The customer signed only 'S'.",
                         at: "c0_duty", x: 0.30, y: 0.62),
            EvidenceItem("c0e2", "Tea Tray Rota",
                         "The pantry rota pinned by the door. Against ten o'clock, in fresh ink: 'Sgt's tray - Snell'.",
                         at: "c0_duty", x: 0.78, y: 0.34),
            EvidenceItem("c0e3", "Scratched Drawer",
                         "The sergeant's drawer bears fresh scratches around the lock - rattled open by someone who knew its trick but hurried the job.",
                         at: "c0_duty", x: 0.55, y: 0.74)
        ]

        let contradictions = [
            Contradiction("c0x1", .statement("c0s07"), .statement("c0s05"),
                          "The Clerk Who Never Left",
                          "Snell swears he never left the records cage, yet Mrs. Petty watched him carry the sergeant's tea tray through the duty room at ten."),
            Contradiction("c0x2", .statement("c0s09"), .evidence("c0e1"),
                          "Kindness With a Price",
                          "Snell admits to the tea but claims he touched nothing - yet a pawn ticket for a silver hunter watch was signed 'S' at twenty to eleven, barely half an hour later.")
        ]

        return GameCase(
            id: 0, act: 0,
            title: "The Sergeant's Watch",
            subtitle: "A training matter at the Yard",
            brief: "Sergeant Bricker's silver hunter watch has vanished from his desk drawer between nine and noon. Only three people were in the building. The sergeant wants it handled quietly - consider it your examination, Detective. Interview the suspects, examine the duty room, pair what does not agree, and name the thief.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To settle gambling debts",
                "Spite against the sergeant",
                "To pawn it for a sick relative",
                "Simple opportunity"
            ],
            solution: CaseSolution(
                culpritId: "c0_snell",
                motive: "To settle gambling debts",
                keyEvidenceId: "c0e1",
                reveal: "Snell rattled the sticking drawer open while the sergeant's tea cooled, slipped the watch into his coat, and had it at Croke's pawnshop within the half hour. The dog races had eaten his wages for months. The watch is recovered - and you have passed your examination, Detective."
            )
        )
    }
}
