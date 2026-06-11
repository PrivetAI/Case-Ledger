import Foundation

/// Act II, Case 5 — Death at the Gasworks.
enum Case05 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c5_skee", name: "Walter Skee", role: "Deputy foreman",
                    bio: "Ten years at the works, second to foreman Marlow in rank and - he would tell you - in nothing else. Counter-initials the stores ledger.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 0, facial: .moustache,
                                           hat: .flatCap, collar: .uniform, coat: 0)),
            Suspect(id: "c5_hale", name: "Tom Hale", role: "Stoker",
                    bio: "A big, loud man with a docked half-week's wages and a Friday-night vow at the gate to 'settle with' the foreman. The yard's favourite suspect.",
                    portrait: PortraitSpec(skin: 2, hair: .cropped, hairColor: 0, facial: .fullBeard,
                                           hat: .flatCap, collar: .apron, coat: 2)),
            Suspect(id: "c5_pruitt", name: "Mr. Pruitt", role: "Works manager",
                    bio: "Answers to the company for output and little else. Signed Marlow's stocktake requisition without reading past the first line.",
                    portrait: PortraitSpec(skin: 0, hair: .bald, hairColor: 3, facial: .none,
                                           hat: .topHat, eyewear: .spectacles, collar: .cravat, coat: 4)),
            Suspect(id: "c5_gorse", name: "Ezekiel Gorse", role: "Night fireman",
                    bio: "Walks the night rounds with oil can and lantern. His round skipped the retort house that one night, on a written order.",
                    portrait: PortraitSpec(skin: 1, hair: .curly, hairColor: 3, facial: .sideburns,
                                           hat: .flatCap, collar: .uniform, coat: 5)),
            Suspect(id: "c5_vane", name: "Silas Vane", role: "Scrap dealer",
                    bio: "Keeps the weighbridge in Scrap Lane and a careful neutrality about where metal comes from. Pays cash, keeps slips.",
                    portrait: PortraitSpec(skin: 1, hair: .side, hairColor: 1, facial: .goatee,
                                           hat: .bowler, collar: .highCollar, coat: 1)),
            Suspect(id: "c5_lydia", name: "Lydia Crane", role: "Works clerk",
                    bio: "Keeps the stores ledger to the ounce and the office in order. Notices hooks, hands, and habits; it is her trade to notice.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 1, hat: .none,
                                           eyewear: .spectacles, collar: .highCollar, coat: 6, feminine: true))
        ]

        let statements = [
            // Skee
            CaseStatement("c5s01", "c5_skee",
                          "A black night for the works. Joe must have smelled gas on a last round, climbed to the valve, and the fumes took him at the rail. I've said for years that gantry rail is too low."),
            CaseStatement("c5s02", "c5_skee",
                          "I clocked out at nine and was home by the half hour. My card is in the rack, punched plain as print."),
            CaseStatement("c5s03", "c5_skee",
                          "Copper shortages? First I've heard of any shortage, and Joe never breathed one word of a stocktake to me."),
            CaseStatement("c5s04", "c5_skee",
                          "Tom Hale swore at the gate on Friday he'd 'settle with' Joe over the docked wages. The whole yard heard him."),
            CaseStatement("c5s05", "c5_skee",
                          "So my lamp burned late - a deputy has fittings to mend and rotas to write. I moved Gorse to the coal stage because the stage wanted watching. Arranging the men is the whole of my crime.",
                          unlock: .contradiction("c5x3")),
            CaseStatement("c5s06", "c5_skee",
                          "Joe counted everything - that was his sickness. Eighty-four pounds of copper is dross, pennies! A man's whole life weighed against pipe ends. Is that your justice, Detective?",
                          unlock: .contradiction("c5x7")),

            // Hale
            CaseStatement("c5s07", "c5_hale",
                          "Aye, I said I'd settle with him - settle, as in the union office, not a spanner. Joe docked me fair by his lights. We'd have squared it Monday."),
            CaseStatement("c5s08", "c5_hale",
                          "I was at the Boiler Arms from eight till they swept me out past midnight. Twenty men saw me - and I sang, which they'll not soon forget."),
            CaseStatement("c5s09", "c5_hale",
                          "Joe was no climber by night. Twenty years on that floor and he never went up the gantry without a lit lantern and a man standing below. Never once."),
            CaseStatement("c5s10", "c5_hale",
                          "Ask yourself why the valve key wrench lives locked in the office, and the valve still got opened. Keys, Detective. This place runs on whose hands hold keys."),
            CaseStatement("c5s27", "c5_hale",
                          "One more thing. Joe told me at the gate Friday: 'After Monday there'll be a reckoning that puts your half-week to shame.' And he looked at the fitting shop when he said it."),

            // Pruitt
            CaseStatement("c5s11", "c5_pruitt",
                          "The works loses a foreman and the company wires me about output. Write that down; it is the truest thing you will hear today."),
            CaseStatement("c5s12", "c5_pruitt",
                          "Marlow requisitioned a stocktake on Friday. Said he 'misliked the weight of the copper bins'. I signed it and thought no more about it."),
            CaseStatement("c5s13", "c5_pruitt",
                          "I dined in town and returned at eleven for my papers. The yard gate stood unbarred - Gorse's duty - and I made a note to fine the man."),
            CaseStatement("c5s14", "c5_pruitt",
                          "Skee is a capable deputy. Hungry, though. Twice this year he asked me what the foreman's wage came to, to the shilling."),
            CaseStatement("c5s28", "c5_pruitt",
                          "For completeness, Detective: the company insures against accident, not murder. If you mean to write 'unlawful killing', kindly warn me first so I may sit down."),

            // Gorse
            CaseStatement("c5s15", "c5_gorse",
                          "My round skips nothing, sir - except that night it skipped the retort house, because Mr. Skee's written order shifted me to the coal stage, eleven till midnight. That night only."),
            CaseStatement("c5s16", "c5_gorse",
                          "Near midnight I heard the gantry ring once. Iron on iron, a single stroke, like a cracked bell. I took it for a slipped tool."),
            CaseStatement("c5s17", "c5_gorse",
                          "The gate? I barred it myself at ten. If it stood open at eleven, then someone with a key opened it after me."),
            CaseStatement("c5s18", "c5_gorse",
                          "I'd not speak ill of the dead man's deputy - but Skee's lamp was burning in the fitting shop past ten that night. I saw the glow under the door when I fetched my oil."),
            CaseStatement("c5s29", "c5_gorse",
                          "And the retort house valve was sound at ten - I passed it before the order moved me. No hiss, no stink. Whatever opened, opened after."),

            // Vane
            CaseStatement("c5s19", "c5_vane",
                          "I weigh what comes over my bridge and I pay fair coin. Where metal grows from is its owner's affair, not mine."),
            CaseStatement("c5s20", "c5_vane",
                          "Works copper, with the marks ground off? Detective, if I asked every seller about grinder marks, I'd starve by Lady Day."),
            CaseStatement("c5s21", "c5_vane",
                          "All right - the slip is mine. 'W.S.', eighty-four pound, Thursday, cash. He came at dusk with a barrow, tall fellow, deputy's badge still pinned to his coat. Careless, that.",
                          unlock: .contradiction("c5x5")),
            CaseStatement("c5s22", "c5_vane",
                          "Marlow came by Friday evening asking after Thursday's weights. I showed him the slip - dealers and foremen keep the peace by candour. He copied it into his pocketbook, grim as a parson."),

            // Lydia
            CaseStatement("c5s23", "c5_lydia",
                          "I keep the stores ledger to the ounce. The columns balance because Mr. Skee counter-initials the copper bins himself. A clerk's figures are only as honest as the counting hand."),
            CaseStatement("c5s24", "c5_lydia",
                          "Mr. Marlow borrowed the ledger Thursday evening and returned it Friday with a face like slate. He asked me who held the bin keys. I told him: the foreman, the deputy, none other."),
            CaseStatement("c5s25", "c5_lydia",
                          "On Friday afternoon Mr. Skee asked me - twice - whether a posted stocktake could be put off if the foreman were 'called away'. I thought it idle talk. I no longer think so."),
            CaseStatement("c5s26", "c5_lydia",
                          "The valve key wrench hangs in the office on the third hook. Saturday morning it hung on the second. A small thing - but I notice hooks, Detective. It is my trade to notice.")
        ]

        let locations = [
            CaseLocation("c5_yard", "The Retort Yard",
                         "The gantry, the great gasometer, and the chalk line where foreman Marlow was found.",
                         scene: .gasworks),
            CaseLocation("c5_office", "The Works Office",
                         "Time cards, rotas, the requisition spike - and the hook where the valve key wrench hangs.",
                         scene: .office),
            CaseLocation("c5_stores", "The Stores",
                         "Bins of brass and copper fittings behind a barred door with exactly two keys.",
                         scene: .warehouse),
            CaseLocation("c5_lane", "Scrap Lane",
                         "Vane's weighbridge and the culvert that carries the works' runoff - and sometimes more - away.",
                         scene: .alley)
        ]

        let evidence = [
            EvidenceItem("c5e1", "The Opened Valve",
                         "The retort house valve, opened to its full stop with the office key wrench. A man dizzy with fumes does not open a valve fully, replace nothing, and then fall twenty feet from where he stood.",
                         at: "c5_yard", x: 0.62, y: 0.35),
            EvidenceItem("c5e2", "Marlow's Lantern",
                         "Found beside the body: his lantern - unlit, shutter closed, reservoir full. No man inspects a gas leak in the dark.",
                         at: "c5_yard", x: 0.30, y: 0.70),
            EvidenceItem("c5e9", "Marlow's Pocketbook",
                         "In the foreman's coat: 'W.S. - ask re: 84 lb Thursday. Vane's slip. Monday.' The last entry he ever made.",
                         at: "c5_yard", x: 0.80, y: 0.62),
            EvidenceItem("c5e3", "Stocktake Notice",
                         "Posted Friday on the office board: 'Full stocktake of non-ferrous stores, Monday 6 a.m. All bin keys to be surrendered to me by Sunday night. - J. Marlow, Foreman.' Every keyholder signs the board daily. Skee's initials sit two inches beneath it.",
                         at: "c5_office", x: 0.25, y: 0.40),
            EvidenceItem("c5e8", "Skee's Time Card",
                         "Punched out at 9:02. But the rack clock sits by the gate, and the gate is not the works; a man may punch his card and walk back in through any door he holds a key to.",
                         at: "c5_office", x: 0.55, y: 0.60),
            EvidenceItem("c5e10", "The Rota Order",
                         "In Skee's hand: 'Gorse - coal stage, 11-12, this night only. W.S.' The one hour, the one night, the one round that watched the retort house.",
                         at: "c5_office", x: 0.78, y: 0.35),
            EvidenceItem("c5e11", "Hale's Wage Docket",
                          "The docket docking Hale half a week, signed Marlow. Pinned beside it, Hale's grievance note to the union - dated, stamped, and entirely orderly.",
                          at: "c5_office", x: 0.40, y: 0.75),
            EvidenceItem("c5e4", "The Stores Ledger",
                         "Lydia's neat columns, Skee's counter-initials. The copper bin entries for six months run in suspiciously round figures - the look of numbers written to balance, not to count.",
                         at: "c5_stores", x: 0.35, y: 0.55),
            EvidenceItem("c5e5", "Sack of Fittings",
                         "Behind the crates: a sack of copper unions and brass cocks, works pattern, with the stencilled works mark ground off every piece.",
                         at: "c5_stores", x: 0.70, y: 0.70),
            EvidenceItem("c5e6", "Weighbridge Slip",
                         "Vane's carbon slip: 'Thurs. - W.S. - copper, 84 lb - paid cash.' The original went into Marlow's pocketbook on Friday evening.",
                         at: "c5_lane", x: 0.30, y: 0.50),
            EvidenceItem("c5e7", "The Culvert Spanner",
                         "A heavy valve spanner fished from the culvert by the wall - scrubbed with sand, yet a dark smear survives where head meets shaft. The rack in the fitting shop is missing exactly one.",
                         at: "c5_lane", x: 0.68, y: 0.72)
        ]

        let contradictions = [
            Contradiction("c5x1", .statement("c5s01"), .evidence("c5e2"),
                          "A Dark Lantern",
                          "Skee's accident wants Marlow climbing to a leak in the dead of night - with a lantern unlit, shuttered, and full. No foreman of twenty years inspects gas in the dark."),
            Contradiction("c5x2", .statement("c5s03"), .evidence("c5e3"),
                          "The Notice He Never Saw",
                          "Skee never heard of any stocktake - though it was posted Friday on the board he signs daily, two inches above his own initials, ordering his bin keys surrendered."),
            Contradiction("c5x3", .statement("c5s02"), .statement("c5s18"),
                          "The Lamp Under the Door",
                          "Home by half past nine, says Skee's card. Past ten, says Gorse, Skee's lamp still burned in the fitting shop. A punched card proves where the card was - not the man."),
            Contradiction("c5x4", .statement("c5s01"), .statement("c5s09"),
                          "Not a Night Climber",
                          "The accident needs Marlow climbing alone in the dark - and every man on the floor knew he never went up the gantry without a lit lantern and a man below. Never once in twenty years."),
            Contradiction("c5x5", .statement("c5s03"), .evidence("c5e6"),
                          "Cash on Thursday",
                          "No shortages that Skee ever heard of - while Vane's weighbridge slip records 'W.S.' selling eighty-four pounds of copper for cash on Thursday at dusk."),
            Contradiction("c5x6", .statement("c5s17"), .statement("c5s13"),
                          "The Unbarred Gate",
                          "Gorse barred the gate at ten; Pruitt found it open at eleven. Between those hours someone with a key let himself back into the works - and the keys are counted on one hand."),
            Contradiction("c5x7", .statement("c5s01"), .evidence("c5e7"),
                          "Accidents Hide No Tools",
                          "If Marlow simply fell, why was a valve spanner scrubbed with sand and sunk in the culvert - with one dark smear surviving where the head meets the shaft?"),
            Contradiction("c5x8", .statement("c5s04"), .statement("c5s08"),
                          "The Man Who Sang",
                          "Skee points to Hale's Friday threat - but Hale spent the whole night singing at the Boiler Arms before twenty witnesses. The yard's favourite suspect is the one man who could not have done it.")
        ]

        return GameCase(
            id: 5, act: 2,
            title: "Death at the Gasworks",
            subtitle: "The foreman beneath the gantry",
            brief: "Foreman Joseph Marlow was found at dawn at the foot of the retort house gantry, the great valve open above him and the yard thick with gas. The company calls it a tragic fall during a night inspection. But Marlow had just ordered a stocktake of the copper stores, demanded every bin key by Sunday - and never lived to count a single fitting. You are sent because the coroner will not sign.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To bury the theft of works copper",
                "To take the foreman's place",
                "A quarrel over docked wages",
                "An old grudge from the floor",
                "To collect on works insurance"
            ],
            solution: CaseSolution(
                culpritId: "c5_skee",
                motive: "To bury the theft of works copper",
                keyEvidenceId: "c5e6",
                reveal: "Skee had bled the copper bins for two seasons, balancing the ledger with his own initials. Marlow weighed the bins, walked to Vane's, and copied the slip that named 'W.S.' - and posted a stocktake that would end everything on Monday. So Skee punched his card, walked back through the gate he held a key to, moved the one watchman off the one round that mattered, and met his foreman on the gantry with a spanner. The open valve and the dark lantern were meant to write 'accident'. The culvert gave back the spanner, and Vane remembered the badge on his coat."
            )
        )
    }
}
