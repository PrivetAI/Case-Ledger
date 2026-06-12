import Foundation

/// Act I, Case 3 — The Penny Bazaar War.
enum Case03 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c3_cudlip", name: "Ezra Cudlip", role: "Rival haberdasher",
                    bio: "Keeps the stall opposite Widow Maddock's and quarrels with her weekly at full volume. The whole bazaar heard Tuesday's row.",
                    portrait: PortraitSpec(skin: 0, hair: .curly, hairColor: 1, facial: .walrus,
                                           hat: .flatCap, collar: .highCollar, coat: 5)),
            Suspect(id: "c3_ned", name: "Ned Harrow", role: "Cudlip's apprentice",
                    bio: "Fourteen, quick over a wall, and sweet on the tea-stall girl. Sleeps in the loft above Cudlip's shop - in theory.",
                    portrait: PortraitSpec(skin: 1, hair: .cropped, hairColor: 2, hat: .flatCap,
                                           collar: .apron, coat: 1)),
            Suspect(id: "c3_fenwick", name: "Mr. Fenwick", role: "Market beadle",
                    bio: "Superintendent of pitches, collector of rents, keeper of the gate and storeroom keys. The Trust trusts him; the stallholders know better.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 0, facial: .moustache,
                                           hat: .bowler, collar: .uniform, coat: 3)),
            Suspect(id: "c3_tansy", name: "Tansy Lark", role: "Tea-stall girl",
                    bio: "Sells tea and buns from the corner barrow, dawn till dusk, and notices everything that crosses the square.",
                    portrait: PortraitSpec(skin: 1, hair: .long, hairColor: 4, hat: .none,
                                           collar: .apron, coat: 7, feminine: true)),
            Suspect(id: "c3_dewey", name: "Mr. Dewey", role: "Tea merchant",
                    bio: "A prosperous newcomer with plans for a proper tea house - on the corner pitch that Widow Maddock has held for thirty years.",
                    portrait: PortraitSpec(skin: 0, hair: .side, hairColor: 3, facial: .goatee,
                                           hat: .topHat, eyewear: .monocle, collar: .cravat, coat: 4)),
            Suspect(id: "c3_grimsby", name: "Old Grimsby", role: "Night watchman",
                    bio: "Forty years watching the market gates, lately with one eye shut and the other not much better.",
                    portrait: PortraitSpec(skin: 2, hair: .bald, hairColor: 3, facial: .fullBeard,
                                           hat: .wideBrim, collar: .shawl, coat: 1))
        ]

        let statements = [
            // Cudlip
            CaseStatement("c3s01", "c3_cudlip",
                          "Aye, I called her ribbons trash at the top of my lungs on Tuesday. Quarrels at the bazaar are like weather. It don't mean I'd ruin a widow."),
            CaseStatement("c3s02", "c3_cudlip",
                          "I was at the Lamb and Flag till closing, then home to my wife. Half the taproom will swear to it - the half that was sober."),
            CaseStatement("c3s03", "c3_cudlip",
                          "My apprentice was abed in the loft by ten. I bolt the loft door myself, every night."),
            CaseStatement("c3s04", "c3_cudlip",
                          "Fenwick has raised my rent twice in a year. Where does it go? Not into the lamps - half the row stood dark all winter."),
            CaseStatement("c3s05", "c3_cudlip",
                          "If you want to ruin a stallholder you don't cut ropes, you whisper to the beadle. A word from Fenwick and you're pitched out by Lady Day."),

            // Ned
            CaseStatement("c3s06", "c3_ned",
                          "I was asleep in the loft, sir. All night. Master bolts the door, so where would I go?"),
            CaseStatement("c3s07", "c3_ned",
                          "Mrs. Maddock's given me a toffee every Friday since I was small. I'd never touch her stall, not for anything."),
            CaseStatement("c3s08", "c3_ned",
                          "All right - I went over the wall after master bolted up. But it was only to meet Tansy by the crates, and I'll thank you not to tell her father.",
                          unlock: .contradiction("c3x3")),
            CaseStatement("c3s09", "c3_ned",
                          "Past midnight there was a light in the Trust storeroom. I thought it was Grimsby's lantern - but Grimsby was snoring by the gate. I could hear him from the crates.",
                          unlock: .contradiction("c3x3")),

            // Tansy
            CaseStatement("c3s10", "c3_tansy",
                          "Mr. Dewey's been sniffing round the corner pitch for months, talking grand about a proper tea house with brass urns."),
            CaseStatement("c3s11", "c3_tansy",
                          "Me? I was home with mother by eleven, same as always."),
            CaseStatement("c3s12", "c3_tansy",
                          "Don't tell father, I beg you. I slipped out to meet Ned by the crates, and we stayed till the church struck one - and I saw Mr. Fenwick cross the alley, plain as day, with a can swinging in his hand.",
                          unlock: .contradiction("c3x5")),
            CaseStatement("c3s13", "c3_tansy",
                          "Fenwick collects more rent than he writes down - everyone knows it. You pay what he asks, or your pitch floods, your lamps fail, and your ropes fray."),

            // Fenwick
            CaseStatement("c3s14", "c3_fenwick",
                          "Vandals, plainly - rough lads off the river. The Trust will of course assist the widow. I have said so in my report already."),
            CaseStatement("c3s15", "c3_fenwick",
                          "I locked the gates at ten and went straight home. My rounds book shows it, initialed at every gate."),
            CaseStatement("c3s16", "c3_fenwick",
                          "Mrs. Maddock pays five shillings the week for that corner - the standard rate. It is all in my ledger, correct to the penny."),
            CaseStatement("c3s17", "c3_fenwick",
                          "The Trust storeroom? Only I hold the key, and nothing is missing from it. I checked the very morning after."),
            CaseStatement("c3s18", "c3_fenwick",
                          "You put a fine construction on a borrowed can and a knife every beadle carries. The widow was offered fair terms to move along. Some people will not be helped.",
                          unlock: .contradiction("c3x6")),
            CaseStatement("c3s19", "c3_fenwick",
                          "Dewey paid for a promise, yes. But promises are not crimes, Detective, and frightened widows move along on their own. Prove the rest if you can.",
                          unlock: .contradiction("c3x7")),

            // Dewey
            CaseStatement("c3s20", "c3_dewey",
                          "I am a man of commerce. My interest in the corner pitch is openly declared to the Trust, in writing."),
            CaseStatement("c3s21", "c3_dewey",
                          "My arrangement with Mr. Fenwick was a lawful application fee. Nothing more and nothing less."),
            CaseStatement("c3s22", "c3_dewey",
                          "I dined at my club until midnight; the steward keeps the book. I do not skulk in alleys, Detective. I buy what I want in daylight."),
            CaseStatement("c3s23", "c3_dewey",
                          "I told Fenwick the pitch must be vacant by Lady Day. How he managed Trust business was his affair, not mine."),

            // Grimsby
            CaseStatement("c3s24", "c3_grimsby",
                          "I watch those gates sharp as a hawk, sir. Nothing and nobody passed me that night."),
            CaseStatement("c3s25", "c3_grimsby",
                          "The gin? A bottle was left at my post with a kind label - 'compliments of a friend'. A watchman can't refuse a kindness, can he?"),
            CaseStatement("c3s26", "c3_grimsby",
                          "I woke - that is, I rose - near one, with the church bell, and did my round. The widow's stall stood right and tight then. I'd nearly swear it."),
            CaseStatement("c3s27", "c3_grimsby",
                          "Only Mr. Fenwick and I hold gate keys. No vandal came over the main gate - those spikes would keep his trousers as a souvenir.")
        ]

        let locations = [
            CaseLocation("c3_market", "The Penny Bazaar",
                         "Widow Maddock's wrecked corner stall: cut ropes, fallen awning, ribbons ruined with lamp oil.",
                         scene: .market),
            CaseLocation("c3_alley", "The Back Alley",
                         "A narrow lane behind the stalls - crates, the Trust storeroom door, and a climbable wall.",
                         scene: .alley),
            CaseLocation("c3_office", "The Beadle's Office",
                         "Fenwick's domain: the pitch ledger, the rounds book, and a locked drawer.",
                         scene: .office)
        ]

        let evidence = [
            EvidenceItem("c3e1", "Cut Awning Ropes",
                         "The awning ropes were severed in single clean strokes, each cut curling - the work of a curved blade, not a straight knife or a saw.",
                         at: "c3_market", x: 0.30, y: 0.40),
            EvidenceItem("c3e2", "Lamp-Oil Can",
                         "The can that soaked the ribbon stock, kicked under the stall boards. Stamped on the base: 'PROPERTY OF MARKET TRUST - STOREROOM'.",
                         at: "c3_market", x: 0.62, y: 0.70),
            EvidenceItem("c3e3", "The Pitch Ledger",
                         "Fenwick's ledger shows Widow Maddock at five shillings the week. But her own receipts, pinned in evidence, say seven and six - in Fenwick's hand. The difference goes somewhere.",
                         at: "c3_office", x: 0.35, y: 0.60),
            EvidenceItem("c3e4", "Dewey's Letter",
                         "In the locked drawer: 'Mr. F. - I am promised the corner pitch by Lady Day. My consideration was paid in full. See it vacant. - D.'",
                         at: "c3_office", x: 0.68, y: 0.45),
            EvidenceItem("c3e5", "The Hooked Knife",
                         "A beadle's hooked pruning knife in the office drawer - blade lately wiped, but fresh hemp fibers still cling to the curve of it.",
                         at: "c3_office", x: 0.55, y: 0.75),
            EvidenceItem("c3e6", "The Kind Bottle",
                         "An empty gin bottle behind the gate post, label written in a careful clerk's hand: 'Compliments of a friend.' Grimsby's friends do not write careful hands.",
                         at: "c3_alley", x: 0.20, y: 0.72),
            EvidenceItem("c3e7", "Scrapes on the Wall",
                         "Fresh boot scrapes up the alley wall beneath Cudlip's loft window - small boots, a light climber, down and up again.",
                         at: "c3_alley", x: 0.52, y: 0.45),
            EvidenceItem("c3e8", "Oiled Ribbon Scrap",
                         "A scrap of Maddock's ribbon, soaked in oil, snagged on the Trust storeroom door hinge - inside the lock's reach. Whoever carried the oil came and went through a door only one man can open.",
                         at: "c3_alley", x: 0.80, y: 0.60),
            EvidenceItem("c3e9", "Tansy's Note",
                         "A folded note dropped by the crates: 'After the watchman sleeps - the usual place. T.'",
                         at: "c3_alley", x: 0.38, y: 0.80)
        ]

        let contradictions = [
            Contradiction("c3x1", .statement("c3s24"), .evidence("c3e6"),
                          "The Hawk That Slept",
                          "Grimsby watched 'sharp as a hawk' - beside an emptied gift bottle of gin, labelled in a careful clerk's hand by someone who needed him sleeping."),
            Contradiction("c3x2", .statement("c3s16"), .evidence("c3e3"),
                          "Two Rents",
                          "Fenwick's ledger says the widow pays five shillings; her receipts in his own hand say seven and six. The ledger is correct to the penny - to the Trust. The rest is correct to Fenwick's pocket."),
            Contradiction("c3x3", .statement("c3s06"), .evidence("c3e7"),
                          "Over the Wall",
                          "Ned slept all night behind a bolted door - yet fresh boy-sized boot scrapes climb the alley wall beneath his loft window, down and up again."),
            Contradiction("c3x4", .statement("c3s17"), .evidence("c3e2"),
                          "The Storeroom Can",
                          "Fenwick says nothing is missing from the storeroom only he can open - while the Trust's own stamped oil can lies under the widow's ruined stall."),
            Contradiction("c3x5", .statement("c3s11"), .evidence("c3e9"),
                          "After the Watchman Sleeps",
                          "Home with mother by eleven - yet Tansy's own note arranges a meeting 'after the watchman sleeps'. She was in the alley that night, and she may have seen something."),
            Contradiction("c3x6", .statement("c3s15"), .statement("c3s12"),
                          "A Can in the Dark",
                          "Fenwick locked up at ten and went straight home, says his rounds book. Tansy watched him cross the alley near one o'clock with a can swinging in his hand."),
            Contradiction("c3x7", .statement("c3s21"), .evidence("c3e4"),
                          "The Price of a Promise",
                          "A 'lawful application fee' - described in Dewey's own letter as consideration paid in full for a pitch to be made vacant. That is not an application. That is a purchase."),
            Contradiction("c3x8", .evidence("c3e1"), .evidence("c3e5"),
                          "A Curved Cut",
                          "The awning ropes were cut by a curved blade - and the beadle's hooked knife, lately wiped, still carries fresh hemp fibers in its curve.")
        ]

        return GameCase(
            id: 3, act: 1,
            title: "The Penny Bazaar War",
            subtitle: "A stall wrecked in the night",
            brief: "Widow Maddock came to her corner stall at dawn to find the awning ropes cut and thirty years of ribbon stock drowned in lamp oil. The bazaar blames her rival Cudlip after Tuesday's shouting match - but the widow says ropes and oil are not Cudlip's way of making war, and she has held that corner too long to be frightened off it now.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To clear the pitch for a bribe",
                "Hatred after Tuesday's quarrel",
                "Drunken mischief",
                "To punish unpaid rent",
                "To raise every stall's rent"
            ],
            solution: CaseSolution(
                culpritId: "c3_fenwick",
                motive: "To clear the pitch for a bribe",
                keyEvidenceId: "c3e5",
                reveal: "Fenwick had sold the corner pitch twice over - once to the Trust's books and once to Mr. Dewey's purse. When the widow would not be 'helped' off her pitch, he put the watchman to sleep with a kindly bottle, opened his own storeroom for the oil, and cut the ropes with the hooked knife that still carries her hemp in its curve. The Trust dismisses him; Dewey's letter follows him to the magistrate; and Widow Maddock keeps her corner."
            )
        )
    }
}
