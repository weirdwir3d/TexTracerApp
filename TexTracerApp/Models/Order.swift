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
