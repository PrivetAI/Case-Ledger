import Foundation

/// Act III, Case 9 — The Subscription Press. The Lamplighter arc opens.
enum Case09 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c9_croom", name: "Walter Croom", role: "Foreman printer",
                    bio: "Runs Harker's press floor by day. A master of his trade with a sick wife, a mortgaged cottage, and keys to everything.",
                    portrait: PortraitSpec(skin: 0, hair: .cropped, hairColor: 3, facial: .walrus,
                                           hat: .flatCap, collar: .apron, coat: 1)),
            Suspect(id: "c9_harker", name: "Josiah Harker", role: "Master printer",
                    bio: "Owner of Harker and Sons, printers to half the charities in London. His name on a job has meant honesty for thirty years - until this week.",
                    portrait: PortraitSpec(skin: 0, hair: .side, hairColor: 3, facial: .fullBeard,
                                           hat: .none, eyewear: .spectacles, collar: .highCollar, coat: 5)),
            Suspect(id: "c9_spurrell", name: "Tom Spurrell", role: "Apprentice compositor",
                    bio: "Seven years bound to Harker's, quick-fingered and quicker-eyed. Sleeps in the loft above the press floor.",
                    portrait: PortraitSpec(skin: 1, hair: .curly, hairColor: 1, facial: .none,
                                           hat: .none, collar: .uniform, coat: 2)),
            Suspect(id: "c9_dimity", name: "Miss Honor Dimity", role: "League bookkeeper",
                    bio: "Keeps the subscription rolls of the Lamplighters' Benevolent League. Precise to the farthing and increasingly unable to make the farthings agree.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 1, facial: .none,
                                           hat: .none, eyewear: .pinceNez, collar: .lace, coat: 6, feminine: true)),
            Suspect(id: "c9_quill", name: "Mr. Erasmus Quill", role: "The patron's secretary",
                    bio: "Private secretary to Mr. Septimus Vane. Writes the patron's letters, pays the patron's bills, and smiles with only half his mouth.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 0, facial: .goatee,
                                           hat: .bowler, collar: .cravat, coat: 6)),
            Suspect(id: "c9_vane", name: "Mr. Septimus Vane", role: "Patron of the League",
                    bio: "Philanthropist, chairman of charities, friend of bishops. They say no lamp in Lambeth burns but Mr. Vane subscribed the oil. They say it smiling.",
                    portrait: PortraitSpec(skin: 0, hair: .wave, hairColor: 3, facial: .none,
                                           hat: .topHat, eyewear: .monocle, collar: .cravat, coat: 4))
        ]

        let statements = [
            // Walter Croom
            CaseStatement("c9s01", "c9_croom",
                          "The press floor is locked at eight and I carry the key home to Peckham. Whatever was printed here at night, it was not printed by me."),
            CaseStatement("c9s02", "c9_croom",
                          "Those false receipt books are fine work, I'll grant - too fine for an apprentice. But Harker's has no second engraver, so look outside these walls."),
            CaseStatement("c9s03", "c9_croom",
                          "My wife's doctoring is paid by the parish club, sixpence a week, all square. We manage, Detective. We have always managed."),
            CaseStatement("c9s04", "c9_croom",
                          "I burn the spoiled sheets every Friday in the yard. Ash is ash; you'll read nothing in mine."),
            CaseStatement("c9s05", "c9_croom",
                          "I never met Mr. Vane's secretary but twice, both times at the counting desk on League business, with Mr. Harker standing by."),
            CaseStatement("c9s06", "c9_croom",
                          "Aye - the ink was bought outside, cash, no ledger. A private job, I was told, a surprise subscription drive for the patron's birthday. I believed it because the pay was too good to question.",
                          unlock: .contradiction("c9x2")),
            CaseStatement("c9s07", "c9_croom",
                          "You have the note, then. I never knew his name - only the lamp he drew instead of a signature, and the envelopes of coin. A man with a sick wife stops asking who, Detective. He asks only how much.",
                          unlock: .contradiction("c9x6")),

            // Josiah Harker
            CaseStatement("c9s08", "c9_harker",
                          "Thirty years, and never a dishonest sheet off my stones. Now the League shows me receipt books with my colophon that my order book has never heard of."),
            CaseStatement("c9s09", "c9_harker",
                          "The counterfeits ran on my own Albion press - the chipped 'H' in the colophon proves it. Someone printed them under my roof, by night, on my iron."),
            CaseStatement("c9s10", "c9_harker",
                          "Croom is the best foreman in Southwark. I'd sooner suspect myself. Though I confess - he refused the night-watch rota this spring, who never refused work in his life."),
            CaseStatement("c9s11", "c9_harker",
                          "Mr. Quill ordered the League's true receipt books each January - two hundred, numbered, no more. He was most particular that the plates stay locked in my safe."),
            CaseStatement("c9s12", "c9_harker",
                          "The safe shows no forcing. But a wax press would take the key's likeness in a minute, and my key hangs in the counting house by day."),

            // Tom Spurrell
            CaseStatement("c9s13", "c9_spurrell",
                          "Three nights I heard the press working below the loft - a slow beat, one man working alone. I thought it was Mr. Harker on a rush job and kept to my blanket."),
            CaseStatement("c9s14", "c9_spurrell",
                          "The third night I crept halfway down. I saw a candle, and Mr. Croom's bald spot shining over the forme, and I went back up quiet. A 'prentice that peaches on his foreman never makes journeyman."),
            CaseStatement("c9s15", "c9_spurrell",
                          "Mr. Croom's been buying the good coal this winter, and his wife has a nurse in, Tuesdays. Press-floor wages don't stretch to nurses."),
            CaseStatement("c9s16", "c9_spurrell",
                          "A gentleman in a bowler came to the yard gate twice at dusk. Never inside - he'd stand by the lamp and Mr. Croom would go out to him. Smiled like a vicar, that one, but only the half of his face did it."),

            // Miss Dimity
            CaseStatement("c9s17", "c9_dimity",
                          "The rolls show four hundred and six subscribers. The bank shows deposits as though there were six hundred. Money is entering the League that no honest list accounts for, Detective - the forged books are not robbing the League. They are filling it."),
            CaseStatement("c9s18", "c9_dimity",
                          "I took my sums to Mr. Quill in March. He thanked me, took my working papers 'for the patron's review,' and I have not seen them since."),
            CaseStatement("c9s19", "c9_dimity",
                          "Every counterfeit receipt is numbered in the eight thousands. Our true series has never passed two hundred. Whoever chose those numbers wanted them never to collide with mine."),
            CaseStatement("c9s20", "c9_dimity",
                          "Mr. Vane reviews the accounts personally each quarter. He praises my neatness, signs the foot of every page, and asks no questions. A man who asks no questions of figures like ours is not careless. He is informed.",
                          unlock: .evidence("c9e5")),

            // Mr. Quill
            CaseStatement("c9s21", "c9_quill",
                          "The League is the victim here, Detective, and Mr. Vane desires the culprit found whatever it costs. You shall have every facility. Every door open."),
            CaseStatement("c9s22", "c9_quill",
                          "I order the League's printing each January, yes. Beyond that I know presses as I know coal mines - by their bills."),
            CaseStatement("c9s23", "c9_quill",
                          "Miss Dimity's papers? Filed at the patron's house, quite safe. Her sums were muddled - too many late subscriptions entered twice. It happens with spinster bookkeepers."),
            CaseStatement("c9s24", "c9_quill",
                          "I have never stood at Harker's yard gate in my life. I transact at counting desks, in daylight, like a Christian.",
                          unlock: .evidence("c9e8")),
            CaseStatement("c9s25", "c9_quill",
                          "You mistake errands for intrigue. If I met the foreman at dusk it was to hurry the January order, nothing more. Mr. Vane dislikes waiting - it is the only vice he permits himself.",
                          unlock: .contradiction("c9x7")),

            // Mr. Vane
            CaseStatement("c9s26", "c9_vane",
                          "Forged in my League's name! It wounds me, Detective, truly. The poor-box is sacred ground, and someone has built on it."),
            CaseStatement("c9s27", "c9_vane",
                          "Take whatever the League can give - papers, keys, my own diary if it serves. The Lamplighters hide nothing. We exist, after all, to give light."),
            CaseStatement("c9s28", "c9_vane",
                          "Mr. Quill has my entire confidence. Sixteen years, and never a farthing astray. I should as soon suspect my own right hand."),
            CaseStatement("c9s29", "c9_vane",
                          "Money entering unexplained, Miss Dimity says? Then some shy benefactor blesses us anonymously, and chose a foolish method. Generosity, Detective, is often eccentric."),
            CaseStatement("c9s30", "c9_vane",
                          "You will find your forger among small men with small debts. It is always so. The great crimes - those, I assure you, are never found at all.")
        ]

        let locations = [
            CaseLocation("c9_press", "Harker's Press Floor",
                         "The great Albion press, formes locked in their chases, and a loft overhead where an apprentice sleeps lightly.",
                         scene: .printworks),
            CaseLocation("c9_office", "League Counting Office",
                         "The Lamplighters' Benevolent League's office: subscription rolls, a banded cash box, and Miss Dimity's exact handwriting.",
                         scene: .office),
            CaseLocation("c9_shop", "Pellow's Stationers",
                         "The shop that supplies Harker's paper - and, it appears, somebody's midnight ink.",
                         scene: .shopFloor)
        ]

        let evidence = [
            EvidenceItem("c9e1", "Counterfeit Receipt Book",
                         "A League subscription receipt book, perfect to the eye - Harker colophon, League seal - numbered in the eight thousands. The true series has never passed two hundred.",
                         at: "c9_office", x: 0.30, y: 0.58),
            EvidenceItem("c9e2", "Chipped Colophon",
                         "Proof pulls from Harker's Albion press. The tiny chip in the colophon's 'H' matches the counterfeits stroke for stroke: they were printed on this iron.",
                         at: "c9_press", x: 0.50, y: 0.66),
            EvidenceItem("c9e3", "Second Plate",
                         "Wrapped in oilcloth beneath the press floor's loose board: a duplicate engraving of the League receipt plate - cut from a wax impression of the safe key's original.",
                         at: "c9_press", x: 0.22, y: 0.80),
            EvidenceItem("c9e4", "Cash Ink Purchase",
                         "Pellow's counter book: 'best double ink, 4 lb - cash - collected by W. Croom' three times since February. Harker's account, two pages on, orders its ink on credit as always.",
                         at: "c9_shop", x: 0.64, y: 0.52),
            EvidenceItem("c9e5", "Signed Quarterly Page",
                         "A League account page, deposits swollen far past the subscriber rolls - and at its foot, in confident ink: 'Examined and found correct. S. Vane.'",
                         at: "c9_office", x: 0.72, y: 0.36),
            EvidenceItem("c9e6", "Lamp-Signed Note",
                         "Half-burnt in Croom's Friday ash heap: '...final run of fifty books, then the plate goes in the river. Payment as before.' No name - only a small lamp, drawn in ink.",
                         at: "c9_press", x: 0.82, y: 0.74),
            EvidenceItem("c9e7", "Nurse's Receipts",
                         "In the foreman's coat: receipts for a private nurse, Tuesdays since February, at three and six the visit - paid always in coin, always on Saturdays.",
                         at: "c9_shop", x: 0.18, y: 0.66),
            EvidenceItem("c9e8", "Gate-Lamp Sketch",
                         "Tom Spurrell's pencil sketch, drawn from the loft window: a bowler-hatted gentleman beneath the yard lamp, half his face smiling. The likeness of Mr. Quill is unmistakable.",
                         at: "c9_press", x: 0.66, y: 0.30),
            EvidenceItem("c9e9", "Wax-Smeared Key Tag",
                         "The counting-house tag for Harker's safe key. A film of hard yellow wax clings in the ward-cuts - the key has been pressed for copying.",
                         at: "c9_shop", x: 0.44, y: 0.34),
            EvidenceItem("c9e10", "Deposit Slips",
                         "League bank slips for the unexplained deposits - paid in across six different branches, always in coin, always by 'a clerk.' Coin has no name; that was the point of the receipts.",
                         at: "c9_office", x: 0.50, y: 0.74)
        ]

        let contradictions = [
            Contradiction("c9x1", .statement("c9s01"), .statement("c9s14"),
                          "The Key in Peckham",
                          "Croom carries the only key home each night, he says - yet his apprentice crept halfway down the loft stair and watched Croom's own head bent over the forme by candlelight."),
            Contradiction("c9x2", .statement("c9s04"), .evidence("c9e6"),
                          "Ash Is Ash",
                          "Croom burns only spoiled sheets, he claims - but his Friday ash held instructions for a final run of fifty books, signed with a little drawn lamp."),
            Contradiction("c9x3", .statement("c9s03"), .evidence("c9e7"),
                          "Sixpence a Week",
                          "The parish club pays the doctoring, says Croom - while his coat carries receipts for a private nurse at three and six a visit, paid in coin every Saturday."),
            Contradiction("c9x4", .statement("c9s01"), .evidence("c9e4"),
                          "Not Printed by Me",
                          "Croom denies all knowledge of the night printing - yet Pellow's counter book shows him buying press ink for cash, three times, off the firm's account."),
            Contradiction("c9x5", .statement("c9s02"), .evidence("c9e3"),
                          "No Second Engraver",
                          "Look outside these walls for your plate, Croom advises - while the duplicate plate lay wrapped in oilcloth beneath his own press floor's loose board."),
            Contradiction("c9x6", .statement("c9s06"), .evidence("c9e3"),
                          "A Birthday Surprise",
                          "A surprise subscription drive, Croom was told, and believed - but no honest surprise requires a secretly copied safe key and a duplicate plate hidden under a floorboard."),
            Contradiction("c9x7", .statement("c9s24"), .evidence("c9e8"),
                          "Counting Desks Only",
                          "Quill has never stood at Harker's gate in his life, he swears - and the apprentice's loft-window sketch shows his half-smile under the yard lamp, twice, at dusk."),
            Contradiction("c9x8", .statement("c9s29"), .statement("c9s17"),
                          "The Shy Benefactor",
                          "Vane shrugs the excess off as an eccentric anonymous blessing - but Miss Dimity's figures show systematic deposits matched to forged receipt numbers. Eccentrics do not number their gifts in series.")
        ]

        return GameCase(
            id: 9, act: 3,
            title: "The Subscription Press",
            subtitle: "Forged charity in Southwark",
            brief: "Receipt books of the Lamplighters' Benevolent League - perfect counterfeits, printed on Harker's own press - have surfaced across London. Strangest of all, the forgeries are not draining the League's coffers but filling them: coin without donors, entering by the thousands. Mr. Septimus Vane, the League's celebrated patron, demands the forger found. Somebody is washing dirty money through the cleanest name in London, and the press ran at midnight.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "Paid coin to print in secret",
                "Revenge upon Mr. Harker",
                "To discredit the League",
                "A counterfeiter's ambition",
                "To cover gambling losses"
            ],
            solution: CaseSolution(
                culpritId: "c9_croom",
                motive: "Paid coin to print in secret",
                keyEvidenceId: "c9e6",
                reveal: "Walter Croom ran the Albion by night for envelopes of coin and a story about a patron's birthday - and kept running it after he stopped believing, because a nurse costs three and six and a sick wife costs courage. The receipts he printed turned nameless coin into pious subscriptions on the League's books. But Croom never knew his paymaster: only a half-smiling go-between at the gate, and a note signed with a small drawn lamp. The forger goes to the dock - and somewhere above him, the Lamplighter trims his wick and waits."
            )
        )
    }
}
