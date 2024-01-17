import Foundation

class Order: Identifiable, Hashable, Equatable {
    let code: String
    let orderlineId: UUID
    let styleNumber: String
    let contractualPartner: ContractualPartner
    let brand: Brand
    var isComplete: Bool = false
    var orderSteps: Array<OrderStep>
    var tasks: Task?
    var finalClientId: Int?
    
    init(code: String, orderlineId: UUID, styleNumber: String, contractualPartner: ContractualPartner, brand: Brand) {
        self.code = code
        self.orderlineId = orderlineId
        self.styleNumber = styleNumber
        self.contractualPartner = contractualPartner
        self.brand = brand
        self.orderSteps = []
    }
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.code == rhs.code
            && lhs.orderlineId == rhs.orderlineId
            && lhs.styleNumber == rhs.styleNumber
            && lhs.contractualPartner == rhs.contractualPartner
            && lhs.brand == rhs.brand
            && lhs.isComplete == rhs.isComplete
            && lhs.orderSteps == rhs.orderSteps
            // Add comparisons for other properties if needed
    }
    
    func addOrderStep(orderStep: OrderStep) -> Bool {
        orderSteps.append(orderStep)

        if orderSteps.contains(orderStep) {
            return true
        }
        return false
    }
    
    func addOrderSteps(_ steps: [OrderStep]) {
        orderSteps.append(contentsOf: steps)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
        hasher.combine(orderlineId)
        // Combine other properties as needed
    }
}

extension Order {
    static var test: Order {
        return Order(
            code: "FFA534", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 45, name: "WeaveLink"), brand: Brand(id: UUID(), registrationNr: 32, name: "H&M")
        )
    }
    
    static var test2: Order {
        return Order(
            code: "FFA535", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 45, name: "WeaveLink"), brand: Brand(id: UUID(), registrationNr: 32, name: "H&M")
        )
    }
    
    static var test3: Order {
        return Order(
            code: "FFA536", orderlineId: UUID(), styleNumber: "AW23D002", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 45, name: "WeaveLink"), brand: Brand(id: UUID(), registrationNr: 32, name: "H&M")
        )
    }
}

