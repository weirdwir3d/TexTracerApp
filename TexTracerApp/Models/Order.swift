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
    
    // Getter method for code
        func getCode() -> String {
            return code
        }

        // Getter method for orderlineId
        func getOrderlineId() -> UUID {
            return orderlineId
        }

        // Getter method for styleNumber
        func getStyleNumber() -> String {
            return styleNumber
        }

        // Getter method for contractualPartner
        func getContractualPartner() -> ContractualPartner {
            return contractualPartner
        }

        // Getter method for brand
        func getBrand() -> Brand {
            return brand
        }

        // Getter method for isComplete
        func getIsComplete() -> Bool {
            return isComplete
        }

        // Getter method for orderSteps
        func getOrderSteps() -> [OrderStep] {
            return orderSteps
        }

        // Getter method for tasks
        func getTasks() -> Task? {
            return tasks
        }

        // Getter method for finalClientId
        func getFinalClientId() -> Int? {
            return finalClientId
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
            code: "FFA534", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 45, name: "FashionLead"), brand: Brand(id: UUID(), registrationNr: 32, name: "H&M")
        )
    }
    
    static var test2: Order {
        return Order(
            code: "FFA533", orderlineId: UUID(), styleNumber: "AW23D002", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 45, name: "FashionLead"), brand: Brand(id: UUID(), registrationNr: 32, name: "H&M")
        )
    }
    
    static var test3: Order {
        return Order(
            code: "FFA532", orderlineId: UUID(), styleNumber: "AW23D002", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 45, name: "FashionLead"), brand: Brand(id: UUID(), registrationNr: 32, name: "H&M")
        )
    }
}

