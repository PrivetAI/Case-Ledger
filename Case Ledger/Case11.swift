import Foundation

/// Act III, Case 11 — The Nine O'Clock Goods.
enum Case11 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c11_gorse", name: "Silas Gorse", role: "Yard ganger",
                    bio: "Bosses the shunting gangs at the Nine Elms goods yard. Took over Jonas Tarn's old crews - and, some whisper, Tarn's old errands.",
                    portrait: PortraitSpec(skin: 1, hair: .cropped, hairColor: 0, facial: .fullBeard,
                                           hat: .flatCap, collar: .uniform, coat: 1)),
            Suspect(id: "c11_hewitt", name: "Daniel Hewitt", role: "Brakeman",
                    bio: "Rode the nine o'clock goods that night. Eleven years on the footplate side and a record clean as a whistle.",
                    portrait: PortraitSpec(skin: 0, hair: .side, hairColor: 1, facial: .moustache,
                                           hat: .flatCap, collar: .uniform, coat: 3)),
            Suspect(id: "c11_sligo", name: "Mary Sligo", role: "Crossing keeper",
                    bio: "Keeps the foot crossing at the yard's north end and a kettle that never cools. Counts the trains the way other women count stitches.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 3, facial: .none,
                                           hat: .none, collar: .shawl, coat: 1, feminine: true)),
            Suspect(id: "c11_fairlie", name: "Inspector Webb Fairlie", role: "Railway police",
                    bio: "The company's own inspector, first official on the scene. Wrote 'misadventure' in his notebook before the body was cold.",
                    portrait: PortraitSpec(skin: 0, hair: .cropped, hairColor: 1, facial: .sideburns,
                                           hat: .bowler, collar: .uniform, coat: 3)),
            Suspect(id: "c11_dimity", name: "Miss Honor Dimity", role: "League bookkeeper",
                    bio: "The Crown's other witness in the League affair. Has not slept at her own lodgings since the inquest was announced, and will not say where she does.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 1, facial: .none,
                                           hat: .none, eyewear: .pinceNez, collar: .lace, coat: 6, feminine: true)),
            Suspect(id: "c11_vane", name: "Mr. Septimus Vane", role: "Patron of the League",
                    bio: "Bore his secretary's disgrace 'with sorrow,' the papers said, and his secretary's death with flowers. Sixteen years, Detective - his own right hand.",
                    portrait: PortraitSpec(skin: 0, hair: .wave, hairColor: 3, facial: .none,
                                           hat: .topHat, eyewear: .monocle, collar: .cravat, coat: 4))
        ]

        let statements = [
            // Silas Gorse
            CaseStatement("c11s01", "c11_gorse",
                          "A trespasser on the metals after dark, and the nine o'clock goods on time. That's the whole sad story, Detective. The yard eats a drunk or two every winter."),
            CaseStatement("c11s02", "c11_gorse",
                          "I was at the south cabin from eight till ten, working the shunt list with my gang. Twelve men will say so - my twelve."),
            CaseStatement("c11s03", "c11_gorse",
                          "Never heard of any Mr. Quill. Gentlemen in cravats don't call on shunting gangers."),
            CaseStatement("c11s04", "c11_gorse",
                          "My brazier burns waste sleeper-wood and my supper, nothing else. Rake it if you fancy cinders."),
            CaseStatement("c11s05", "c11_gorse",
                          "Jonas Tarn's errands? Tarn shovelled coal and minded doors. Whatever he's saying from his cell to sweeten his sentence, it's a frightened man's tale."),
            CaseStatement("c11s06", "c11_gorse",
                          "All right - the gentleman came to the yard gate once, in October. Wanted a 'steady man for night work,' he said, and left a half-sovereign for listening. I took the coin and did no work. Taking ain't doing, Detective.",
                          unlock: .contradiction("c11x3")),
            CaseStatement("c11s07", "c11_gorse",
                          "You found the papers, then. I was told to burn what he carried and I burned it - that's all I'll own. The man was on the rails when the goods came through. Prove different.",
                          unlock: .contradiction("c11x5")),

            // Daniel Hewitt
            CaseStatement("c11s08", "c11_hewitt",
                          "We came through the north yard at nine sharp, twenty wagons. I was on the brake van. There was no man on the metals, Detective - I'd stake my ticket on it. The lamps were good and the road was clear."),
            CaseStatement("c11s09", "c11_hewitt",
                          "No jolt, no cry, nothing under the wheels. You feel a fouled rail in your boots on the brake van. We felt sleepers and nothing else, the whole length of the yard."),
            CaseStatement("c11s10", "c11_hewitt",
                          "The body was found beside the down line, not on it. Eleven years, and I've seen what the wheels leave. They don't leave that."),
            CaseStatement("c11s11", "c11_hewitt",
                          "Inspector Fairlie had my statement off me in five minutes and bid me sign it shorter than I spoke it. The bit about no jolt - that bit's not in what I signed."),

            // Mary Sligo
            CaseStatement("c11s12", "c11_sligo",
                          "The gentleman crossed at my gate at half past eight, walking fast, looking behind him twice. He asked was the south cabin path lit. I said it was, and God forgive me for saying it."),
            CaseStatement("c11s13", "c11_sligo",
                          "Behind him, five minutes after, came a big man off the waste ground - not by my crossing, over the fence by the lamp hut. Gangers cross where they please."),
            CaseStatement("c11s14", "c11_sligo",
                          "The nine o'clock goods passed me at eight fifty-eight. I log every train; my book is my Bible. Whatever happened to that poor soul happened before nine, for I heard a cry at quarter to and told myself it was cats."),
            CaseStatement("c11s15", "c11_sligo",
                          "Mr. Gorse came to my hut at ten with two of his men, very kind, to ask had I seen 'a trespassing drunkard.' I had my book open on the table and he read it upside down the whole time he talked."),

            // Inspector Fairlie
            CaseStatement("c11s16", "c11_fairlie",
                          "Misadventure, plainly. A disgraced clerk, fleeing his bail, crosses a working yard at night. The company sees a dozen such deaths a year and I have written a dozen such reports."),
            CaseStatement("c11s17", "c11_fairlie",
                          "The body lay by the down line with the injuries you would expect. I ordered it moved to the lamp hut before the frost took it. Procedure, Detective."),
            CaseStatement("c11s18", "c11_fairlie",
                          "I took the brakeman's statement myself. It says what it needs to say. Brakemen feel what they expect to feel; eleven years breeds confidence, not accuracy."),
            CaseStatement("c11s19", "c11_fairlie",
                          "The dead man carried nothing - no papers, no pocket-book. Bailed men sell their papers, Detective. It bought his gin, no doubt."),
            CaseStatement("c11s20", "c11_fairlie",
                          "The company values a quiet yard, and the company's chairman dines where philanthropists dine. If my report was swift, it was because swiftness was... encouraged. I withdraw nothing - but I wrote it before I saw the rails, and you may make of that what you must.",
                          unlock: .contradiction("c11x7")),

            // Miss Dimity
            CaseStatement("c11s21", "c11_dimity",
                          "Mr. Quill turned Queen's evidence on Tuesday. He told the Treasury solicitor he could name the hand above his own - and produce its writing. Friday he was dead on a railway."),
            CaseStatement("c11s22", "c11_dimity",
                          "He wrote to me Wednesday - me, whom he called a muddled spinster - saying: 'Keep your copies close, Miss D. Mine are my life, and lodged where only my mother would think to look.' His mother is ten years dead, Detective."),
            CaseStatement("c11s23", "c11_dimity",
                          "Quill's lodging was searched before the police ever sealed it. Neatly, drawers eased not forced - but his landlady says the searcher left the attic alone. The stair to it groans like the Last Judgment, and nothing groaned."),
            CaseStatement("c11s24", "c11_dimity",
                          "His mother kept her Bible-money under the hearthstone, he told me once, laughing at the old ways. Where only his mother would think to look, Detective. Lift the attic hearth.",
                          unlock: .evidence("c11e6")),

            // Mr. Vane
            CaseStatement("c11s25", "c11_vane",
                          "Poor Erasmus. I bore his betrayal of the League with sorrow, and I bear his death with grief. Whatever he did, he was sixteen years at my side. The wreath was the least of what I owed him."),
            CaseStatement("c11s26", "c11_vane",
                          "They tell me he was to give evidence - against me, conceivably! And yet I mourn him. That, Detective, is the difference between us and our accusers: we forgive."),
            CaseStatement("c11s27", "c11_vane",
                          "On Friday evening I addressed the Mansion House banquet on the housing of the poor. Four hundred guests, the Lord Mayor at my elbow. I am perhaps the only man in London whose alibi has a printed seating plan."),
            CaseStatement("c11s28", "c11_vane",
                          "A ganger, a brazier, a half-sovereign - how sordid your theories are. Mine is simpler: a broken man wandered onto the rails. Despair, Detective, is the one murderer you cannot commit for trial."),
            CaseStatement("c11s29", "c11_vane",
                          "You have been diligent, and diligence should be fed. Come to Highgate on Thursday - dine with me, and let us speak of your future. The Yard pays so poorly, and the League... the League is generous to its friends."),
            CaseStatement("c11s30", "c11_vane",
                          "No? A pity. Then a last kindness, freely given: whatever paper you imagine poor Erasmus hid, consider - a prudent man would have found it by now. And I have never once in my life been called imprudent.")
        ]

        let locations = [
            CaseLocation("c11_yard", "Nine Elms Goods Yard",
                         "Wet rails under gas lamps, the south cabin's glow, and a ganger's brazier still warm at the fence line.",
                         scene: .trainYard),
            CaseLocation("c11_alley", "Pelham Court",
                         "The alley behind Quill's lodging house, where the dustbins stand and the back gate's bolt hangs newly broken.",
                         scene: .alley),
            CaseLocation("c11_attic", "Quill's Attic Room",
                         "A clerk's neat poverty under the slates: a truckle bed, a shaving glass, and a hearth no fire has touched in years.",
                         scene: .attic)
        ]

        let evidence = [
            EvidenceItem("c11e1", "The Clean Rails",
                         "The police surgeon against the yard plan: the injuries are a bludgeon's, not a wheel's - and the down line where the body lay shows no blood on rail, sleeper, or ballast. He died somewhere else, and quietly.",
                         at: "c11_yard", x: 0.34, y: 0.72),
            EvidenceItem("c11e2", "Drag Furrows",
                         "Two heel-furrows in the cinders, fence to down line, swept over with a sack but plain under a lamp held low. The body came to the rails feet first and face up.",
                         at: "c11_yard", x: 0.58, y: 0.80),
            EvidenceItem("c11e3", "Stopped Watch",
                         "Quill's watch, smashed in his waistcoat: stopped at 8.44. The nine o'clock goods passed the crossing at 8.58. The dead do not wait fourteen minutes to be run over.",
                         at: "c11_yard", x: 0.78, y: 0.56),
            EvidenceItem("c11e4", "Brazier Cinders",
                         "Raked from Gorse's brazier: the charred corner of a legal deposition, the printed heading still legible - 'IN THE MATTER OF THE LAMPLIGHTERS' BENEVOLENT...' - and the wire clasp of a pocket-book among the ash.",
                         at: "c11_yard", x: 0.16, y: 0.62),
            EvidenceItem("c11e5", "Broken Back-Gate Bolt",
                         "Pelham Court's gate bolt, snapped by a shoulder, splinters fresh. Beside it in the mud, half a heel print with a ganger's segged boot pattern - the same seg pattern the yard issues its men.",
                         at: "c11_alley", x: 0.42, y: 0.76),
            EvidenceItem("c11e6", "The Hearthstone Cache",
                         "Under the attic hearthstone, dry in oilcloth: Quill's true copies. Payments in his hand - Croom's envelopes, Tarn's sovereign, Lydgate's 'arrangement' - each entry initialled for approval with a small drawn lamp.",
                         at: "c11_attic", x: 0.50, y: 0.70),
            EvidenceItem("c11e7", "Lure Note",
                         "Still in Quill's coat lining, missed by whoever emptied his pockets: 'South cabin path, half past eight. Bring everything. All is arranged for Calais. - A friend who remembers sixteen years.'",
                         at: "c11_alley", x: 0.70, y: 0.50),
            EvidenceItem("c11e8", "Pay Packet",
                         "Tucked in the lamp hut's tool chest under Gorse's spare coat: a wage envelope, no employer's stamp, five sovereigns - a month of a ganger's pay - and the flap initialled with a tiny inked lamp.",
                         at: "c11_yard", x: 0.88, y: 0.38),
            EvidenceItem("c11e9", "Crossing Log",
                         "Mary Sligo's book, ruled and exact: 'Gent. crossed 8.31, asked after sth. cabin path. Big man over fence by lamp hut 8.36. Goods through 8.58.' A cry at 8.45 is entered and crossed out, with 'cats' written after - and re-entered beneath, underlined, after midnight.",
                         at: "c11_alley", x: 0.20, y: 0.40),
            EvidenceItem("c11e10", "Eased Drawers",
                         "Quill's room: every drawer searched with gloved patience, the bed unstitched, the floor sounded - except the attic stair and hearth, untouched. The searcher knew the lodging, but not the mother's ways.",
                         at: "c11_attic", x: 0.26, y: 0.46)
        ]

        let contradictions = [
            Contradiction("c11x1", .statement("c11s01"), .evidence("c11e1"),
                          "What the Wheels Leave",
                          "Gorse offers the yard's old story - a trespasser under the goods train - but the surgeon found a bludgeon's work, and the down line under the body never took a drop of blood."),
            Contradiction("c11x2", .statement("c11s01"), .evidence("c11e3"),
                          "Fourteen Silent Minutes",
                          "Run down by the nine o'clock goods, says Gorse - while Quill's smashed watch stopped at 8.44, fourteen minutes before the goods ever reached the yard."),
            Contradiction("c11x3", .statement("c11s03"), .statement("c11s12"),
                          "Gentlemen and Gangers",
                          "Gorse never heard of Quill - yet the crossing keeper watched the gentleman ask his way to the south cabin path, and five minutes later watched a big man come over the fence behind him."),
            Contradiction("c11x4", .statement("c11s02"), .evidence("c11e9"),
                          "Twelve Men at the Cabin",
                          "At the south cabin from eight till ten, swear Gorse's twelve - but Sligo's exact book has the big man over the fence by the lamp hut at 8.36, and a cry at quarter to that she wrote, crossed out, and after midnight wrote again."),
            Contradiction("c11x5", .statement("c11s04"), .evidence("c11e4"),
                          "Sleeper-Wood and Supper",
                          "Gorse's brazier burns nothing but waste wood, he says - and its ash held the charred heading of a Crown deposition and the wire clasp of a pocket-book."),
            Contradiction("c11x6", .statement("c11s19"), .evidence("c11e7"),
                          "A Man Who Carried Nothing",
                          "Fairlie reports the dead man carried no papers at all - but Quill's coat lining still held the note that lured him: 'Bring everything. All is arranged for Calais.'"),
            Contradiction("c11x7", .statement("c11s16"), .statement("c11s11"),
                          "A Dozen Such Reports",
                          "Misadventure, plainly, writes Fairlie - having trimmed from the brakeman's statement the one fact that ruins it: twenty wagons passed and no man felt anything under the wheels."),
            Contradiction("c11x8", .statement("c11s30"), .evidence("c11e10"),
                          "A Prudent Man Would Have Found It",
                          "Vane purrs that any hidden paper 'would have been found by now' - and Quill's room was indeed searched with gloved patience before the police came. Only a man who ordered the search could be so sure of its thoroughness.")
        ]

        return GameCase(
            id: 11, act: 3,
            title: "The Nine O'Clock Goods",
            subtitle: "A witness dies at Nine Elms",
            brief: "Erasmus Quill turned Queen's evidence on Tuesday, promising the Treasury solicitor the name above his own and the writing to prove it. On Friday night he was found dead beside the down line at Nine Elms goods yard, and the railway's own inspector had written 'misadventure' by morning. The brakeman felt nothing under his wheels. The crossing keeper heard a cry a quarter hour before the train. And somewhere, Quill's insurance - the papers he swore were his life - waits where only his dead mother would think to look.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "Paid to silence the witness",
                "A robbery gone to murder",
                "An old grudge from the yards",
                "To protect Inspector Fairlie",
                "Despair and misadventure"
            ],
            solution: CaseSolution(
                culpritId: "c11_gorse",
                motive: "Paid to silence the witness",
                keyEvidenceId: "c11e4",
                reveal: "The lure note promised Calais and signed itself a friend of sixteen years; Quill, who knew that hand better than any man living, came to the south cabin path carrying everything. Silas Gorse came over the fence behind him at 8.36, and at 8.44 the watch stopped. He dragged the body to the down line for the nine o'clock goods to sign his work, burned the deposition in his brazier, and was paid a month's wages in an envelope initialled with a little drawn lamp. But Quill's true copies slept under his mother's hearthstone - and every page is initialled with the same small lamp. Gorse hangs for the hands. The next warrant, Detective, is for the hand that drew."
            )
        )
    }
}
