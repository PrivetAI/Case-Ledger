import Foundation

/// Act I, Case 2 — The Poor-Box Affair.
enum Case02 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c2_tilly", name: "Amos Tilly", role: "Verger",
                    bio: "Twenty years keeping St. Bartle's swept, locked, and counted. Proud of his arithmetic and wounded that anyone doubted it.",
                    portrait: PortraitSpec(skin: 0, hair: .cropped, hairColor: 3, facial: .sideburns,
                                           hat: .flatCap, collar: .highCollar, coat: 5)),
            Suspect(id: "c2_cray", name: "Rev. Osmund Cray", role: "Curate",
                    bio: "A gentle, bookish curate who feeds the parish poor from his own small table and thinks ill of nobody - which is half his trouble.",
                    portrait: PortraitSpec(skin: 0, hair: .side, hairColor: 1, hat: .none,
                                           eyewear: .spectacles, collar: .clerical, coat: 0)),
            Suspect(id: "c2_pike", name: "Jonas Pike", role: "Sexton",
                    bio: "Digs the graves and minds the yard. Says little, sees much, and wears hobnailed boots you can hear three streets off.",
                    portrait: PortraitSpec(skin: 2, hair: .bald, hairColor: 0, facial: .fullBeard,
                                           hat: .wideBrim, collar: .apron, coat: 1)),
            Suspect(id: "c2_brisk", name: "Sally Brisk", role: "Flower-seller",
                    bio: "Sells violets and lilies at the lychgate. Owes the corn-chandler four shillings and tells everyone so before they can ask.",
                    portrait: PortraitSpec(skin: 1, hair: .wave, hairColor: 4, hat: .bonnet,
                                           collar: .shawl, coat: 7, feminine: true)),
            Suspect(id: "c2_gimm", name: "Howard Gimm", role: "Churchwarden",
                    bio: "A pillar of the parish for fifteen years, a man of business in the City, and lately - though few know it - a man of very bad investments.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 3, facial: .moustache,
                                           hat: .topHat, eyewear: .monocle, collar: .cravat, coat: 0)),
            Suspect(id: "c2_moss", name: "Daniel Moss", role: "Ex-soldier",
                    bio: "A discharged corporal who sleeps behind the yews. The parish points at him first and asks questions second.",
                    portrait: PortraitSpec(skin: 1, hair: .cropped, hairColor: 0, facial: .goatee,
                                           hat: .none, collar: .shawl, coat: 1))
        ]

        let statements = [
            // Tilly
            CaseStatement("c2s01", "c2_tilly",
                          "The box was sound at evensong Thursday. Friday morning the hasp hung bent and the box stood empty - three pounds eleven from Sunday's collection, gone."),
            CaseStatement("c2s02", "c2_tilly",
                          "Only three keys exist in all the world: mine on my belt, the curate's in the vestry drawer, and Mr. Gimm's on his watch chain."),
            CaseStatement("c2s03", "c2_tilly",
                          "That soldier Moss sleeps among the yews and I've chased him from the porch twice. You needn't look far, I'd say."),
            CaseStatement("c2s04", "c2_tilly",
                          "Mr. Gimm counted the collection alone this month. Said my arithmetic wandered. Twenty years it never wandered before."),
            CaseStatement("c2s05", "c2_tilly",
                          "I oiled that hasp myself at Michaelmas and it was screwed fast. To bend it so, you'd have to pry from inside the open lid - queer as that sounds."),

            // Cray
            CaseStatement("c2s06", "c2_cray",
                          "My key sits in the vestry drawer and the drawer was undisturbed. I last opened the box on Sunday, with Mr. Gimm at my elbow."),
            CaseStatement("c2s07", "c2_cray",
                          "Daniel Moss is a troubled man, but he sat at my own table Thursday evening over bread and tea until past ten. He spoke of his regiment."),
            CaseStatement("c2s08", "c2_cray",
                          "Mr. Gimm has been a pillar of this parish fifteen years. He restored the bell tower from his own purse, you know."),
            CaseStatement("c2s09", "c2_cray",
                          "The tally posted said three pounds eleven. Yet I remember the plates heavy that Sunday - we had a wedding crowd, you see, and wedding crowds give."),
            CaseStatement("c2s10", "c2_cray",
                          "Now that you press me - Mr. Gimm borrowed my key in October, 'to have the hasp seen to'. It came back two days later smelling faintly of wax. I thought nothing of it.",
                          unlock: .contradiction("c2x1")),

            // Pike
            CaseStatement("c2s11", "c2_pike",
                          "I dug Tuesday and Wednesday in the far corner and slept Thursday in my cottage. The yard was quiet but for the soldier's cough."),
            CaseStatement("c2s12", "c2_pike",
                          "Friday at dawn there was a square-heeled boot print under the vestry window. A gentleman's boot. Mine are hobnailed - see for yourself."),
            CaseStatement("c2s13", "c2_pike",
                          "Sally Brisk owes the corn-chandler, true enough. But that woman wouldn't climb a churchyard wall to save her own life."),
            CaseStatement("c2s14", "c2_pike",
                          "Moss left his bedroll and his tin cup behind the yews. A thief flees with his kit. That man means to stay and face whatever comes."),

            // Brisk
            CaseStatement("c2s15", "c2_brisk",
                          "I sell at the lychgate Fridays and Sundays, I owe the chandler four shillings, and I never set foot past the porch. That's gospel."),
            CaseStatement("c2s16", "c2_brisk",
                          "Saturday Mr. Gimm bought lilies for his wife - paid in shillings bright as morning, mint-new. Made a little joke: 'fresh money for fresh flowers.'"),
            CaseStatement("c2s17", "c2_brisk",
                          "The soldier gave me his last penny Wednesday for a buttonhole rose. Said his mother kept roses. A man flush with church money buys more than a penny rose."),
            CaseStatement("c2s18", "c2_brisk",
                          "Mr. Gimm's been at the market asking after the mail-coach times to Dover. Twice this week. Funny errand for a churchwarden."),

            // Gimm
            CaseStatement("c2s19", "c2_gimm",
                          "A scandalous business. The box held three pounds eleven by my own count, and the parish shall have every penny back from my pocket if need be."),
            CaseStatement("c2s20", "c2_gimm",
                          "My key never leaves my watch chain, Detective. Day or night. You may put that in your notebook."),
            CaseStatement("c2s21", "c2_gimm",
                          "Thursday evening I was at home with my account books. My housekeeper heard me at the desk till midnight."),
            CaseStatement("c2s22", "c2_gimm",
                          "I am a careful man of business. My affairs are in perfect order - ask anyone in the City."),
            CaseStatement("c2s23", "c2_gimm",
                          "Those shillings? Drawn from my own bank on Friday. A coincidence of mintage, nothing more sinister than that.",
                          unlock: .contradiction("c2x5")),
            CaseStatement("c2s24", "c2_gimm",
                          "You weave threads into rope, Detective. Very well - the Trust swallowed my savings and the brokers press me. But prove the wax, prove the key, prove any of it!",
                          unlock: .contradiction("c2x6")),

            // Moss
            CaseStatement("c2s25", "c2_moss",
                          "I sleep behind the yews because the dead don't move a man on. I've taken nothing from this church but shelter and the curate's tea."),
            CaseStatement("c2s26", "c2_moss",
                          "Thursday I sat with Reverend Cray till the clock struck ten, then walked the river till dawn. Cold keeps a man walking."),
            CaseStatement("c2s27", "c2_moss",
                          "Past midnight Thursday I heard a man cross the yard - good boots on gravel, not a tramp's shuffle. Saw a tall hat pass against the vestry light."),
            CaseStatement("c2s28", "c2_moss",
                          "I was a corporal once, Detective. I know what they think of me. If I'd done it, why would I stay where every finger points?")
        ]

        let locations = [
            CaseLocation("c2_vestry", "The Vestry",
                         "A small stone room: the poor-box on its shelf, the ledger desk, one narrow window.",
                         scene: .office),
            CaseLocation("c2_yard", "St. Bartle's Churchyard",
                         "Leaning stones, black yews, and a gravel path that carries every footstep.",
                         scene: .churchyard),
            CaseLocation("c2_market", "Market Square",
                         "Stalls and awnings outside the lychgate, where the parish does its buying and its talking.",
                         scene: .market)
        ]

        let evidence = [
            EvidenceItem("c2e1", "The Bent Hasp",
                         "The poor-box hasp, bent outward - pried from inside the open lid, not forced from without. The 'repair' Gimm once promised was never made: the screws are the old ones, untouched.",
                         at: "c2_vestry", x: 0.62, y: 0.40),
            EvidenceItem("c2e2", "Vestry Ledger",
                         "The collection ledger. Under Sunday last, the figure has been rubbed out and written again in a different hand. The blotting shows a larger sum beneath.",
                         at: "c2_vestry", x: 0.30, y: 0.60),
            EvidenceItem("c2e3", "Wax in the Keyhole",
                         "Deep in the poor-box keyhole, a smear of hardened beeswax - the unmistakable residue of a wax impression. Somewhere there is a fourth key.",
                         at: "c2_vestry", x: 0.74, y: 0.62),
            EvidenceItem("c2e4", "The Soldier's Bedroll",
                         "Behind the yews: a bedroll folded with barrack-square neatness, and a tin cup holding two pennies. The kit of a man who owns nothing and hides nothing.",
                         at: "c2_yard", x: 0.18, y: 0.66),
            EvidenceItem("c2e5", "Broker's Letter",
                         "Wedged in a bench crack near the path: 'Mr. H. Gimm - unless forty pounds margin is received by Monday noon, your positions in the Consolidated Trust will be closed and the deficiency pursued at law.'",
                         at: "c2_yard", x: 0.50, y: 0.78),
            EvidenceItem("c2e6", "Brass Filings",
                         "A scatter of fine brass filings along the ledger desk's edge, caught in the wood grain. Someone dressed a fresh-cut key here, patiently, after hours.",
                         at: "c2_vestry", x: 0.45, y: 0.74),
            EvidenceItem("c2e7", "Sally's Flower Ledger",
                         "Sally's penny notebook: 'Sat. - Mr. G., lilies 2s., paid new shillings, joked abt fresh money.' She records every sale; the chandler insists.",
                         at: "c2_market", x: 0.30, y: 0.55),
            EvidenceItem("c2e8", "Sunday Tally Slip",
                         "The posted tally in Gimm's hand: 'Collection, Sunday - 3 pounds 11 s.' Pinned beneath, the order of service for the same day: a wedding with ninety guests.",
                         at: "c2_market", x: 0.68, y: 0.35),
            EvidenceItem("c2e9", "Square-Heeled Print",
                         "Beneath the vestry window, pressed in Friday's frost: one clear print of a square-heeled city boot. Pike wears hobnails; Moss's soles are split flat.",
                         at: "c2_yard", x: 0.80, y: 0.55)
        ]

        let contradictions = [
            Contradiction("c2x1", .statement("c2s19"), .statement("c2s09"),
                          "The Light Tally",
                          "Gimm's count says three pounds eleven, yet the curate remembers heavy plates and a giving wedding crowd of ninety. The man who counted alone is the man whose figure looks small."),
            Contradiction("c2x2", .statement("c2s10"), .evidence("c2e1"),
                          "The Hasp That Was Never Mended",
                          "Gimm borrowed the curate's key 'to have the hasp seen to' - but the hasp's screws were never touched. The key went away for two days for some other purpose, and came back smelling of wax."),
            Contradiction("c2x3", .statement("c2s21"), .statement("c2s27"),
                          "Boots on the Gravel",
                          "Gimm swears he sat at his desk till midnight - yet past midnight Moss heard a gentleman's boots cross the yard and saw a tall hat pass the vestry light. Of all the parish men, only Gimm wears a tall hat."),
            Contradiction("c2x4", .statement("c2s22"), .evidence("c2e5"),
                          "In Perfect Order",
                          "A careful man of business, his affairs in perfect order - and a broker's letter demanding forty pounds by Monday on pain of ruin."),
            Contradiction("c2x5", .evidence("c2e5"), .evidence("c2e7"),
                          "Broke Friday, Flush Saturday",
                          "On Friday Gimm faced ruin for want of forty pounds. On Saturday he bought lilies with mint-new shillings and joked about fresh money. Something filled his pockets overnight."),
            Contradiction("c2x6", .statement("c2s23"), .evidence("c2e5"),
                          "No Well to Draw From",
                          "Gimm claims he drew the bright shillings from his own bank on Friday - the very day his broker wrote that his accounts were stripped and forty pounds wanting. There was nothing left to draw."),
            Contradiction("c2x7", .statement("c2s02"), .evidence("c2e3"),
                          "Three Keys, and a Fourth",
                          "The verger swears only three keys exist - but wax pressed deep in the keyhole says a fourth was made by someone with time alone beside the box.")
        ]

        return GameCase(
            id: 2, act: 1,
            title: "The Poor-Box Affair",
            subtitle: "Theft from St. Bartle's vestry",
            brief: "The poor-box of St. Bartle's has been emptied between Thursday evensong and Friday dawn - Sunday's whole collection gone, the hasp bent to look like burglary. The parish has already decided the soldier sleeping in the churchyard did it. The curate, who does not believe it, has quietly asked for you.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To cover ruinous investments",
                "Drink and simple want",
                "Old spite against the curate",
                "To frame the vagrant soldier",
                "Greed, plain and simple"
            ],
            solution: CaseSolution(
                culpritId: "c2_gimm",
                motive: "To cover ruinous investments",
                keyEvidenceId: "c2e3",
                reveal: "Howard Gimm copied the curate's key in October against the day his Trust shares failed. When the broker's ultimatum came, he let himself into the vestry past midnight, emptied the box with his fourth key, bent the hasp to dress it as burglary, and posted a tally light by pounds he had already skimmed. The wax in the keyhole, the filings on his desk, and the mint shillings in Sally's ledger unmade him. The Dover coach leaves without him."
            )
        )
    }
}
