//
//  Orderline.swift
//  TexTracerApp
//
//  Created by opendag on 02/12/2023.
//

import Foundation

class Orderline {
    let id: Int
    let brand: Brand
    let contractualPartner: ContractualPartner
    let isComplete: Bool
    let orderSteps: Array<OrderStep>
    let orders: Array<Order>
    
    init(id: Int, brand: Brand, contractualPartner: ContractualPartner) {
        self.id = id
        self.brand = brand
        self.contractualPartner = contractualPartner
        self.isComplete = false
    }
}
