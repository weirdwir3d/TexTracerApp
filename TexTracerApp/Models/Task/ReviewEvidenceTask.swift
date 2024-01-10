import Foundation

class ReviewEvidenceTask: Task {
    let assignerId: UUID
    let assigneeId: UUID
    let orderSteps: [OrderStep]
    
    init(id: UUID, receivedDate: Date, orderCode: String?, assignerId: UUID, assigneeId: UUID, orderSteps: [OrderStep]) {
        self.assignerId = assignerId
        self.assigneeId = assigneeId
        self.orderSteps = orderSteps
        
        super.init(id: id, receivedDate: receivedDate, orderCode: orderCode)
        self.description = addDescription()
    }
    
    func addDescription() -> String {
        let stepStrings = orderSteps.map { step in
            switch step.step {
            case .Trims:
                return "Trims"
            case .Spinning:
                return "Spinning"
            case .Ginning:
                return "Ginning"
            case .Packing:
                return "Packing"
            case .Sewing:
                return "Sewing"
            case .Dyeing:
                return "Dyeing"
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
        
        return "Review evidence for order \(orderCode) for \(stepStrings.joined(separator: ", "))"
    }
    
}
