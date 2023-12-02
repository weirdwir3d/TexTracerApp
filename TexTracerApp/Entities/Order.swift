//
//  Order.swift
//  TexTracerApp
//
//  Created by opendag on 02/12/2023.
//

import Foundation

class Order {
    let id: Int
    let orderlineId: Int
    let styleNumber: String
    let contractualPartner: ContractualPartner
    let brand: Brand
    var isComplete: Bool
    var orderSteps: Array<OrderStep>?
    var tasks: Task?
    var finalClientId: Int?
    
    init(id: Int, orderlineId: Int, styleNumber: String, contractualPartner: ContractualPartner, brand: Brand, isComplete: Bool) {
        self.id = id
        self.orderlineId = orderlineId
        self.styleNumber = styleNumber
        self.contractualPartner = contractualPartner
        self.brand = brand
        self.isComplete = isComplete
    }
}
