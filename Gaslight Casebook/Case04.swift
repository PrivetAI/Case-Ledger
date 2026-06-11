import Foundation

/// Act I, Case 4 — The Prize Rose Affair.
enum Case04 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c4_brock", name: "Albert Brock", role: "Head gardener",
                    bio: "Forty years in the Colonel's service and the true hands behind the famous Crimson Empress rose - a fact he mentions more often lately.",
                    portrait: PortraitSpec(skin: 1, hair: .cropped, hairColor: 3, facial: .sideburns,
                                           hat: .flatCap, collar: .apron, coat: 2)),
            Suspect(id: "c4_quince", name: "Septimus Quince", role: "Rival grower",
                    bio: "Grows roses two parishes over and has lost to the Crimson Empress three years running. Swore loudly at the spring show that he'd 'see her dead'.",
                    portrait: PortraitSpec(skin: 0, hair: .curly, hairColor: 4, facial: .fullBeard,
                                           hat: .wideBrim, collar: .highCollar, coat: 5)),
            Suspect(id: "c4_fern", name: "Miss Fern", role: "The Colonel's niece",
                    bio: "Keeps her uncle's correspondence, his show schedules, and - since his gout - most of his household in order.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 1, hat: .none,
                                           eyewear: .spectacles, collar: .lace, coat: 6, feminine: true)),
            Suspect(id: "c4_pettifer", name: "Mr. Pettifer", role: "Flower-show judge",
                    bio: "Senior judge of the Great Show, lately withdrawn from this year's panel for reasons he is at pains to explain.",
                    portrait: PortraitSpec(skin: 0, hair: .bald, hairColor: 3, facial: .moustache,
                                           hat: .topHat, eyewear: .pinceNez, collar: .cravat, coat: 0)),
            Suspect(id: "c4_dora", name: "Dora Tilbe", role: "Housemaid",
                    bio: "Youngest of the household staff, in charge of nothing and blamed for everything, including the kitchen's missing brine.",
                    portrait: PortraitSpec(skin: 1, hair: .long, hairColor: 2, hat: .nurseCap,
                                           collar: .apron, coat: 7, feminine: true)),
            Suspect(id: "c4_sloane", name: "Mr. Sloane", role: "Nurseryman",
                    bio: "Supplies half the county's gardens and asks few questions about where good stock comes from - a discretion that has served him well, until now.",
                    portrait: PortraitSpec(skin: 0, hair: .side, hairColor: 0, facial: .goatee,
                                           hat: .bowler, collar: .highCollar, coat: 1))
        ]

        let statements = [
            // Brock
            CaseStatement("c4s01", "c4_brock",
                          "Forty years I've grown roses, and that bed was my masterwork as much as his. I'd as soon poison my own children."),
            CaseStatement("c4s02", "c4_brock",
                          "I locked the potting shed at six as always and was in my cottage by dark. Whatever brine killed that bed never came from my shed."),
            CaseStatement("c4s03", "c4_brock",
                          "Every cutting ever taken from the Empress is in the Colonel's stock book. Fourteen grafts, every one accounted for."),
            CaseStatement("c4s04", "c4_brock",
                          "Quince swore at the spring show he'd see the Empress dead before the Great Show. Ask anyone who stood near the tea tent."),
            CaseStatement("c4s05", "c4_brock",
                          "Scars? You miscount, Detective. Old pruning wounds, nothing more. A desk man reading rose wood - forgive me if I smile.",
                          unlock: .contradiction("c4x2")),
            CaseStatement("c4s06", "c4_brock",
                          "The Colonel meant to register the stock after the show - number every graft, audit every bud. Sloane's money was two seasons spent. What would you have had me do? Hand him my forty years and let him count me a thief?",
                          unlock: .contradiction("c4x3")),

            // Quince
            CaseStatement("c4s07", "c4_quince",
                          "I said hot words at the spring show, I own it freely. Growers talk that way. But win or lose, you don't murder roses. It's against everything."),
            CaseStatement("c4s08", "c4_quince",
                          "That glove is mine - and I lost the pair of them at the spring show, a month ago. Someone has kept one a month, Detective. Think on why."),
            CaseStatement("c4s09", "c4_quince",
                          "I was in my own glasshouse all that night, syringing my own Empresses - mine, grown from stock I bought honest from Sloane this winter."),
            CaseStatement("c4s10", "c4_quince",
                          "Sloane swore his Empress stock came 'direct from the raiser's garden, private terms'. Four pounds a stock I paid, and asked no questions. Perhaps I should have."),

            // Miss Fern
            CaseStatement("c4s11", "c4_fern",
                          "Uncle sat up till eleven with the show schedule. From the library window we could see the rose bed; nothing stirred before we retired."),
            CaseStatement("c4s12", "c4_fern",
                          "The house was locked at eleven. Cook bolts the scullery herself; I heard the bolt go as I climbed the stair."),
            CaseStatement("c4s13", "c4_fern",
                          "Mr. Pettifer wired uncle on Tuesday - withdrawn from judging, his nephew exhibits this year. So the judge had nothing to gain. You may strike him off, I'd say."),
            CaseStatement("c4s14", "c4_fern",
                          "Brock has been odd since spring. Twice I found him at the stock book after hours, boots still on past the boot bench - and he is not a man who forgets his boots."),
            CaseStatement("c4s27", "c4_fern",
                          "Uncle never sold so much as a leaf of the Empress, to anyone. He refused royalty itself - the Princess's own gardener asked last June and went away empty-handed."),

            // Pettifer
            CaseStatement("c4s15", "c4_pettifer",
                          "I withdrew from judging by telegram the day my nephew entered. A judge's name is all he has, Detective."),
            CaseStatement("c4s16", "c4_pettifer",
                          "The Empress would have taken the gold cup unopposed; every grower in three counties knew it. Despair makes vandals of some men."),
            CaseStatement("c4s17", "c4_pettifer",
                          "I viewed the bed on Monday with the Colonel's leave. Brock hovered at my elbow the whole hour. I took it for devotion. Now I wonder if it was dread of what a judge's eye might count."),
            CaseStatement("c4s26", "c4_pettifer",
                          "One thing more. On Monday Brock asked me, casual as you please, whether judges examine graft unions closely. An odd question from a proud man."),

            // Dora
            CaseStatement("c4s18", "c4_dora",
                          "I never touched the nasty brine, sir. Cook counts her crocks like a miser, and I'm not paid enough to be blamed for everything in this house."),
            CaseStatement("c4s19", "c4_dora",
                          "The scullery door was bolted when I went up at eleven. Honest it was."),
            CaseStatement("c4s20", "c4_dora",
                          "All right - I drew the bolt at midnight to pass a note to the baker's boy, and I shut it after me, I did. But the brine crock was full at midnight; I saw it plain on the shelf. Whoever emptied it came later - and came through the garden door, not my scullery.",
                          unlock: .contradiction("c4x4")),
            CaseStatement("c4s21", "c4_dora",
                          "Mr. Brock came to the kitchen Friday asking how much salt cook kept by - casual-like, over his tea. Cook thought he meant the slugs."),

            // Sloane
            CaseStatement("c4s22", "c4_sloane",
                          "I deal in honest stock honestly come by. My Empress stocks were had on private terms from the raiser's own garden. There is no law against discretion."),
            CaseStatement("c4s23", "c4_sloane",
                          "I paid a gardener for budded stocks, yes - I understood the Colonel knew of it. One does not interrogate a head gardener of forty years about his master's leave.",
                          unlock: .contradiction("c4x3")),
            CaseStatement("c4s24", "c4_sloane",
                          "Consider, Detective: if the Empress sweeps the Great Show, registered and numbered, my five stocks become contraband. The dead bed has cost me four pounds and my good name. I had every reason to want those roses alive."),
            CaseStatement("c4s25", "c4_sloane",
                          "Quince bought from me in good faith. Leave him be. His only crime is wanting what another man grew first.")
        ]

        let locations = [
            CaseLocation("c4_garden", "The Rose Garden",
                         "The famous bed of the Crimson Empress - now nineteen blackened standards in salt-bitter earth.",
                         scene: .garden),
            CaseLocation("c4_shed", "The Potting Shed",
                         "Brock's kingdom: benches, tools, the stock book on its shelf, and a lock only he keeps the key to.",
                         scene: .workshop),
            CaseLocation("c4_kitchen", "The Kitchen",
                         "Cook's domain of crocks and copper pots, with the scullery door giving onto the kitchen garden.",
                         scene: .kitchen)
        ]

        let evidence = [
            EvidenceItem("c4e1", "Salt-Crusted Soil",
                         "The bed is bitter with brine - and Tuesday's heavy rain washed the surface smooth before the salt went down. Anything lying ON the crust arrived after the dousing.",
                         at: "c4_garden", x: 0.40, y: 0.72),
            EvidenceItem("c4e2", "Rinsed Watering Can",
                         "A watering can at the back of the locked potting shed, rinsed in haste: white salt rime still rings the seam and the rose of the spout.",
                         at: "c4_shed", x: 0.68, y: 0.65),
            EvidenceItem("c4e3", "The Empty Crock",
                         "Cook's brine crock, three gallons, stood full Saturday evening by her own count. By dawn it held an inch. Cook has blamed the scullery maid loudly and daily since.",
                         at: "c4_kitchen", x: 0.25, y: 0.55),
            EvidenceItem("c4e4", "Quince's Glove",
                         "A grower's glove stitched with Quince's initials, lying neatly ON the salt crust by the hedge - dry, clean, and a month gone from its owner.",
                         at: "c4_garden", x: 0.70, y: 0.60),
            EvidenceItem("c4e5", "The Stock Book",
                         "The Colonel's bud-wood register: fourteen grafts recorded from the Empress, signed off each season by Brock. But the mother plants carry nineteen graft scars - five daughters unaccounted for.",
                         at: "c4_shed", x: 0.30, y: 0.45),
            EvidenceItem("c4e6", "Sloane's Receipt",
                         "Folded in an oilskin coat hung in the shed: 'Received of Mr. Sloane, four pounds, for five budded Empress stocks delivered. Private terms.' No signature - but the coat is Brock's.",
                         at: "c4_shed", x: 0.50, y: 0.78),
            EvidenceItem("c4e7", "Nailed Boot Prints",
                         "Heavy nailed boot prints pressed deep into the brine-wet earth between the rows - a gardener's boots, walking the bed while the salt was still soaking in.",
                         at: "c4_garden", x: 0.18, y: 0.55),
            EvidenceItem("c4e8", "The Scullery Bolt",
                         "The scullery door bolt, found drawn at dawn. Cook swears she shot it at eleven; someone opened the door in the night.",
                         at: "c4_kitchen", x: 0.78, y: 0.40),
            EvidenceItem("c4e9", "Dora's Note",
                         "A note in the knife drawer, ready for delivery: 'Midnight at the gate, leave the bolt to me. - D.' The baker's boy's name is pencilled on the fold.",
                         at: "c4_kitchen", x: 0.55, y: 0.70),
            EvidenceItem("c4e10", "The Judge's Telegram",
                         "In the Colonel's trug: 'REGRET MUST WITHDRAW FROM PANEL THIS YEAR. NEPHEW EXHIBITS. PETTIFER.' Dated Tuesday - three days before the bed was killed.",
                         at: "c4_garden", x: 0.85, y: 0.35)
        ]

        let contradictions = [
            Contradiction("c4x1", .statement("c4s02"), .evidence("c4e2"),
                          "The Locked Shed",
                          "Brock swears the brine never came from his shed - the shed only he can open, where a watering can sits rinsed in haste with salt rime still in its seams."),
            Contradiction("c4x2", .statement("c4s03"), .evidence("c4e5"),
                          "Five Missing Daughters",
                          "Fourteen grafts, every one accounted for, says Brock. The mother plants say nineteen. Five cuttings of the most coveted rose in England left this garden off the books."),
            Contradiction("c4x3", .statement("c4s05"), .evidence("c4e6"),
                          "Four Pounds of Proof",
                          "Brock laughs off the scars as pruning wounds - while a receipt in his own coat pocket prices five budded Empress stocks at four pounds, 'private terms'."),
            Contradiction("c4x4", .statement("c4s19"), .evidence("c4e9"),
                          "The Midnight Bolt",
                          "Dora swears the scullery stayed bolted - but her own note promises the baker's boy that the bolt would be 'left to her' at midnight."),
            Contradiction("c4x5", .statement("c4s22"), .statement("c4s27"),
                          "The Raiser's Own Garden",
                          "Sloane claims his Empress stock came from the raiser's garden on private terms - yet the Colonel never sold a leaf of her to anyone, and turned away royalty itself."),
            Contradiction("c4x6", .evidence("c4e4"), .evidence("c4e1"),
                          "Planted Like a Rose",
                          "Quince's glove lies clean and dry ON the salt crust - which formed only after Tuesday's rain. A glove lost a month ago did not fall there by accident. It was laid there, after the deed."),
            Contradiction("c4x7", .statement("c4s02"), .evidence("c4e7"),
                          "Boots in the Brine",
                          "In his cottage by dark, says Brock - yet nailed gardener's boots walked between the rows while the brine was still wet in the earth.")
        ]

        return GameCase(
            id: 4, act: 1,
            title: "The Prize Rose Affair",
            subtitle: "Death of the Crimson Empress",
            brief: "Three days before the Great Show, Colonel Hartopp's celebrated rose bed - the Crimson Empress, unbeaten three years running - was doused with brine in the night. Nineteen standards are dead to the root. The Colonel suspects his sworn rival; the rival cries plant; and somewhere in the bitter earth is the truth of who killed the finest rose in England, and why.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To hide the sale of stolen cuttings",
                "Envy of his master's fame",
                "Revenge after the spring show",
                "To clear the field for a nephew",
                "Spite over forty years' wages"
            ],
            solution: CaseSolution(
                culpritId: "c4_brock",
                motive: "To hide the sale of stolen cuttings",
                keyEvidenceId: "c4e6",
                reveal: "For two seasons Brock had quietly budded extra grafts of the Empress and sold them to Sloane at four pounds a stock. When the Colonel announced the stock would be registered and audited after the show, every missing graft became a hangman's figure. So Brock carried cook's brine through the garden door in his own watering can, walked his nailed boots down the rows he had tended for forty years, and laid a month-old glove on the crust to send you after Quince. The receipt in his oilskin coat ends the matter."
            )
        )
    }
}
