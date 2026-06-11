import Foundation

/// Act III, Case 10 — The Widows' Fund.
enum Case10 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c10_lydgate", name: "Mr. Cecil Lydgate", role: "Bank under-manager",
                    bio: "Second man at Coutts and Maule's Lambeth branch. Holds one of the two vault keys and the complete confidence of his directors - for the present.",
                    portrait: PortraitSpec(skin: 0, hair: .side, hairColor: 0, facial: .none,
                                           hat: .none, eyewear: .spectacles, collar: .highCollar, coat: 3)),
            Suspect(id: "c10_maule", name: "Mr. Augustus Maule", role: "Bank director",
                    bio: "Third generation of Maules behind the brass plate. Regards the vault as the family chapel and the audit as communion.",
                    portrait: PortraitSpec(skin: 0, hair: .bald, hairColor: 3, facial: .fullBeard,
                                           hat: .topHat, collar: .cravat, coat: 4)),
            Suspect(id: "c10_tarn", name: "Mr. Jonas Tarn", role: "Night porter",
                    bio: "Keeps the bank's night door. Formerly a yard ganger at the railway; hands like coal shovels and a memory that improves with silver.",
                    portrait: PortraitSpec(skin: 1, hair: .cropped, hairColor: 0, facial: .sideburns,
                                           hat: .flatCap, collar: .uniform, coat: 1)),
            Suspect(id: "c10_dimity", name: "Miss Honor Dimity", role: "League bookkeeper",
                    bio: "Still keeping the Lamplighters' rolls, and still asking the questions her superiors decline to hear. The Widows' Fund passbook is hers to the farthing.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 1, facial: .none,
                                           hat: .none, eyewear: .pinceNez, collar: .lace, coat: 6, feminine: true)),
            Suspect(id: "c10_quill", name: "Mr. Erasmus Quill", role: "The patron's secretary",
                    bio: "Mr. Vane's right hand, lately much at the bank on League business. His half-smile has grown thinner since Southwark.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 0, facial: .goatee,
                                           hat: .bowler, collar: .cravat, coat: 6)),
            Suspect(id: "c10_vane", name: "Mr. Septimus Vane", role: "Patron of the League",
                    bio: "Trustee of the Widows' Fund and the public face of its grief. Has offered a reward of one hundred pounds for the robbers - from his own purse, the papers note.",
                    portrait: PortraitSpec(skin: 0, hair: .wave, hairColor: 3, facial: .none,
                                           hat: .topHat, eyewear: .monocle, collar: .cravat, coat: 4))
        ]

        let statements = [
            // Mr. Lydgate
            CaseStatement("c10s01", "c10_lydgate",
                          "The vault was sound at the eight o'clock locking, Detective - I turned my own key with Mr. Maule beside me, as the rule requires."),
            CaseStatement("c10s02", "c10_lydgate",
                          "Both keys are needed to pass the grille. Mine never leaves my watch chain; Mr. Maule's never leaves his person. The thing is impossible, which is why it is being called a marvel."),
            CaseStatement("c10s03", "c10_lydgate",
                          "I dined at my club and was home in Camberwell by eleven. My landlady bolts the door herself at half past; ask her whether the bolt was disturbed."),
            CaseStatement("c10s04", "c10_lydgate",
                          "The Widows' Fund boxes held four thousand in sovereigns at the June counting. I counted them myself. Every box full, every seal whole."),
            CaseStatement("c10s05", "c10_lydgate",
                          "I cannot explain the bridge, Detective. I walk where I please of an evening. Walking is not yet embezzlement.",
                          unlock: .contradiction("c10x3")),
            CaseStatement("c10s06", "c10_lydgate",
                          "Enough. The boxes were light long before any robbery - I knew it in June and held my tongue. The 'theft' was demanded of me, script and hour, by the man who could ruin me with one letter. I sank papers, Detective, not gold. There was no gold left to sink.",
                          unlock: .contradiction("c10x6")),

            // Mr. Maule
            CaseStatement("c10s07", "c10_maule",
                          "In ninety years no thief has passed our grille. Now one passes it without a scratch on the locks, on the precise eve of the trustees' audit. I do not believe in obliging coincidences, Detective."),
            CaseStatement("c10s08", "c10_maule",
                          "My key slept under my pillow as it has these thirty years. My wife will swear to it, and you will not frighten her - she has met auditors."),
            CaseStatement("c10s09", "c10_maule",
                          "Mr. Lydgate is the soundest man I have. Though I will say - he pressed me twice this summer to postpone the Fund's audit. Pressure of work, he said. We are a bank; work is always pressing."),
            CaseStatement("c10s10", "c10_maule",
                          "Mr. Quill visited the vault twice in September, on the trustee's letter of authority, to 'verify the seals.' Both times he required the boxes left with him a quarter hour. Both times Mr. Lydgate stood the watch outside."),
            CaseStatement("c10s11", "c10_maule",
                          "The night ledger is kept by the porter. Tarn is surly, but a bank does not want a charming man on the night door."),

            // Mr. Tarn
            CaseStatement("c10s12", "c10_tarn",
                          "Nobody passed my door after the locking. The night book is clean, and I was at the door every hour of it."),
            CaseStatement("c10s13", "c10_tarn",
                          "I heard nothing from below. The vault is two floors of stone down; a cannon would sound like a cough."),
            CaseStatement("c10s14", "c10_tarn",
                          "Aye, I worked the rail yards before this. A man may better himself, may he not? The League's own secretary wrote my character."),
            CaseStatement("c10s15", "c10_tarn",
                          "Half past midnight I stepped to the corner for tobacco. Ten minutes, no more. The door was double-locked behind me and the book don't show it because stepping out ain't an entry, is it?",
                          unlock: .contradiction("c10x4")),
            CaseStatement("c10s16", "c10_tarn",
                          "The ten minutes was bought, if you must have it - a sovereign under my cocoa tin that morning and a note saying when to want tobacco. I never asked who paid. In the yards you learn not to.",
                          unlock: .contradiction("c10x7")),

            // Miss Dimity
            CaseStatement("c10s17", "c10_dimity",
                          "The Widows' Fund passbook shows four thousand and forty pounds. But the pensions it pays have been late four quarters running - paid, when they are paid at all, out of the general account. One does not pay late from a full box, Detective."),
            CaseStatement("c10s18", "c10_dimity",
                          "I petitioned the trustees in August for an independent counting of the Fund. The petition was 'mislaid.' I petitioned again in September. The robbery has now rendered the question moot - which is, I would observe, remarkably convenient."),
            CaseStatement("c10s19", "c10_dimity",
                          "Mr. Vane subscribed the reward within six hours of the discovery. Grief moves slower than that, in my experience. Arrangements move faster."),
            CaseStatement("c10s20", "c10_dimity",
                          "Since Southwark I keep my own copies of everything, in a place I shall not name even to you. If my figures are right, the Fund has been hollow since the spring - hollowed from above, not robbed from below.",
                          unlock: .evidence("c10e5")),

            // Mr. Quill
            CaseStatement("c10s21", "c10_quill",
                          "The League is twice a victim now, Detective - first the forger, now this. Mr. Vane is inconsolable. The widows, of course, will be paid from his private purse."),
            CaseStatement("c10s22", "c10_quill",
                          "My September visits verified the seals at the trustees' instruction. The boxes were present, sealed, and heavy. I lifted two myself."),
            CaseStatement("c10s23", "c10_quill",
                          "A letter of authority from the trustee is hardly housebreaking. You may inspect it - Mr. Vane's hand, the League's seal, everything in order."),
            CaseStatement("c10s24", "c10_quill",
                          "I know nothing of bridges at midnight. I was at the patron's house in Highgate, drafting correspondence until two. Mr. Vane will confirm it.",
                          unlock: .evidence("c10e8")),
            CaseStatement("c10s25", "c10_quill",
                          "Since you press - the satchel was League property, reclaimed. What it held is trustee business, privileged. You may ask Mr. Vane, and Mr. Vane will be very sorry he cannot assist you.",
                          unlock: .contradiction("c10x8")),

            // Mr. Vane
            CaseStatement("c10s26", "c10_vane",
                          "Four thousand pounds of widows' bread, Detective. I have offered a hundred from my own pocket for these robbers, and I shall pay every pension myself until the Fund is restored. Write that down; the widows read the papers too."),
            CaseStatement("c10s27", "c10_vane",
                          "Miss Dimity petitioned for an audit, yes. I supported her warmly - the trustees' minutes will show my very words: 'Light is the League's business.' The delays were procedural. Procedure is the one thief no detective catches."),
            CaseStatement("c10s28", "c10_vane",
                          "Mr. Quill was with me in Highgate until two, drafting. My household will confirm the lamps burned late. Sixteen years, Detective - my right hand."),
            CaseStatement("c10s29", "c10_vane",
                          "Poor Lydgate. A sound man worn hollow by responsibility. You will find, when this is over, that the bank failed the Fund - not the League. The League merely trusted, as charity must."),
            CaseStatement("c10s30", "c10_vane",
                          "You look at me as though I were a suspect, Detective. I am a subscriber to your own Police Orphanage, you know. We are colleagues in lamplight, you and I - we both keep the dark respectable.")
        ]

        let locations = [
            CaseLocation("c10_vault", "The Lambeth Vault",
                         "Two floors down behind the double grille: the Widows' Fund boxes, seals intact, weights wrong.",
                         scene: .bankVault),
            CaseLocation("c10_boardroom", "The Bank Boardroom",
                         "Portraits of three generations of Maules watch the long table where the night ledger and the letters of authority lie.",
                         scene: .boardroom),
            CaseLocation("c10_bridge", "Lambeth Bridge",
                         "Gaslit and fog-wrapped. A waterman saw a satchel fall at midnight - and a boat waiting beneath the arch to receive it.",
                         scene: .bridge)
        ]

        let evidence = [
            EvidenceItem("c10e1", "Unscratched Locks",
                         "The locksmith's report on grille and vault door: no forcing, no picking, no wax in the wards. Both keys turned honestly. The vault was opened by people entitled to open it.",
                         at: "c10_vault", x: 0.28, y: 0.55),
            EvidenceItem("c10e2", "Resealed Boxes",
                         "The Widows' Fund boxes, seals apparently whole - but under the glass, each wax seal sits on a ghost of an older impression. Lifted hot and set again. The boxes were opened and resealed weeks before the 'robbery.'",
                         at: "c10_vault", x: 0.62, y: 0.68),
            EvidenceItem("c10e3", "Sand Ballast",
                         "Three boxes hold canvas bags of fine builder's sand, weighted to a sovereign-box's heft. Whoever filled them expected lifting, not counting.",
                         at: "c10_vault", x: 0.80, y: 0.46),
            EvidenceItem("c10e4", "Night Ledger Gap",
                         "The porter's night book, every hour initialled - except half past midnight, where the page shows the faint blot of an entry begun and wiped away wet.",
                         at: "c10_boardroom", x: 0.34, y: 0.60),
            EvidenceItem("c10e5", "Dimity's Shadow Ledger",
                         "Miss Dimity's private copies: the Fund's pensions paid late and short since spring, juggled through the general account. Her margin note: 'The boxes must be hollow. Petitioned 14 Aug. Petition mislaid.'",
                         at: "c10_boardroom", x: 0.70, y: 0.40),
            EvidenceItem("c10e6", "Dredged Satchel",
                         "Fished from beneath the bridge arch by the river police: a weighted leather satchel. Inside - no sovereigns. Sodden ledger leaves, June-to-September workings of the Widows' Fund, and torn box seals.",
                         at: "c10_bridge", x: 0.46, y: 0.78),
            EvidenceItem("c10e7", "Waterman's Account",
                         "The waterman's signed statement: at midnight a tall man in a bowler dropped the satchel from the parapet to a waiting skiff - which missed the catch. 'He swore very genteel about it and walked off north.'",
                         at: "c10_bridge", x: 0.20, y: 0.62),
            EvidenceItem("c10e8", "Cab Office Slip",
                         "The Westminster cab office's night sheet: a four-wheeler from Highgate set down one gentleman at Lambeth Bridge, 11.48 - engaged and paid under the League's standing account, signature 'E.Q.'",
                         at: "c10_bridge", x: 0.74, y: 0.50),
            EvidenceItem("c10e9", "Letter of Authority",
                         "Quill's September letter of authority for the vault visits - genuine seal, genuine hand: 'Mr. Quill acts in all particulars as myself. S. Vane, Trustee.' In all particulars, Detective.",
                         at: "c10_boardroom", x: 0.52, y: 0.30),
            EvidenceItem("c10e10", "Lydgate's June Memorandum",
                         "Found folded into Lydgate's own copy of the rules: a draft memorandum, June, never sent. 'To the Directors: I have reason to doubt the contents of the Widows' Fund boxes...' It stops mid-sentence, and the second sheet is a letter begging a private interview with Mr. Vane instead.",
                         at: "c10_vault", x: 0.14, y: 0.72)
        ]

        let contradictions = [
            Contradiction("c10x1", .statement("c10s04"), .evidence("c10e3"),
                          "Every Box Full",
                          "Lydgate counted four thousand in sovereigns in June, he swears - yet three boxes hold builder's sand sewn to a sovereign-box's weight, beneath seals lifted and reset long before any robbery."),
            Contradiction("c10x2", .statement("c10s02"), .evidence("c10e1"),
                          "The Impossible Vault",
                          "Both keys, both keepers, the thing impossible - and the locksmith agrees: no forcing at all. The vault was opened by its own keys, which is not impossibility. It is appointment."),
            Contradiction("c10x3", .statement("c10s03"), .evidence("c10e7"),
                          "Home by Eleven",
                          "Lydgate dined and was bolted into Camberwell by half past eleven, he says - but the waterman puts a genteel-swearing gentleman on the parapet at midnight, and Lydgate cannot explain the bridge."),
            Contradiction("c10x4", .statement("c10s12"), .evidence("c10e4"),
                          "Every Hour at the Door",
                          "Tarn's night book is clean because he wiped it: the half-past-midnight entry begun, blotted, and erased wet - the very minutes a satchel crossed the parapet upstream."),
            Contradiction("c10x5", .statement("c10s22"), .evidence("c10e2"),
                          "Heavy and Sealed",
                          "Quill lifted the boxes himself in September and found them sealed and heavy - heavy with sand, under seals that show an older ghost beneath the wax. His quarter-hours alone with them were when the ghosts were made."),
            Contradiction("c10x6", .statement("c10s04"), .evidence("c10e10"),
                          "The Letter Never Sent",
                          "Lydgate swears he counted four thousand in full boxes at the June counting - the same June his own abandoned memorandum began: 'I have reason to doubt the contents of the Widows' Fund boxes.' He chose a private interview with Mr. Vane over finishing the sentence."),
            Contradiction("c10x7", .statement("c10s15"), .evidence("c10e4"),
                          "Stepping Out Is No Entry",
                          "Tarn says the night book shows nothing because stepping out needs no entry - yet the half-past-midnight line carries an entry begun and wiped away wet. Someone started to write the truth that night and thought better of it."),
            Contradiction("c10x8", .statement("c10s24"), .evidence("c10e8"),
                          "Drafting Until Two",
                          "Quill was in Highgate at his desk until two, with the patron to vouch for him - while the League's own cab account set 'E.Q.' down at Lambeth Bridge at twelve minutes to midnight.")
        ]

        return GameCase(
            id: 10, act: 3,
            title: "The Widows' Fund",
            subtitle: "A vault emptied without a key turned wrong",
            brief: "On the eve of its first independent audit, the Widows' Fund of the Lamplighters' Benevolent League - four thousand pounds in sealed boxes at Coutts and Maule's - was found robbed. No lock scratched, no seal visibly broken, no entry in the night book. Mr. Vane has offered a reward and his tears to the newspapers. Miss Dimity has offered you something better: her own figures, which say the boxes were empty long before the thieves came.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "Commanded to stage the theft",
                "To steal four thousand pounds",
                "Hatred of the House of Maule",
                "To win the patron's reward",
                "To force the audit's delay"
            ],
            solution: CaseSolution(
                culpritId: "c10_lydgate",
                motive: "Commanded to stage the theft",
                keyEvidenceId: "c10e6",
                reveal: "There was no gold to steal. The Fund was hollowed in the spring - drained from above through Quill's sealed-box visits - and Cecil Lydgate, who counted sand in June and chose a private interview over an honest memorandum, was owned from that day. When Miss Dimity's audit could no longer be mislaid, the order came: stage the robbery, sink the workings. Lydgate turned his own key, filled the satchel with the Fund's true ledgers, and dropped it to a skiff that missed. The river kept the proof the vault was meant to lose. Lydgate and Tarn go before the magistrate - and the letter of authority that made Quill 'in all particulars' Mr. Vane goes into your casebook, beside a note signed with a little drawn lamp."
            )
        )
    }
}
