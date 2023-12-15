import Foundation

enum Step {
    case Trims
    case Spinning
    case Ginning
    case Packing
    case Sewing
}

extension Step {
    var stringValue: String {
        switch self {
        case .Ginning:
            return "Ginning"
        case .Spinning:
            return "Spinning"
        case .Trims:
            return "Trims"
        case .Packing:
            return "Packing"
        case .Sewing:
            return "Sewing"
        }
    }
}

