import Foundation

class OrderStep: Equatable {
    let id: Int
    let step: Step
    let supplierId: UUID
    
    init(id: Int, step: Step, supplierId: UUID) {
        self.id = id
        self.step = step
        self.supplierId = supplierId
    }
    
    static func == (lhs: OrderStep, rhs: OrderStep) -> Bool {
                return lhs.id == rhs.id &&
                       lhs.step == rhs.step &&
                       lhs.supplierId == rhs.supplierId
    }
    
}
