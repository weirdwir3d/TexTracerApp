//
//  OrderStep.swift
//  TexTracerApp
//
//  Created by opendag on 02/12/2023.
//

import Foundation

class OrderStep {
    let id: Int
    let step: Step
    let supplierId: Int
    
    init(id: Int, step: Step, supplierId: Int) {
        self.id = id
        self.step = step
        self.supplierId = supplierId
    }
}
