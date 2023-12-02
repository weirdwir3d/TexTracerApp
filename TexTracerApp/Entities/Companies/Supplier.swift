//
//  Supplier.swift
//  TexTracerApp
//
//  Created by opendag on 02/12/2023.
//

import Foundation

class Supplier: Company {
    var facilities: Array<Facility>?
//    var companyPictures: Array<File>?
    var nrEmployees: Int?
    var nrMaleEmployees: Int?
    var nrFemaleEmployees: Int?
    var yearlyTurnover: Int?
    var monthlyCapacity: Int?
    var profileDescription: String?
    
    override init(id: UUID, registrationNr: Int, name: String) {
        super.init(id: id, registrationNr: registrationNr, name: name)
    }
    
    // Convenience initializer with default values
//    convenience init() {
//        self.init(id: 0, registrationNr: 0, name: "", nrEmployees: 0)
//    }
}
