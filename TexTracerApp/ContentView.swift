import SwiftUI

struct ContentView: View {
    
    @StateObject var tasksStore = TasksStore()
    
    init() {
        self.loadInitialData()
    }
    
    var body: some View {
        NavigationView {
            TabView {
                TasksPage()
                    .environmentObject(tasksStore)
                    .tabItem {
                        Image(systemName: "checklist")
                        Text("Tasks")
                    }
                
                AllOrdersPage()
                    .environmentObject(tasksStore)
                    .tabItem {
                        Image(systemName: "checkmark.circle")
                        Text("Order evidence")
                    }
                
                CompliancePage()
                    .tabItem {
                        Image(systemName: "doc")
                        Text("Compliance")
                    }
                
                MyAccountPage()
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("My account")
                    }
            }
        }.navigationTitle("Tasks")
        
        
        .onAppear {
            loadInitialData()
        }
        
    }
    
    func loadInitialData() {
        //H&M assigns a contractual partner to fill in the supply chain steps of a new orderline
        let hnm = Brand(id: UUID(), registrationNr: 1, name: "H&M")
        let texfiber = Supplier(id: UUID(), registrationNr: 2, name: "Texfiber")
        let eleganceForge = Supplier(id: UUID(), registrationNr: 3, name: "EleganceForge")
        let fashionLead = ContractualPartner(id: UUID(), registrationNr: 3, name: "Fashion Lead")
        
        //contractual partner creates orderline
        let orderline = fashionLead.createOrderline(id: UUID(), brand: hnm)
        
        //there are 7 orders for this orderline:
        //5 orders have the same styleNrr: "AW23D001"
        //the other orders have differrent styleNrs
        
        let orderFFA534 = Order(code: "FFA534", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: fashionLead, brand: hnm)
        
        let orderFFA533 = Order(code: "FFA533", orderlineId: orderline.id, styleNumber: "AW23D002", contractualPartner: fashionLead, brand: hnm)
        
        let orderFFA532 = Order(code: "FFA532", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: fashionLead, brand: hnm)
        
//        let orderFFA537 = Order(code: "FFA537", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: fashionLead, brand: hnm)
//        
//        let orderFFA538 = Order(code: "FFA538", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: fashionLead, brand: hnm)
//        
//        //different styleNrs
//        let orderFFA539 = Order(code: "FFA539", orderlineId: orderline.id, styleNumber: "AW19B001", contractualPartner: fashionLead, brand: hnm)
//        
//        let orderFFA540 = Order(code: "FFA540", orderlineId: orderline.id, styleNumber: "AW19B002", contractualPartner: fashionLead, brand: hnm)
        
        let orders = [orderFFA534, orderFFA533, orderFFA532,
//                      orderFFA537, orderFFA538, orderFFA539, orderFFA540
        ]
        
        orders.forEach(orderline.addOrder)
        
        let orderSteps = [OrderStep(id: UUID(), step: Step.Dyeing, supplierId: texfiber.id),
                          OrderStep(id: UUID(), step: Step.Tanning, supplierId: texfiber.id),
                          OrderStep(id: UUID(), step: Step.FabricTrading, supplierId: texfiber.id),
                          OrderStep(id: UUID(), step: Step.DesignAndDevelopment, supplierId: texfiber.id),
                          OrderStep(id: UUID(), step: Step.Printing, supplierId: eleganceForge.id),
        ]
        
        //steps:
        //dyeing, tanning, fabric trading, design & development -> Texfiber
        //printing -> Finestitch
        
        for order in orders {
            order.addOrderSteps(orderSteps)
            
            let task = UploadEvidenceTask(id: UUID(), receivedDate: Date(), orderCode: order.code, assignerId: fashionLead.id, assigneeId: texfiber.id, orderSteps: orderSteps)
            
            //then comes the time when Texfiber is asked to upload order evidence for trims, spinning, ginning and packing. This request is linked to a certain order number, in this case FFA534, linked to orderline id
            
            self.tasksStore.addTask(task: task)
        }
        
    }
    
}

#Preview {
    ContentView()
}
