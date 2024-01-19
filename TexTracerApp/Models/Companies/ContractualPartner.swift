import Foundation

class ContractualPartner: Company, Identifiable, Equatable {
    
    override init(id: UUID, registrationNr: Int, name: String) {
        super.init(id: id, registrationNr: registrationNr, name: name)
    }
    
    static func == (lhs: ContractualPartner, rhs: ContractualPartner) -> Bool {
            return lhs.id == rhs.id
                && lhs.registrationNr == rhs.registrationNr
                && lhs.name == rhs.name
        }
    
    // Convenience initializer with default values
//    convenience init() {
//        self.init(id: 0, registrationNr: 0, name: "", nrEmployees: 0)
//    }
    
    func createOrderline(id: UUID, brand: Brand) -> Orderline {
        return Orderline(id: id, brand: brand, contractualPartner: self)
    }
    
}
