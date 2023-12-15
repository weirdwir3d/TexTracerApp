import Foundation

class Orderline {
    let id: UUID
    let brand: Brand
    let contractualPartner: ContractualPartner
    var isComplete: Bool
    let orderSteps: Array<OrderStep>?
    var orders: Array<Order>?
    
    init(id: UUID, brand: Brand, contractualPartner: ContractualPartner) {
        self.id = id
        self.brand = brand
        self.contractualPartner = contractualPartner
        self.isComplete = false
        self.orderSteps = []
        self.orders = []
    }
    
    func addOrder(_ order: Order) {
        orders?.append(order)
    }
    
}
