import Foundation

/// Act II, Case 8 — The Quiet Ward.
enum Case08 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c8_frost", name: "Abel Frost", role: "Hospital dispenser",
                    bio: "Mixes every draught and powder St. Olave's gives out. Precise, soft-spoken, and lately very well dressed for nine shillings a week.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 1, facial: .none,
                                           hat: .none, eyewear: .spectacles, collar: .highCollar, coat: 0)),
            Suspect(id: "c8_thorne", name: "Sister Agnes Thorne", role: "Ward sister",
                    bio: "Rules Ward Six with a level voice and a pocket watch. Twenty years of night rounds; nothing on her ward moves unremarked.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 3, facial: .none,
                                           hat: .nurseCap, collar: .apron, coat: 6, feminine: true)),
            Suspect(id: "c8_gulliver", name: "Dr. Hugh Gulliver", role: "House surgeon",
                    bio: "Brilliant, exhausted, and in debt to his tailor, his college, and possibly his bookmaker.",
                    portrait: PortraitSpec(skin: 1, hair: .wave, hairColor: 0, facial: .none,
                                           hat: .none, collar: .cravat, coat: 3)),
            Suspect(id: "c8_perch", name: "Mr. Theodore Perch", role: "League visitor",
                    bio: "Visiting secretary of the Lamplighters' Benevolent League, which endowed Ward Six. Counts the League's pennies as though they were his own.",
                    portrait: PortraitSpec(skin: 0, hair: .side, hairColor: 2, facial: .moustache,
                                           hat: .bowler, collar: .highCollar, coat: 7)),
            Suspect(id: "c8_maddox", name: "Mrs. Eliza Maddox", role: "Laundress",
                    bio: "Boils the ward linen and carries every rumour in the building along with the baskets.",
                    portrait: PortraitSpec(skin: 2, hair: .bun, hairColor: 0, facial: .none,
                                           hat: .none, collar: .apron, coat: 1, feminine: true)),
            Suspect(id: "c8_ivo", name: "Ivo Skerry", role: "Ward boy",
                    bio: "Runs trays, bottles, and messages for a penny and his keep. Sees everything at knee height and forgets none of it.",
                    portrait: PortraitSpec(skin: 1, hair: .curly, hairColor: 0, facial: .none,
                                           hat: .flatCap, collar: .uniform, coat: 2))
        ]

        let statements = [
            // Abel Frost
            CaseStatement("c8s01", "c8_frost",
                          "Mr. Caudle's heart tonic left my bench correct to the minim. I measure for the dead man's inquest as I measure for the living, Detective."),
            CaseStatement("c8s02", "c8_frost",
                          "The dispensary books are in perfect order. Every grain bought is a grain given. You may carry them off tonight if it pleases you."),
            CaseStatement("c8s03", "c8_frost",
                          "I never left the dispensary between supper and the alarm. The sliding hatch was shut; I serve no one after eight."),
            CaseStatement("c8s04", "c8_frost",
                          "My tailoring amuses you? An aunt in Margate died last spring. Modest comfort, honestly come by."),
            CaseStatement("c8s05", "c8_frost",
                          "Mr. Caudle and I were on the best of terms. His quarterly account was a formality - the almoner counts blankets, not grains."),
            CaseStatement("c8s06", "c8_frost",
                          "So the hatch was open. A dispenser may take air. I passed along the ward corridor once, to stretch my back, and touched nothing and no one.",
                          unlock: .contradiction("c8x1")),
            CaseStatement("c8s07", "c8_frost",
                          "Invoices are delivered figures, Detective, not gospel. If Hooper's billed the League for full strength and the wards drew thin, the error is Hooper's. I mix what I am given.",
                          unlock: .contradiction("c8x4")),

            // Sister Thorne
            CaseStatement("c8s08", "c8_thorne",
                          "Mr. Caudle took his tonic at nine, as every night, and was reading his ledgers at half past. By ten he was past helping. I have nursed digitalis cases; I know what I watched."),
            CaseStatement("c8s09", "c8_thorne",
                          "The tonic bottle came up from the dispensary hatch at a quarter to nine. Ivo carried it, as he always does, straight down the corridor."),
            CaseStatement("c8s10", "c8_thorne",
                          "For a month the ward's draughts have run weak. Men who should sleep on my night mixture lie counting the ceiling cracks. I reported it to Mr. Caudle, in writing, on Tuesday."),
            CaseStatement("c8s11", "c8_thorne",
                          "Dr. Gulliver was at cards in the surgeons' room from eight, with two colleagues who will say so under oath - and lose as much as he did."),
            CaseStatement("c8s12", "c8_thorne",
                          "Mr. Perch walks my ward as though he had bought it. On Thursday I found him at the medicine press, 'taking an inventory.' I took the keys from the lock and wished him good evening."),

            // Dr. Gulliver
            CaseStatement("c8s13", "c8_gulliver",
                          "Digitalis, no question - the pulse told it before he died and the post-mortem after. Three times any dose I would write, in a man with a sound heart who was prescribed none."),
            CaseStatement("c8s14", "c8_gulliver",
                          "Yes, I owe money - half the surgeons in London owe money. One does not poison the almoner over a tailor's bill; the almoner does not hold the purse, the board does."),
            CaseStatement("c8s15", "c8_gulliver",
                          "Caudle stopped me on the stair Wednesday. He asked - oddly, I thought - whether a medicine could be thinned and still pass a taster. I told him a layman would never know."),
            CaseStatement("c8s16", "c8_gulliver",
                          "The dispensary's digitalis jar should hold a winter's supply. Have someone weigh it against the purchase book. I would do it myself, but you would call it meddling."),

            // Mr. Perch
            CaseStatement("c8s17", "c8_perch",
                          "The League endowed this ward to the sum of nine hundred pounds a year. I visit to see the League is not robbed. Evidently I visited too seldom."),
            CaseStatement("c8s18", "c8_perch",
                          "Mr. Caudle wrote to our office last week requesting the League's medicine invoices for the quarter. I brought them Thursday with my own hands."),
            CaseStatement("c8s19", "c8_perch",
                          "Our patron takes a personal interest in Ward Six. Mr. Septimus Vane reads every visitor's report I file. You may imagine I file them carefully."),
            CaseStatement("c8s20", "c8_perch",
                          "I was at the medicine press merely to count bottles against the invoice. Sister Thorne mistook diligence for trespass. The count, you will note, I never finished."),
            CaseStatement("c8s21", "c8_perch",
                          "Find the invoices, Detective. Caudle locked them in his study Thursday evening and told me: 'Mr. Perch, by Saturday I shall have a name for you.'",
                          unlock: .evidence("c8e2")),

            // Mrs. Maddox
            CaseStatement("c8s22", "c8_maddox",
                          "Mr. Frost has a new greatcoat with an astrakhan collar. Nine shillings a week, and astrakhan. The laundry notices collars, Detective."),
            CaseStatement("c8s23", "c8_maddox",
                          "Tuesday week I carried linen past the dispensary at dusk and a carrier's man was loading hampers out the area door. Medicine hampers, marked for a chemist's in Shoreditch."),
            CaseStatement("c8s24", "c8_maddox",
                          "Poor Mr. Caudle asked me Thursday who did the dispensary's carrying. I told him: no carrier of ours, sir, the hospital van is brown and this was a green one."),
            CaseStatement("c8s25", "c8_maddox",
                          "Sister Thorne never left the ward floor after eight. I had her mending basket by the stove and she sat to it between rounds, where I could see her."),

            // Ivo Skerry
            CaseStatement("c8s26", "c8_ivo",
                          "I fetched the tonic from the hatch at quarter to nine, same as always, and carried it straight to Sister. Nobody touched it on the way - I'd swear on my mother."),
            CaseStatement("c8s27", "c8_ivo",
                          "Mr. Frost's hatch was open at half eight, sir, and no Mr. Frost behind it. I waited and whistled and waited, and he came back along the ward corridor, from the study end, wiping his hands."),
            CaseStatement("c8s28", "c8_ivo",
                          "Mr. Caudle's study door has a squeak like a cat. I heard the cat twice that evening - once before I fetched the tonic, once after."),
            CaseStatement("c8s29", "c8_ivo",
                          "Mr. Frost gives me a sixpence sometimes to carry parcels to the green van. Little parcels, heavy, paper-wrapped. I never asked what, sir. Sixpence is sixpence.",
                          unlock: .evidence("c8e6")),
            CaseStatement("c8s30", "c8_ivo",
                          "The night Mr. Caudle died, Mr. Frost called me to the hatch at nine sharp - bade me scrub the dumb-waiter shelf with carbolic, 'for the inspectors.' We've never once scrubbed it before.")
        ]

        let locations = [
            CaseLocation("c8_ward", "Ward Six",
                         "Two rows of iron beds beneath the League's brass dedication plate, and the medicine press at the far wall.",
                         scene: .hospitalWard),
            CaseLocation("c8_study", "The Almoner's Study",
                         "Mr. Caudle's narrow office: ledgers, a locked drawer forced open, and a cold cup of tonic.",
                         scene: .study),
            CaseLocation("c8_kitchen", "Hospital Kitchen",
                         "Steam, copper pots, and the area door where the carriers come - watched all day by whoever stirs the soup.",
                         scene: .kitchen)
        ]

        let evidence = [
            EvidenceItem("c8e1", "Tonic Cup Residue",
                         "Mr. Caudle's last cup. The analyst's slip pinned beneath: 'digitalis tincture, gross excess - far beyond any dispensed strength.'",
                         at: "c8_study", x: 0.30, y: 0.62),
            EvidenceItem("c8e2", "Forced Drawer",
                         "The study's locked drawer, splintered open. Caudle's quarterly papers remain - but the League's medicine invoices he locked away on Thursday are gone.",
                         at: "c8_study", x: 0.68, y: 0.70),
            EvidenceItem("c8e3", "Dispensary Day-Book",
                         "Frost's issue book, immaculate - yet page after page shows night draughts issued at two-thirds the grains the prescriptions order. The thinning began in March.",
                         at: "c8_ward", x: 0.80, y: 0.55),
            EvidenceItem("c8e4", "Hooper's Invoice Copy",
                         "A supplier's copy, obtained from Hooper and Sons directly: full-strength tinctures billed to the League monthly - including digitalis enough for three winters.",
                         at: "c8_kitchen", x: 0.20, y: 0.40),
            EvidenceItem("c8e5", "Sister's Report",
                         "Sister Thorne's Tuesday memorandum to Caudle: 'The night draughts no longer answer. Either the prescriptions err, or the medicines do. I request the dispensary be examined.'",
                         at: "c8_ward", x: 0.34, y: 0.36),
            EvidenceItem("c8e6", "Green Van Waybill",
                         "Crumpled behind the kitchen area door: a waybill for 'sundries, paper-wrapped' to Marsh's Chemist, Shoreditch - eleven runs since March, collection signed each time 'A.F.'",
                         at: "c8_kitchen", x: 0.74, y: 0.68),
            EvidenceItem("c8e7", "Astrakhan Greatcoat",
                         "Frost's fine new coat on the dispensary peg. In the lining pocket, a tailor's receipt for eight guineas - paid in coin, six weeks past.",
                         at: "c8_ward", x: 0.12, y: 0.60),
            EvidenceItem("c8e8", "Digitalis Jar",
                         "The dispensary's stock jar, weighed against the purchase book: short by months of supply - yet Caudle's cup held a gross excess. The missing tincture went somewhere, and some of it came back at once.",
                         at: "c8_study", x: 0.84, y: 0.38),
            EvidenceItem("c8e9", "Carbolic-Scrubbed Shelf",
                         "The dumb-waiter shelf between dispensary and ward corridor, reeking of fresh carbolic - scrubbed, on Frost's order, within the hour of Caudle's collapse.",
                         at: "c8_ward", x: 0.55, y: 0.74),
            EvidenceItem("c8e10", "Margate Letter",
                         "In the coat's other pocket, a letter from a Margate solicitor, dated April: 'Regretfully, your late aunt's estate is consumed entirely by her debts. Nothing passes to you.'",
                         at: "c8_kitchen", x: 0.48, y: 0.30)
        ]

        let contradictions = [
            Contradiction("c8x1", .statement("c8s03"), .statement("c8s27"),
                          "The Shut Hatch",
                          "Frost swears he never left the dispensary and the hatch stayed shut after eight - yet Ivo found the hatch open at half past, the bench empty, and Frost returning along the corridor from the study end."),
            Contradiction("c8x2", .statement("c8s05"), .statement("c8s21"),
                          "A Mere Formality",
                          "Frost calls Caudle's review a formality about blankets - but Caudle had demanded the League's medicine invoices and promised Perch a name by Saturday."),
            Contradiction("c8x3", .statement("c8s02"), .evidence("c8e3"),
                          "Books in Perfect Order",
                          "Frost offers his books as proof of honesty - and they are immaculate, recording in his own hand night draughts issued at two-thirds the prescribed grains since March."),
            Contradiction("c8x4", .statement("c8s01"), .evidence("c8e1"),
                          "Correct to the Minim",
                          "Frost states the tonic left his bench correct to the minim - the analyst found digitalis in gross excess in the very cup."),
            Contradiction("c8x5", .statement("c8s04"), .evidence("c8e10"),
                          "The Margate Aunt",
                          "Frost's comfort came from a dead aunt, he says - whose solicitor wrote in April that her estate was eaten by debts and nothing passed to him at all."),
            Contradiction("c8x6", .statement("c8s02"), .evidence("c8e8"),
                          "A Grain Bought, a Grain Given",
                          "Every grain bought is a grain given, says Frost - but the digitalis jar weighs months short against the purchase book, and Caudle's cup got the difference."),
            Contradiction("c8x7", .statement("c8s03"), .evidence("c8e9"),
                          "Nothing Touched, Nothing Moved",
                          "Frost claims he served no one and touched nothing after eight - then within the hour of the collapse had the dumb-waiter shelf scrubbed with carbolic 'for the inspectors.'"),
            Contradiction("c8x8", .statement("c8s20"), .statement("c8s12"),
                          "Counting Bottles",
                          "Perch says he was merely counting bottles against an invoice - Sister Thorne found him with the press unlocked and no invoice in his hand, and took the keys herself.")
        ]

        return GameCase(
            id: 8, act: 2,
            title: "The Quiet Ward",
            subtitle: "Poison at St. Olave's",
            brief: "Mr. Caudle, almoner of St. Olave's Charity Hospital, died at his desk an hour after his nightly tonic - of digitalis he was never prescribed. For a month the ward's medicines have run mysteriously weak, and Caudle had begun asking for invoices. The Lamplighters' Benevolent League, which endows the ward, wants its money accounted for; the coroner wants a name. Both are waiting on you.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To hide the thinned medicines",
                "Gambling debts past bearing",
                "A grudge over a dismissal",
                "To seize the almoner's post",
                "To embarrass the League"
            ],
            solution: CaseSolution(
                culpritId: "c8_frost",
                motive: "To hide the thinned medicines",
                keyEvidenceId: "c8e6",
                reveal: "Since March, Abel Frost mixed the ward's draughts thin and sold the skimmed tinctures through a green van to a Shoreditch chemist - eleven runs, signed 'A.F.', astrakhan on nine shillings a week. Sister Thorne's complaint set Caudle counting, and by Thursday the almoner had locked away the invoices that would hang the sums around Frost's neck. So Frost forced the drawer while Ivo whistled at an empty hatch, and paid his debt to arithmetic with a tonic three times deadly. The League's wards will sleep soundly again. Frost will not."
            )
        )
    }
}
