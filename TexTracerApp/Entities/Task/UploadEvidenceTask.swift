import Foundation

class UploadEvidenceTask: Task {
    let orderId: Int
    let assignerId: Int
    let assigneeId: Int
    let orderSteps: [OrderStep]
    var description: String
    
    init(id: Int, receivedDate: Date, orderId: Int, assignerId: Int, assigneeId: Int, orderSteps: [OrderStep], description: String) {
        self.orderId = orderId
        self.description = description
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
        
        return "Upload evidence for order \(orderId) for the steps: \(stepStrings.joined(separator: ", "))"
    }
    
}
