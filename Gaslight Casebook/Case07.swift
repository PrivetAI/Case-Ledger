import Foundation

/// Act II, Case 7 — The Half Tide Cargo.
enum Case07 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c7_mott", name: "Silas Mott", role: "Wharfinger",
                    bio: "Master of Blackwall Stairs wharf these eleven years. Keeps the manifests, the keys, and his own counsel.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 0, facial: .sideburns,
                                           hat: .bowler, collar: .highCollar, coat: 3)),
            Suspect(id: "c7_okafor", name: "Jonah Okafor", role: "Foreman stevedore",
                    bio: "Twenty years on the river and the strongest back on the wharf. Tull promoted him over older men, and some never forgave it.",
                    portrait: PortraitSpec(skin: 3, hair: .cropped, hairColor: 0, facial: .none,
                                           hat: .flatCap, collar: .uniform, coat: 1)),
            Suspect(id: "c7_hale", name: "Birdie Hale", role: "Dockside cook",
                    bio: "Feeds the gangs from a kitchen by the tally house. A barge widow who hears everything said over soup.",
                    portrait: PortraitSpec(skin: 1, hair: .bun, hairColor: 3, facial: .none,
                                           hat: .none, collar: .shawl, coat: 1, feminine: true)),
            Suspect(id: "c7_grebe", name: "Constable Grebe", role: "River police",
                    bio: "Walks the wharf beat by night. A steady record, though lately his rounds have grown curiously short.",
                    portrait: PortraitSpec(skin: 0, hair: .cropped, hairColor: 1, facial: .moustache,
                                           hat: .policeHelmet, collar: .uniform, coat: 3)),
            Suspect(id: "c7_pinch", name: "Mr. Ezekiel Pinch", role: "Customs gauger",
                    bio: "Measures every cask that crosses the wharf for the Crown's duty. Proud of a rod that has never lied - he says.",
                    portrait: PortraitSpec(skin: 0, hair: .bald, hairColor: 3, facial: .goatee,
                                           hat: .none, eyewear: .spectacles, collar: .highCollar, coat: 0)),
            Suspect(id: "c7_vesta", name: "Vesta Tull", role: "The victim's daughter",
                    bio: "Kept her father's lodgings and mended his books when his eyes tired. Came to the wharf at dawn and would not leave.",
                    portrait: PortraitSpec(skin: 0, hair: .long, hairColor: 1, facial: .none,
                                           hat: .bonnet, collar: .lace, coat: 6, feminine: true))
        ]

        let statements = [
            // Silas Mott
            CaseStatement("c7s01", "c7_mott",
                          "Ezra Tull drank, Detective. He drank, he walked the dock edge in the dark, and the river took him. A sad business and a simple one."),
            CaseStatement("c7s02", "c7_mott",
                          "My manifests balance to the last cask. Lamp oil in, lamp oil out - the Crown's gauger will tell you the same."),
            CaseStatement("c7s03", "c7_mott",
                          "I was in my counting house from eight until the cry went up, and I never once crossed the tally yard."),
            CaseStatement("c7s04", "c7_mott",
                          "Tull and I had no quarrel. I made him gang-master myself, over better men."),
            CaseStatement("c7s05", "c7_mott",
                          "Very well - I crossed the tally yard at nine to fetch the gate book. A minute, no more. I never went near the rain barrels.",
                          unlock: .contradiction("c7x1")),
            CaseStatement("c7s06", "c7_mott",
                          "You hold a burnt scrap and call it forty casks. Tull's sums were an old man's sums. Nothing was ever short on my wharf.",
                          unlock: .contradiction("c7x4")),

            // Jonah Okafor
            CaseStatement("c7s07", "c7_okafor",
                          "Ezra was no drunkard. Two pots of porter with his supper and never a drop on the wharf - every man of the gang will swear it."),
            CaseStatement("c7s08", "c7_okafor",
                          "The yard gates were chained at eight sharp. I chained them myself and gave the key to the night box. Nobody walked in off the street."),
            CaseStatement("c7s09", "c7_okafor",
                          "Ezra kept his tally book closer than his prayer book. The last week he carried it buttoned inside his coat, like a man guarding something."),
            CaseStatement("c7s10", "c7_okafor",
                          "Mott's warehouse stove was alight past ten that night. I smelled the smoke from the dock. Who burns a stove in a bonded store at night?"),
            CaseStatement("c7s11", "c7_okafor",
                          "He told me Thursday: 'Jonah, the oil is wrong.' I asked him wrong how, and he said he would count it once more before he spoke.",
                          unlock: .evidence("c7e4")),

            // Birdie Hale
            CaseStatement("c7s12", "c7_hale",
                          "Ezra took his supper at my window at half past eight, sober as a magistrate, and went off toward the tally house with his book under his arm."),
            CaseStatement("c7s13", "c7_hale",
                          "Mr. Mott came by the kitchen near nine, walking quick, and his cuff was wet to the elbow. In September, with no rain since Tuesday."),
            CaseStatement("c7s14", "c7_hale",
                          "The charity mission keeps crates in warehouse four now - the Lamplighters' Benevolent League, soup and tracts for the watermen. Fine folk, I am sure."),
            CaseStatement("c7s15", "c7_hale",
                          "Constable Grebe takes his cocoa at my window at ten, regular as the tide. That night he came at half nine and stayed the hour."),
            CaseStatement("c7s16", "c7_hale",
                          "Miss Vesta pawned her mother's locket on Friday. For the rent, poor lamb - her father's wages went into that book of his and never came out."),

            // Constable Grebe
            CaseStatement("c7s17", "c7_grebe",
                          "I walked the full beat that night, every round, gate to stairs and back. My card is marked and my sergeant may see it."),
            CaseStatement("c7s18", "c7_grebe",
                          "I found him at the dock steps at six, half in the water. The tide had been at him, but there was no reek of drink on the body."),
            CaseStatement("c7s19", "c7_grebe",
                          "The tally yard barrels stood full on Monday. One of them is down a good hand's depth since, and no gang draws washing water at night."),
            CaseStatement("c7s20", "c7_grebe",
                          "All right. I sat the hour at Mrs. Hale's window and let the ten o'clock round go. A man may warm himself once in a wet month. It cost no one anything - or so I believed.",
                          unlock: .contradiction("c7x6")),

            // Mr. Pinch
            CaseStatement("c7s21", "c7_pinch",
                          "Every cask on that manifest passed my rod, and every cask gauged as lamp oil. The Crown has no quarrel with Blackwall Stairs."),
            CaseStatement("c7s22", "c7_pinch",
                          "Mr. Mott is a careful man. He stacks the duty rows himself and brings me the samples to my bench. It spares my knees the ladders."),
            CaseStatement("c7s23", "c7_pinch",
                          "Tull came to me Wednesday asking how a man might read a gauger's mark. I told him the marks are Crown business and sent him off."),
            CaseStatement("c7s24", "c7_pinch",
                          "If a cask were stencilled oil and filled with brandy, the rod would find it - had the rod ever touched it. I gauge what is brought to my bench, Detective. I confess the distinction has been allowed to blur.",
                          unlock: .contradiction("c7x5")),

            // Vesta Tull
            CaseStatement("c7s25", "c7_vesta",
                          "Father had not taken spirits these nine years, not since Mother died. Whoever says the river took a drunkard is calling him a liar in his grave."),
            CaseStatement("c7s26", "c7_vesta",
                          "He sat up Thursday past midnight with his tally book, counting and crossing and counting again, and he said: 'Forty casks, Vee. Forty casks of nothing.'"),
            CaseStatement("c7s27", "c7_vesta",
                          "He meant to take what he found to the customs men on Saturday. He told me to say nothing until it was done."),
            CaseStatement("c7s28", "c7_vesta",
                          "The last page of his book is torn out. Father never tore a page in his life - he ruled mistakes through with red ink and signed them."),
            CaseStatement("c7s29", "c7_vesta",
                          "Mr. Mott came to our lodgings Friday evening, all kindness, offering Father a quiet pension to 'rest his eyes at last.' Father showed him the door.",
                          unlock: .evidence("c7e5")),
            CaseStatement("c7s30", "c7_vesta",
                          "Yes - the locket went to the pawnshop for rent. My shame is poverty, Detective. It is not the shame you are hunting on this wharf.")
        ]

        let locations = [
            CaseLocation("c7_dock", "Blackwall Stairs",
                         "Black water, wet stone steps, and the crane swinging idle over the spot where they brought him up.",
                         scene: .dock),
            CaseLocation("c7_warehouse", "Bonded Warehouse No. 4",
                         "Duty rows of casks in the gloom, the charity mission's crates - and a stove that should be cold.",
                         scene: .warehouse),
            CaseLocation("c7_tally", "Tally House Cellar",
                         "The gang's tally room below the counting house: rain barrels by the door, ledgers within.",
                         scene: .cellar)
        ]

        let evidence = [
            EvidenceItem("c7e1", "Surgeon's Note",
                         "The police surgeon's memorandum: 'Lungs hold fresh water, free of river silt. The man did not drown in the Thames.'",
                         at: "c7_dock", x: 0.24, y: 0.70),
            EvidenceItem("c7e2", "Doctored Manifest",
                         "The week's manifest. Under a raking light, 'brandy, forty casks' has been scraped and rewritten 'lamp oil' in the same careful hand that signs the page: S. Mott.",
                         at: "c7_warehouse", x: 0.74, y: 0.40),
            EvidenceItem("c7e3", "Disturbed Rain Barrel",
                         "The middle barrel by the tally house door, down a hand's depth, its rim scuffed bright and one hoop sprung - as if a great weight had been forced over the edge.",
                         at: "c7_tally", x: 0.28, y: 0.62),
            EvidenceItem("c7e4", "Tull's Tally Book",
                         "Recovered from the dead man's coat, swollen with water. Week upon week of neat figures - and the final page torn away at the stitching.",
                         at: "c7_dock", x: 0.62, y: 0.78),
            EvidenceItem("c7e5", "Burnt Tally Page",
                         "In the warehouse stove's ashes, a half-burnt page in Tull's ruling: '...counted against manifest... forty casks short of oil, forty over of... ' The rest is char.",
                         at: "c7_warehouse", x: 0.36, y: 0.66),
            EvidenceItem("c7e6", "Silver Cufflink",
                         "A square silver cufflink engraved 'S.M.', trodden into the mud a stride from the rain barrels.",
                         at: "c7_tally", x: 0.55, y: 0.80),
            EvidenceItem("c7e7", "Mis-stencilled Cask",
                         "A cask stencilled LAMP OIL in the duty row. The bung weeps a dark, sweet spirit; the gauger's chalk mark is absent from its head.",
                         at: "c7_warehouse", x: 0.16, y: 0.62),
            EvidenceItem("c7e8", "Night Gate Ledger",
                         "The night box ledger: the yard key was issued once after chaining - 'Mr. Mott, 8.52, returned 9.41' - in the night-man's round hand.",
                         at: "c7_tally", x: 0.78, y: 0.44),
            EvidenceItem("c7e9", "Grebe's Beat Card",
                         "The constable's round card. Every box punched on time - save the ten o'clock, stamped a full hour late.",
                         at: "c7_dock", x: 0.84, y: 0.56),
            EvidenceItem("c7e10", "Mission Crate Bill",
                         "A carrier's bill nailed to a charity crate: 'Lamplighters' Benevolent League - twelve crates, tracts and tinned soup. Carriage paid, Mr. Quill, secretary.'",
                         at: "c7_warehouse", x: 0.55, y: 0.30)
        ]

        let contradictions = [
            Contradiction("c7x1", .statement("c7s03"), .evidence("c7e8"),
                          "The Counting House Alibi",
                          "Mott swears he kept to his counting house all evening - yet the night ledger shows him drawing the yard key at eight fifty-two and keeping it three-quarters of an hour."),
            Contradiction("c7x2", .statement("c7s01"), .evidence("c7e1"),
                          "The River That Wasn't",
                          "Mott would have Tull a drunkard taken by the Thames - but the surgeon found fresh, clean water in the lungs. Tull drowned somewhere the river never reaches."),
            Contradiction("c7x3", .statement("c7s05"), .evidence("c7e6"),
                          "Never Near the Barrels",
                          "Mott admits crossing the yard but 'never near the rain barrels' - while his own monogrammed cufflink lay trodden in the mud a stride from them."),
            Contradiction("c7x4", .statement("c7s02"), .evidence("c7e2"),
                          "Manifests That Balance",
                          "Mott boasts his manifests balance to the last cask - yet the week's sheet shows 'brandy' scraped out and 'lamp oil' written over, in his own signing hand."),
            Contradiction("c7x5", .statement("c7s21"), .evidence("c7e7"),
                          "The Rod That Never Lied",
                          "Pinch swears every cask passed his rod - but a duty-row cask weeping brandy carries no gauger's chalk at all. He measured only what Mott carried to his bench."),
            Contradiction("c7x6", .statement("c7s17"), .evidence("c7e9"),
                          "The Full Beat",
                          "Grebe claims every round walked on time - his own card stamps the ten o'clock box a full hour late, leaving the tally yard dark and unwatched."),
            Contradiction("c7x7", .statement("c7s01"), .statement("c7s12"),
                          "Sober as a Magistrate",
                          "Mott paints Tull drunk on the dock edge - but Birdie Hale served him supper at half past eight and watched him walk off sober, book under his arm."),
            Contradiction("c7x8", .statement("c7s06"), .evidence("c7e5"),
                          "An Old Man's Sums",
                          "Mott sneers that nothing was ever short on his wharf - while a page of Tull's tally, counting forty casks wrong, lies half-burnt in Mott's own warehouse stove.")
        ]

        return GameCase(
            id: 7, act: 2,
            title: "The Half Tide Cargo",
            subtitle: "A drowning at Blackwall Stairs",
            brief: "Ezra Tull, gang-master of Blackwall Stairs, was pulled from the dock steps at low water - and the police surgeon says the river never touched his lungs. Tull had spent his last week counting casks and saying little. The wharfinger calls it drink; the gang calls it murder. Forty casks of something are unaccounted for, and the wharf gates were chained all night.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To bury the manifest fraud",
                "A quarrel over wages",
                "Rivalry for the gang-master's post",
                "To collect a private debt",
                "Drink and a sudden temper"
            ],
            solution: CaseSolution(
                culpritId: "c7_mott",
                motive: "To bury the manifest fraud",
                keyEvidenceId: "c7e5",
                reveal: "Forty casks of brandy crossed the wharf dressed as lamp oil, and Silas Mott pocketed the duty on every one. Ezra Tull counted them - twice - and meant to carry his page to the customs men on Saturday. So on Friday night Mott drew the yard key, met Tull by the tally house, and held the old man's head in a rain barrel until the counting stopped, then rolled him off the dock steps for the tide to explain. The torn page curled in his stove ash instead of burning. Mott will keep no more manifests; the Crown keeps him now."
            )
        )
    }
}
