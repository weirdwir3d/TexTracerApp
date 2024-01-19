import Foundation

enum Step: CaseIterable {
    case Trims
    case Spinning
    case Ginning
    case Packing
    case Sewing
    case Dyeing
    case Tanning
    case FabricTrading
    case DesignAndDevelopment
    case Printing
    case Harvesting
}

extension Step: Collection {
    
    typealias Index = Int
        typealias Element = Step
    
    var startIndex: Index { return 0 }
        var endIndex: Index { return Step.allCases.count }

        subscript(position: Index) -> Element {
            return Step.allCases[position]
        }

        func index(after i: Index) -> Index {
            return i + 1
        }
    
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
        case .Dyeing:
            return "Sewing"
        case .Tanning:
            return "Tanning"
        case .FabricTrading:
            return "Fabric Trading"
        case .DesignAndDevelopment:
            return "Design & Development"
        case .Printing:
            return "Printing"
        case .Harvesting:
            return "Harvesting"
        }
    }
}

