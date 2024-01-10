import Foundation

class Order: Identifiable {
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

}

extension Order {
    static var test: Order {
        return Order(
            code: "FFA534", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 45, name: "WeaveLink"), brand: Brand(id: UUID(), registrationNr: 32, name: "H&M")
        )
    }
}
