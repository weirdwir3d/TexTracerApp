import Foundation

class OrderStep: Equatable, Identifiable, CustomStringConvertible, Hashable {
    let id: UUID
    let step: Step
    let supplierId: UUID
    
    init(id: UUID, step: Step, supplierId: UUID) {
        self.id = id
        self.step = step
        self.supplierId = supplierId
    }
    
    static func == (lhs: OrderStep, rhs: OrderStep) -> Bool {
        return lhs.id == rhs.id &&
               lhs.step == rhs.step &&
               lhs.supplierId == rhs.supplierId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(step)
        hasher.combine(supplierId)
    }
    
    var description: String {
        return "id: \(id), step: \(step)"
    }
}

