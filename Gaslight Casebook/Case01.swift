import Foundation

/// Act I, Case 1 — The Vanished Brooch.
enum Case01 {
    static func build() -> GameCase {
        let suspects = [
            Suspect(id: "c1_clara", name: "Clara Wimple", role: "Lady's companion",
                    bio: "Companion to Mrs. Halloway these four years. Neat, watchful, and paid very little for very long hours.",
                    portrait: PortraitSpec(skin: 0, hair: .bun, hairColor: 1, hat: .none,
                                           collar: .lace, coat: 6, feminine: true)),
            Suspect(id: "c1_stagg", name: "Major Roderick Stagg", role: "Retired officer",
                    bio: "A whiskered veteran of the Punjab campaigns, fond of punctuality, whist, and - it is whispered - of Miss Foss.",
                    portrait: PortraitSpec(skin: 1, hair: .side, hairColor: 3, facial: .walrus,
                                           hat: .topHat, collar: .cravat, coat: 4)),
            Suspect(id: "c1_beatrice", name: "Beatrice Foss", role: "The niece",
                    bio: "Mrs. Halloway's only niece and heir, lively and a little careless with both words and money.",
                    portrait: PortraitSpec(skin: 0, hair: .wave, hairColor: 2, hat: .bonnet,
                                           collar: .lace, coat: 7, feminine: true)),
            Suspect(id: "c1_crick", name: "Tobias Crick", role: "Footman",
                    bio: "Dismissed from his last place over spoons that were never proved on him. Mrs. Halloway took him in regardless.",
                    portrait: PortraitSpec(skin: 1, hair: .cropped, hairColor: 0, facial: .sideburns,
                                           hat: .none, collar: .uniform, coat: 2)),
            Suspect(id: "c1_pryce", name: "Dr. Lemuel Pryce", role: "Family physician",
                    bio: "Has attended the Halloway household for twenty years and keeps its small confidences like a strongbox.",
                    portrait: PortraitSpec(skin: 0, hair: .bald, hairColor: 3, facial: .moustache,
                                           hat: .none, eyewear: .pinceNez, collar: .highCollar, coat: 0))
        ]

        let statements = [
            // Clara Wimple
            CaseStatement("c1s01", "c1_clara",
                          "I sat at Mrs. Halloway's right hand through the whole of the musicale and never left the parlour, not once."),
            CaseStatement("c1s02", "c1_clara",
                          "Debts? I have none, Detective. My situation with Mrs. Halloway is perfectly comfortable."),
            CaseStatement("c1s03", "c1_clara",
                          "If you want a thief, look to the footman. Crick was dismissed from his last place over silver spoons."),
            CaseStatement("c1s04", "c1_clara",
                          "I wore plain grey wool today, as I do every day. I own no lace - lace is above my station."),
            CaseStatement("c1s05", "c1_clara",
                          "Very well - I stepped out for air when the singing began. But no further than the terrace door, I promise you that.",
                          unlock: .contradiction("c1x1")),
            CaseStatement("c1s06", "c1_clara",
                          "Search my room if you like. I have pawned nothing, and you shall find nothing.",
                          unlock: .contradiction("c1x2")),

            // Major Stagg
            CaseStatement("c1s07", "c1_stagg",
                          "I arrived for tea at four o'clock precisely and not a minute before. A soldier keeps time, Detective."),
            CaseStatement("c1s08", "c1_stagg",
                          "Miss Wimple seemed distracted all afternoon. Kept glancing at the terrace door, as though expecting weather."),
            CaseStatement("c1s09", "c1_stagg",
                          "I will vouch for Dr. Pryce with my life. We have played whist together for a decade and he cheats at nothing."),
            CaseStatement("c1s10", "c1_stagg",
                          "Confound it - very well. I came at three, to leave a note for Miss Foss. A private matter of an honourable nature. I was never within a yard of the jewel case.",
                          unlock: .contradiction("c1x4")),
            CaseStatement("c1s11", "c1_stagg",
                          "A garnet brooch is a poor prize for a thief. Its worth was sentimental - old Halloway gave it to her the year before he fell."),

            // Beatrice Foss
            CaseStatement("c1s12", "c1_beatrice",
                          "Aunt's brooch will be mine one day in any case. Why should I steal what time means to give me?"),
            CaseStatement("c1s13", "c1_beatrice",
                          "Clara slipped out to the garden when the singing began. I supposed she needed air - the parlour was stifling."),
            CaseStatement("c1s14", "c1_beatrice",
                          "I have never so much as touched my aunt's jewels. Never in my life."),
            CaseStatement("c1s15", "c1_beatrice",
                          "The Major kept patting his coat all through tea, as though he had lost something and dared not say so."),
            CaseStatement("c1s16", "c1_beatrice",
                          "Oh - the brooch at Christmas. I tried it on for a lark and Aunt scolded me before the whole party. It hardly makes me a thief, does it?",
                          unlock: .contradiction("c1x5")),
            CaseStatement("c1s26", "c1_beatrice",
                          "That hat pin by the terrace is none of mine; I wear none in summer. Clara has one with a garnet head - bought, she said, to match a brooch she admired."),

            // Tobias Crick
            CaseStatement("c1s17", "c1_crick",
                          "I was polishing the silver in the pantry from three until the alarm was raised. Cook sat with me the whole while."),
            CaseStatement("c1s18", "c1_crick",
                          "I'll not deny my last master turned me out. But Mrs. Halloway took me in when no one else would, and I'd sooner cut off my hand than rob this house."),
            CaseStatement("c1s19", "c1_crick",
                          "Miss Wimple asked me on Tuesday which pawnbrokers in Lambeth keep late hours. For a friend, she said."),
            CaseStatement("c1s20", "c1_crick",
                          "The terrace door was bolted at noon, as it always is. Someone drew that bolt from the inside after."),

            // Dr. Pryce
            CaseStatement("c1s21", "c1_pryce",
                          "I was summoned at five, when Mrs. Halloway felt faint. The brooch was already gone by then - I never saw the case but empty."),
            CaseStatement("c1s22", "c1_pryce",
                          "Miss Foss tried the brooch on at Christmas and her aunt scolded her before the whole party. A child's mischief, nothing more."),
            CaseStatement("c1s23", "c1_pryce",
                          "Mrs. Halloway's eyes are failing, though she hides it bravely. From her chair she would not see a hand at the case."),
            CaseStatement("c1s24", "c1_pryce",
                          "Miss Wimple consulted me a month past for sleeplessness. Money worries, she let slip - a dressmaker pressing her hard."),
            CaseStatement("c1s25", "c1_pryce",
                          "Major Stagg is sound as a bell in his finances - I know his man of business. He has no need of garnets, only of courage with Miss Foss.")
        ]

        let locations = [
            CaseLocation("c1_parlour", "Halloway Parlour",
                         "Heavy curtains, a settee, the mantel clock - and the jewel cabinet by the window.",
                         scene: .parlour),
            CaseLocation("c1_garden", "Terrace Garden",
                         "A clipped hedge, a gravel walk, and the terrace door standing ajar.",
                         scene: .garden)
        ]

        let evidence = [
            EvidenceItem("c1e1", "Empty Jewel Case",
                         "The garnet brooch's velvet case, lid open, sitting in the unlocked cabinet. No lock was forced - it was opened by someone who knew the catch.",
                         at: "c1_parlour", x: 0.63, y: 0.64),
            EvidenceItem("c1e2", "Garnet-Headed Hat Pin",
                         "A hat pin dropped on the terrace step, its head a small garnet. Summer-weight - worn today, lost in a hurry.",
                         at: "c1_garden", x: 0.30, y: 0.72),
            EvidenceItem("c1e3", "Dressmaker's Demand",
                         "A letter folded small inside a sewing basket: 'Final notice to Miss C. Wimple - eleven pounds four shillings owing, payable by Friday or the matter goes to law.'",
                         at: "c1_parlour", x: 0.22, y: 0.75),
            EvidenceItem("c1e4", "Terrace Footprints",
                         "A line of narrow boot prints in the soft border - a woman's boots - leading from the terrace door to the hedge gap and back.",
                         at: "c1_garden", x: 0.55, y: 0.80),
            EvidenceItem("c1e5", "Lavender Lace Thread",
                         "A thread of lavender machine lace caught in the jewel case clasp. Mrs. Halloway wears black; Miss Foss wore white muslin.",
                         at: "c1_parlour", x: 0.66, y: 0.38),
            EvidenceItem("c1e6", "Folded Note",
                         "Tucked beneath a settee cushion: 'I shall be in the parlour at three - say nothing to your aunt. Burn this. R.S.'",
                         at: "c1_parlour", x: 0.40, y: 0.55),
            EvidenceItem("c1e7", "Pawnbroker's Card",
                         "A trade card dropped by the hedge gap: 'Croke and Vane, Pawnbrokers, Lambeth.' Pencilled on the back: 'garnet pc. - ask for Vane, after six.'",
                         at: "c1_garden", x: 0.78, y: 0.45),
            EvidenceItem("c1e8", "Seating Card",
                         "Mrs. Halloway's seating plan for the musicale. Miss Wimple's chair is at her right hand - nearest the jewel cabinet.",
                         at: "c1_parlour", x: 0.82, y: 0.28)
        ]

        let contradictions = [
            Contradiction("c1x1", .statement("c1s01"), .statement("c1s13"),
                          "The Companion Who Never Stirred",
                          "Clara swears she never left the parlour, yet Beatrice watched her slip out to the garden the moment the singing began."),
            Contradiction("c1x2", .statement("c1s05"), .evidence("c1e4"),
                          "No Further Than the Door",
                          "Clara admits to the terrace door but no further - yet a woman's boot prints run from that door to the hedge gap and back again."),
            Contradiction("c1x3", .statement("c1s02"), .evidence("c1e3"),
                          "A Comfortable Situation",
                          "Clara claims to have no debts, while a final demand for eleven pounds, payable by Friday, lies folded in her sewing basket."),
            Contradiction("c1x4", .statement("c1s07"), .evidence("c1e6"),
                          "A Soldier Keeps Time",
                          "The Major insists he arrived at four precisely - but his own note promises he would be in the parlour at three."),
            Contradiction("c1x5", .statement("c1s14"), .statement("c1s22"),
                          "Never Touched the Jewels",
                          "Beatrice says she never touched her aunt's jewels, yet Dr. Pryce recalls her trying on the very brooch last Christmas."),
            Contradiction("c1x6", .statement("c1s04"), .evidence("c1e5"),
                          "Above Her Station",
                          "Clara says she owns no lace and wore plain grey wool - yet a lavender lace thread is caught in the jewel case clasp, and no other woman present wore lavender."),
            Contradiction("c1x7", .statement("c1s06"), .evidence("c1e7"),
                          "Nothing to Find",
                          "Clara dares you to search for pawned goods - while a Lambeth pawnbroker's card marked 'garnet pc.' lies dropped along her path through the hedge.")
        ]

        return GameCase(
            id: 1, act: 1,
            title: "The Vanished Brooch",
            subtitle: "A theft at the Halloway musicale",
            brief: "During an afternoon musicale at Halloway House, Mrs. Halloway's garnet brooch vanished from its case in the parlour cabinet. Five people had the run of the rooms; none will admit to leaving their chairs. The brooch was her late husband's last gift, and she wants it back more than she wants a scandal.",
            suspects: suspects,
            statements: statements,
            evidence: evidence,
            locations: locations,
            contradictions: contradictions,
            motiveOptions: [
                "To pay a pressing debt",
                "Jealousy of her mistress",
                "To fund an elopement",
                "Spite over harsh treatment",
                "To hasten an inheritance"
            ],
            solution: CaseSolution(
                culpritId: "c1_clara",
                motive: "To pay a pressing debt",
                keyEvidenceId: "c1e7",
                reveal: "Clara Wimple slipped out as the singing covered her steps, opened the case whose catch she knew by heart, and carried the brooch through the hedge gap toward Lambeth - dropping the pawnbroker's card that named her errand. Eleven pounds owed to a dressmaker, and four years of small wages, decided her. The brooch is recovered from Croke and Vane, unredeemed."
            )
        )
    }
}
