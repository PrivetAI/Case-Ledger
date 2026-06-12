import Foundation

/// Act III, Case 12 — The Lamplighter's Ledger. The finale.
enum Case12 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c12_vane", name: "Mr. Septimus Vane", role: "Patron of the League",
                    bio: "Philanthropist, trustee, mourner of his own victims. His enforcer hangs, his secretary is buried, his bankers are jailed - and he has invited the press to watch him rebuild.",
                    portrait: PortraitSpec(skin: 0, hair: .wave, hairColor: 3, facial: .none,
                                           hat: .topHat, eyewear: .monocle, collar: .cravat, coat: 4)),
            Suspect(id: "c12_marrow", name: "Sir Edwin Marrow", role: "League chairman",
                    bio: "Chairman of the Lamplighters' board: a kindly, deaf old baronet whose signature has blessed a decade of papers he never read.",
                    portrait: PortraitSpec(skin: 0, hair: .bald, hairColor: 3, facial: .fullBeard,
                                           hat: .none, eyewear: .spectacles, collar: .cravat, coat: 5)),
            Suspect(id: "c12_hesper", name: "Lady Corinthia Hesper", role: "Patroness",
                    bio: "The League's grandest subscriber and Vane's fiercest rival in public virtue. Has wanted the chairmanship - and Vane's downfall - for years.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 3, facial: .none,
                                           hat: .wideBrim, collar: .lace, coat: 6, feminine: true)),
            Suspect(id: "c12_pell", name: "Noah Pell", role: "Vane's coachman",
                    bio: "Has driven the patron's brougham for nine years and waited at every door in London. Coachmen are furniture, Detective - until they testify.",
                    portrait: PortraitSpec(skin: 1, hair: .side, hairColor: 1, facial: .sideburns,
                                           hat: .bowler, collar: .uniform, coat: 1)),
            Suspect(id: "c12_gaunt", name: "Mrs. Tabitha Gaunt", role: "The porter's widow",
                    bio: "Her husband Amos kept the League hall's door for twenty years and died behind it in the fire. She has buried him, and she is not finished.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 1, facial: .none,
                                           hat: .bonnet, collar: .shawl, coat: 0, feminine: true)),
            Suspect(id: "c12_fellgate", name: "Mr. Barnaby Fellgate", role: "Insurance assessor",
                    bio: "Assessor for the Phoenix Fire Office, which stands to pay the League twelve thousand pounds. Paid to be suspicious, and earning his wage.",
                    portrait: PortraitSpec(skin: 0, hair: .slick, hairColor: 1, facial: .moustache,
                                           hat: .bowler, eyewear: .spectacles, collar: .highCollar, coat: 3)),
            Suspect(id: "c12_dimity", name: "Miss Honor Dimity", role: "League bookkeeper",
                    bio: "The last witness standing, under Yard protection at an address even you were not told. She has brought her shadow ledgers, and she has brought them in duplicate.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 1, facial: .none,
                                           hat: .none, eyewear: .pinceNez, collar: .lace, coat: 6, feminine: true))
        ]

        let statements = [
            // Mr. Vane
            CaseStatement("c12s01", "c12_vane",
                          "My League's hall in ashes and my old porter dead in it. I returned from the opera to find the sky orange over Lambeth, Detective. I shall rebuild it in stone, and call the new door the Amos Gaunt Gate."),
            CaseStatement("c12s02", "c12_vane",
                          "I was in my box at Covent Garden from eight until the last curtain - half of fashionable London bowed to me there. My coachman drove me, waited, and drove me home. Pell will tell you; Pell remembers everything."),
            CaseStatement("c12s03", "c12_vane",
                          "The hall's records burned, yes - subscription rolls, minutes, the lot. A grief beyond money. Happily the bank holds attested copies of whatever the auditors require. Order, Detective, survives fire."),
            CaseStatement("c12s04", "c12_vane",
                          "Lady Hesper has coveted my chair for years and her carriage was seen in Lambeth that very evening. I accuse no one. I merely remember aloud."),
            CaseStatement("c12s05", "c12_vane",
                          "Poor Amos. He should have been at his supper by nine; the fire was set - if set it was - by someone who never dreamed the hall was occupied. A villain, yes, but not, I think, a murderer by intent. The distinction will matter to a jury."),
            CaseStatement("c12s06", "c12_vane",
                          "A key, a vault, a churchyard - how gothic your evidence grows. My family vault holds my family, Detective. You will need more than a sexton's gossip to open a gentleman's grave.",
                          unlock: .contradiction("c12x5")),
            CaseStatement("c12s07", "c12_vane",
                          "So. The ledger. Sixteen years of order, Detective, and it ends on a hearthstone and a widow's clock. I built forty almshouses with one hand - history would have weighed me kindly, had you not insisted on producing the scales. The lamp is yours; mind how it burns.",
                          unlock: .contradiction("c12x8")),

            // Sir Edwin Marrow
            CaseStatement("c12s08", "c12_marrow",
                          "Eh? The fire, yes, dreadful. I signed for the new insurance in the spring - Septimus brought the papers to my bedside when I had the gout. Twelve thousand, was it? He said the old policy had grown thin. He reads the small print for me, you know. Always has."),
            CaseStatement("c12s09", "c12_marrow",
                          "The board met Tuesday last. Septimus moved that all original records be 'consolidated at the hall for the auditors' convenience.' We carried it. We always carry Septimus's motions; they are so very well phrased."),
            CaseStatement("c12s10", "c12_marrow",
                          "Amos Gaunt, poor fellow, was to retire at Christmas. Septimus arranged the pension himself. He is good with the small people - knows every name, every supper hour. Remarkable memory, Septimus."),

            // Lady Hesper
            CaseStatement("c12s11", "c12_hesper",
                          "My carriage was in Lambeth, certainly - at the Mission concert until eleven, with two hundred witnesses of the dullest respectability. I wanted Vane's chair, Detective, not his bonfire. One does not burn what one hopes to inherit."),
            CaseStatement("c12s12", "c12_hesper",
                          "In March he had Sir Edwin double the hall's insurance. In October he gathered every original record under its roof. I have watched men arrange their affairs before a bankruptcy; this had the same smell, only with smoke to follow."),
            CaseStatement("c12s13", "c12_hesper",
                          "I wrote to the Charity Commissioners in September naming my suspicions. I received a courteous acknowledgment and, the following week, a wreath - a wreath, Detective, with my own monogram, and no card. I understood the sender perfectly."),
            CaseStatement("c12s14", "c12_hesper",
                          "Whatever he loved, he kept at Highgate. The man trusts no safe he cannot visit in carpet slippers. If his treasures are not in the house, they are within a short walk of it - and his family vault is a very short walk indeed."),

            // Noah Pell
            CaseStatement("c12s15", "c12_pell",
                          "I drove the master to the opera for eight, waited with the carriages, and drove him home after the last curtain. That's my statement, same as I gave his solicitor."),
            CaseStatement("c12s16", "c12_pell",
                          "Nine years I've waited at doors. You learn the length of an opera to the minute, Detective. You learn the length of everything."),
            CaseStatement("c12s17", "c12_pell",
                          "All right. At the first interval the master left his box - 'a turn for my digestion,' he says. I drove him to Lambeth, set him down by the timber yard behind the hall at half nine, and took him up again at ten. He was back bowing in his box for the last act, smelling of his cigar. And of paraffin under it - a coachman's nose is never wrong about paraffin.",
                          unlock: .contradiction("c12x1")),
            CaseStatement("c12s18", "c12_pell",
                          "Why speak now? Because Amos Gaunt held my horses a hundred nights in the rain, and the master knew his supper hour to the minute - knew it, and went in any road. There's wages a man won't take. I'm done waiting at his doors.",
                          unlock: .contradiction("c12x1")),
            CaseStatement("c12s19", "c12_pell",
                          "Sunday before the fire, I drove him to St. Alban's churchyard at Highgate with a deed box from the study - the green one, brass corners. He went into the vault row alone. He came back without it, and dusted his gloves the way he does after church.",
                          unlock: .evidence("c12e6")),

            // Mrs. Gaunt
            CaseStatement("c12s20", "c12_gaunt",
                          "Amos kept to his hours like scripture: door barred at eight, supper in the back room at nine, home by half ten. Twenty years, Detective. Mr. Vane set his watch by my husband and said so, smiling, many a time."),
            CaseStatement("c12s21", "c12_gaunt",
                          "That week Amos was uneasy. Carts had brought every paper in the League's keeping to the hall cellar - 'all the eggs in my basket now, Tabby,' he said, 'and I don't care for how the basket's been left by the stove.'"),
            CaseStatement("c12s22", "c12_gaunt",
                          "Tuesday he found the yard door's lock changed - changed, not broken - and a new key on his ring he'd never asked for. He wrote his worry to Mr. Vane that same night. I posted the letter myself."),
            CaseStatement("c12s23", "c12_gaunt",
                          "They sent his effects home in a parcel: his pipe, his boots, his watch. The watch stopped at twenty to ten, Detective. They tell me the alarm was rung at eleven. My Amos lay in that burning hall an hour and twenty minutes before any bell spoke for him.",
                          unlock: .evidence("c12e3")),

            // Mr. Fellgate
            CaseStatement("c12s24", "c12_fellgate",
                          "The Phoenix is asked for twelve thousand pounds, Detective, so I have been thorough. The fire began in the cellar where the records lay, in three places at once. Honest fires are not so ambidextrous."),
            CaseStatement("c12s25", "c12_fellgate",
                          "Paraffin, beyond question - the cellar flags reek of it under the char, and we found the necks of two carboys in the ash. The yard door was unlocked from outside with a key that turned sweetly. No forcing anywhere."),
            CaseStatement("c12s26", "c12_fellgate",
                          "The policy was doubled in March against 'records and archives' specifically - an odd clause, priced high, which the chairman signed at his bedside. In thirty years I have seen that clause twice. Both times I declined to pay."),
            CaseStatement("c12s27", "c12_fellgate",
                          "One more professional observation: the 'attested bank copies' Mr. Vane promises the auditors were deposited only in October - fair-copied, every page, in one clerkly hand. A man does not copy his books before a fire unless he has the fixture in his diary."),

            // Miss Dimity
            CaseStatement("c12s28", "c12_dimity",
                          "The bank copies are the final fraud, Detective. Set them against my shadow ledgers and the League is reborn innocent: every hollow year filled, every false subscription smoothed. The fire did not destroy the evidence. The fire was to legitimize its replacement."),
            CaseStatement("c12s29", "c12_dimity",
                          "Quill's hearthstone papers showed the lamp initial approving every payment. But initials, a barrister told me, are 'suggestive, not conclusive.' Somewhere there is a master ledger in the principal's own hand - Quill alluded to it twice, with the particular bitterness of a man not trusted to keep it."),
            CaseStatement("c12s30", "c12_dimity",
                          "Mr. Vane visits his family vault each Sunday. Piety, the world says. But grief does not carry deed boxes in, Detective, and it does not come out lighter than it went. Open the vault. I will be standing beside you when you do.",
                          unlock: .evidence("c12e6")),
            CaseStatement("c12s31", "c12_dimity",
                          "It is in his hand. Every payment Quill recorded, every name - Croom, Tarn, Lydgate, Gorse - and against my own name, Detective, a date in December and the single word 'resolve.' I find I am glad you opened the vault before Advent.",
                          unlock: .evidence("c12e7")),
            CaseStatement("c12s32", "c12_dimity",
                          "When you take him, take him before a full court. The clerks, the gangers, the small men hanged and jailed while he subscribed to orphanages - they are owed the sight of the Lamplighter under examination. So, I may say, am I.")
        ]

        let locations = [
            CaseLocation("c12_hall", "The Burnt League Hall",
                         "Charred beams over the boardroom where the long table stood; below, the cellar that held every record the League ever kept.",
                         scene: .boardroom),
            CaseLocation("c12_study", "Vane's Study, Highgate",
                         "Mahogany, green leather, forty almshouses in framed engravings - and a study safe standing open, conspicuously innocent.",
                         scene: .study),
            CaseLocation("c12_churchyard", "St. Alban's Churchyard",
                         "Yew, frost, and the Vane family vault - its door newly oiled, its step scuffed by a deed box's brass corners.",
                         scene: .churchyard)
        ]

        let evidence = [
            EvidenceItem("c12e1", "Three Seats of Fire",
                         "Fellgate's cellar plan: three separate ignition points among the record crates, each flagstone paraffin-soaked. The carboy necks lie where they cracked in the heat.",
                         at: "c12_hall", x: 0.30, y: 0.72),
            EvidenceItem("c12e2", "The Sweet-Turning Lock",
                         "The yard door's lock, changed the Tuesday before the fire: unforced, opened from outside with its own new key. Only two such keys were cut. The porter's was on his ring in the ashes.",
                         at: "c12_hall", x: 0.74, y: 0.62),
            EvidenceItem("c12e3", "Amos Gaunt's Watch",
                         "The porter's watch from the parcel of effects, crystal cracked, stopped at 9.40 - eighty minutes before any alarm was raised, and ten minutes after the brougham left the timber yard.",
                         at: "c12_hall", x: 0.52, y: 0.42),
            EvidenceItem("c12e4", "Doubled Policy",
                         "The Phoenix policy, March: cover doubled to twelve thousand, 'records and archives' named at a premium - signed by a gouty chairman in bed, the small print read aloud to him by Mr. Vane.",
                         at: "c12_study", x: 0.24, y: 0.56),
            EvidenceItem("c12e5", "Consolidation Minute",
                         "The board minute, Vane's motion, carried Tuesday: every original record to the hall cellar 'for the auditors' convenience.' The auditors were due in three weeks. The fire came in five days.",
                         at: "c12_hall", x: 0.14, y: 0.34),
            EvidenceItem("c12e6", "Vault Key and Sexton's Book",
                         "Vane's private key to the family vault, from his study desk - and the sexton's visitor book: Sunday entries in Vane's hand for eleven years, and against the last, the sexton's pencilled note: 'carried in a green deed box; came out without.'",
                         at: "c12_study", x: 0.68, y: 0.70),
            EvidenceItem("c12e7", "The Master Ledger",
                         "From the green deed box in the vault niche, beside the coffins of his fathers: the Lamplighter's own ledger, sixteen years in Vane's unmistakable hand. Croom's coin, Tarn's sovereign, Lydgate's 'arrangement,' Gorse's five pounds - and a December entry against Miss Dimity's name: 'resolve.'",
                         at: "c12_churchyard", x: 0.48, y: 0.66),
            EvidenceItem("c12e8", "Opera Cloakroom Ticket",
                         "From the brougham's seat pocket: a Covent Garden cloakroom ticket stamped at the first interval - reclaiming a gentleman's outdoor coat at 9.05, returned again at 10.20. Men do not take their greatcoats to stroll an opera corridor.",
                         at: "c12_study", x: 0.84, y: 0.40),
            EvidenceItem("c12e9", "Gaunt's Last Letter",
                         "Delivered to Highgate the morning before the fire and found slit open in the study waste basket: Amos Gaunt's careful hand - 'Sir, the new yard key troubles me, and the papers below troubles me more. I will sit up with them nights until the auditors come. Your obdt. servant, A. Gaunt.'",
                         at: "c12_study", x: 0.45, y: 0.30),
            EvidenceItem("c12e10", "Paraffin-Marked Glove",
                         "Behind the study safe, pushed deep: one evening glove of grey kid, palm-stained and reeking faintly of paraffin, its mate missing. Gentlemen burn what they can, Detective. They cannot burn what they forget.",
                         at: "c12_study", x: 0.58, y: 0.78),
            EvidenceItem("c12e11", "Wheel Tracks at the Timber Yard",
                         "Fresh brougham tracks in the timber yard's sawdust mud behind the hall, turned and stood a half hour - the near horse pawing a crescent - then away north. Pell's rig, by the patent tyre Mr. Vane had fitted in June.",
                         at: "c12_hall", x: 0.88, y: 0.80)
        ]

        let contradictions = [
            Contradiction("c12x1", .statement("c12s02"), .evidence("c12e8"),
                          "The Unbroken Evening",
                          "Box at eight, home after the last curtain, half of fashionable London bowing - yet the cloakroom ticket shows Vane reclaiming his greatcoat at the first interval and returning it at 10.20. Operas are watched in evening dress; Lambeth in October is visited in a coat."),
            Contradiction("c12x2", .statement("c12s03"), .statement("c12s27"),
                          "Order Survives Fire",
                          "Vane consoles the auditors with the bank's attested copies - copies deposited only in October, fair-written in a single clerkly hand, weeks before the originals burned. Order survived this fire because order was transcribed in advance of it."),
            Contradiction("c12x3", .statement("c12s05"), .statement("c12s20"),
                          "The Supper Hour",
                          "Whoever set the fire never dreamed the hall was occupied, pleads Vane - the man who, by his own habit and the widow's word, set his watch by Amos Gaunt's nine o'clock supper in the back room, twenty years running."),
            Contradiction("c12x4", .statement("c12s05"), .evidence("c12e9"),
                          "Nobody Knew He Sat Up",
                          "Vane grieves that the hall should have been empty - while Gaunt's last letter, slit open in Vane's own waste basket, announced the porter would sit up with the records every night until the auditors came."),
            Contradiction("c12x5", .statement("c12s04"), .statement("c12s11"),
                          "The Carriage in Lambeth",
                          "Vane 'merely remembers aloud' Lady Hesper's carriage in Lambeth - where it stood before two hundred concert witnesses until eleven. The only carriage behind the hall that night left patent-tyre tracks in the timber yard, and the patent tyres are Vane's own."),
            Contradiction("c12x6", .statement("c12s15"), .evidence("c12e11"),
                          "Waited With the Carriages",
                          "Pell's first statement keeps him among the opera carriages all evening - but his rig's June-fitted patent tyres printed the timber yard sawdust behind the hall, standing a full half hour."),
            Contradiction("c12x7", .statement("c12s01"), .evidence("c12e10"),
                          "Returned From the Opera",
                          "Vane came home from the opera to find the sky orange, he says, an innocent man in evening dress - and behind his study safe lies one grey kid evening glove, palm soaked in paraffin, its mate gone into some grate."),
            Contradiction("c12x8", .statement("c12s06"), .evidence("c12e6"),
                          "A Gentleman's Grave",
                          "His family vault holds only his family, Vane declares - against his own desk's vault key, eleven years of Sunday entries, and the sexton's pencil: in with a green deed box, out without it."),
            Contradiction("c12x9", .statement("c12s03"), .evidence("c12e5"),
                          "The Auditors' Convenience",
                          "The records burned by tragic chance, Vane sighs - five days after his own carried motion gathered every original into one cellar, three weeks ahead of the auditors who would have read them.")
        ]

        return GameCase(
            id: 12, act: 3,
            title: "The Lamplighter's Ledger",
            subtitle: "The fire at the League hall",
            brief: "Five days after Mr. Vane's motion gathered every League record into the hall cellar, the hall burned to the ground - with Amos Gaunt, its porter of twenty years, dead behind the door. The Phoenix Fire Office is asked for twelve thousand pounds; the auditors are offered fresh bank copies in a single clerkly hand; and Mr. Septimus Vane, whose every servant has fallen in his place, sat in full view at the opera all evening. This is the last case, Detective. The Lamplighter has burned his books. Find the one he could not burn.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To burn the League's true books",
                "Twelve thousand in insurance",
                "Revenge upon the board",
                "To ruin Lady Hesper",
                "To silence the porter"
            ],
            solution: CaseSolution(
                culpritId: "c12_vane",
                motive: "To burn the League's true books",
                keyEvidenceId: "c12e7",
                reveal: "He did it himself, because there was no one left to send. At the first interval Septimus Vane took his greatcoat, was driven to the timber yard, let himself in with the second key, and emptied two carboys among sixteen years of evidence - knowing from Gaunt's own letter that the old man sat up with the papers, and going in any road. By the last act he was bowing in his box. But a coachman's nose remembered the paraffin, a sexton's pencil remembered the deed box, and in the family vault, beside the coffins of his fathers, lay the one book he loved too well to burn: the master ledger, sixteen years in his own hand, with a December 'resolve' against the name of Miss Honor Dimity. The Lamplighter is taken in full court, as the small men were. The lamps of London burn no less brightly - but they burn, at last, for no one's profit. Your casebook closes, Master Detective."
            )
        )
    }
}
