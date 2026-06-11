import Foundation

/// Aggregates every handcrafted case. Case 0 is the tutorial; 1-4 Act I,
/// 5-8 Act II, 9-12 Act III (the Lamplighter conspiracy).
enum CaseLibrary {
    static let cases: [GameCase] = [
        Case00.build(),
        Case01.build(), Case02.build(), Case03.build(), Case04.build(),
        Case05.build(), Case06.build(), Case07.build(), Case08.build(),
        Case09.build(), Case10.build(), Case11.build(), Case12.build()
    ]

    static func find(_ id: Int) -> GameCase? {
        cases.first { $0.id == id }
    }

    static func actTitle(_ act: Int) -> String {
        switch act {
        case 0: return "Training"
        case 1: return "Act I - Small Sins"
        case 2: return "Act II - Dark Waters"
        case 3: return "Act III - The Lamplighter"
        default: return "Cases"
        }
    }

    static func actSubtitle(_ act: Int) -> String {
        switch act {
        case 0: return "Learn the craft at the Yard."
        case 1: return "Petty thefts and spites of the parish."
        case 2: return "Crimes that left bodies behind."
        case 3: return "A patron of charities pulls every string."
        default: return ""
        }
    }
}
