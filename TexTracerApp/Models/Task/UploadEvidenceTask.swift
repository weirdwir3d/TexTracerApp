import Foundation

class UploadEvidenceTask: Task {
    let orderCode: String
    let assignerId: UUID
    let assigneeId: UUID
    let orderSteps: [OrderStep]
    
    init(id: UUID, receivedDate: Date, orderCode: String, assignerId: UUID, assigneeId: UUID, orderSteps: [OrderStep]) {
        self.orderCode = orderCode
        self.assignerId = assignerId
        self.assigneeId = assigneeId
        self.orderSteps = orderSteps
        
        super.init(id: id, receivedDate: receivedDate)
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
            }
        }
        
        return "Upload evidence for order \(orderCode) for \(stepStrings.joined(separator: ", "))"
    }
    
}
