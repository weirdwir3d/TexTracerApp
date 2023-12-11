import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            TasksPage()
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Tasks")
                }
            
            OrderEvidencePage()
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
        
    }
}

#Preview {
    ContentView()
        .onAppear {
            loadInitialData()
        }
}

func loadInitialData() {
    //Zara assigns a contractual partner to fill in the supply chain steps of a new orderline
    let zara = Brand(id: UUID(), registrationNr: 1, name: "Zara")
    let texfiber = Supplier(id: UUID(), registrationNr: 2, name: "Texfiber")
    let finestitch = Supplier(id: UUID(), registrationNr: 3, name: "Finestitch")
    let bestPartner = ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner")
    
    //contractual partner creates orderline
    let orderline = bestPartner.createOrderline(id: 99, brand: zara)
    
    //there are 7 orders for this orderline:
    //5 orders have the same styleNrr: "AW23D001"
    //the other orders have differrent styleNrs
    
    let orderFFA534 = Order(code: "FFA534", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: bestPartner, brand: zara)
    
    let orderFFA535 = Order(code: "FFA535", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: bestPartner, brand: zara)
    
    let orderFFA536 = Order(code: "FFA536", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: bestPartner, brand: zara)
    
    let orderFFA537 = Order(code: "FFA537", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: bestPartner, brand: zara)
    
    let orderFFA538 = Order(code: "FFA538", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: bestPartner, brand: zara)
    
    //ddifferent styleNrs
    let orderFFA539 = Order(code: "FFA539", orderlineId: orderline.id, styleNumber: "AW19B001", contractualPartner: bestPartner, brand: zara)
    
    let orderFFA540 = Order(code: "FFA540", orderlineId: orderline.id, styleNumber: "AW19B002", contractualPartner: bestPartner, brand: zara)
    
    let orders = [orderFFA534, orderFFA535, orderFFA536, orderFFA537, orderFFA538, orderFFA539, orderFFA540]
    
    orders.forEach(orderline.addOrder)
    
    let orderSteps = [OrderStep(id: 10, step: Step.Trims, supplierId: texfiber.id),
                      OrderStep(id: 11, step: Step.Spinning, supplierId: texfiber.id),
                      OrderStep(id: 12, step: Step.Ginning, supplierId: texfiber.id),
                      OrderStep(id: 13, step: Step.Packing, supplierId: texfiber.id),
                      OrderStep(id: 14, step: Step.Sewing, supplierId: finestitch.id),
    ]
    
    //steps:
    //trims, spinning, ginning, packing -> Texfiber
    //sewing -> Finestitch
    
    for order in orders {
        order.addOrderSteps(orderSteps)
        print(order)
    }   
    
    //then comes the time when Texfiber is asked to upload order evidence for trims, spinning, ginning and packing. This request is linked to a certain order number, in this case FFA534, linked to orderline of id 1
    
//    let uploadEvidenceTasks = [
//        UploadEvidenceTask(id: 20, receivedDate: <#T##Date#>, orderId: <#T##Int#>, assignerId: <#T##Int#>, assigneeId: <#T##Int#>, orderSteps: <#T##[OrderStep]#>, description: <#T##String#>)
//    
//    ]
}
