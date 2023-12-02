//
//  ContractualPartner.swift
//  TexTracerApp
//
//  Created by opendag on 02/12/2023.
//

import Foundation

class ContractualPartner: Company {
    
    override init(id: UUID, registrationNr: Int, name: String) {
        super.init(id: id, registrationNr: registrationNr, name: name)
    }
    
    // Convenience initializer with default values
//    convenience init() {
//        self.init(id: 0, registrationNr: 0, name: "", nrEmployees: 0)
//    }
    
    private func createOrderline(id: Int, brand: Brand) {
        let orderline = Orderline(id: id, brand: brand, contractualPartner: self)
    }
    
}
