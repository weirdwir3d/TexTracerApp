import Foundation

class Company {
    let id: UUID
    let registrationNr: Int
    var name: String
    
    init(id: UUID, registrationNr: Int, name: String) {
        self.id = id
        self.registrationNr = registrationNr
        self.name = name
    }
    
}
