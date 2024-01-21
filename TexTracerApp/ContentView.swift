import SwiftUI

struct ContentView: View {
    
    @StateObject var readComplianceStore = ReadComplianceDataStore()
    @StateObject var tasksStore = TasksStore()
    
    var body: some View {
        NavigationView {
            TabView {
                TasksPage()
                    .environmentObject(tasksStore)
                    .environmentObject(readComplianceStore)
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
                
                AllCompliancePage()
                    .environmentObject(tasksStore)
                    .environmentObject(readComplianceStore)
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
                print("tasksStore: \(tasksStore.description)")
                print("DocumentStore: \(readComplianceStore.description)")
            }
        
    }
    
    func loadInitialData() {
        let hnm = Brand(id: UUID(), registrationNr: 1, name: "H&M")
        let texfiber = Supplier(id: UUID(), registrationNr: 2, name: "Texfiber")
        let eleganceForge = Supplier(id: UUID(), registrationNr: 3, name: "EleganceForge")
        let fashionLead = ContractualPartner(id: UUID(), registrationNr: 3, name: "Fashion Lead")
        
        //contractual partner creates orderline
        let orderline = fashionLead.createOrderline(id: UUID(), brand: hnm)
        
        //there are 2 orders for this orderline:
        //2 orders have the same styleNrr: "AW23D001"
        //1 order had differrent styleNr
        
        let orderFFA534 = Order(code: "FFA534", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: fashionLead, brand: hnm)
        
        let orderFFA533 = Order(code: "FFA533", orderlineId: orderline.id, styleNumber: "AW23D002", contractualPartner: fashionLead, brand: hnm)
        
        let orderFFA532 = Order(code: "FFA532", orderlineId: orderline.id, styleNumber: "AW23D001", contractualPartner: fashionLead, brand: hnm)
        
        
        let orders = [orderFFA534, orderFFA533, orderFFA532]
        
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
        print(self.tasksStore.getTasks())
        

        //dummy read doc task
        let readTask1 = ReadDocumentTask(id: UUID(),
                                         receivedDate: Date(),
                                         assignerId: fashionLead.id,
                                         assigneeId: texfiber.id,
                                         name: "Finestitch Delivery Manual 2023 (v2)",
                                         pdfFileName: "dummyFile",
                                         messageFromSender: dummyText())
        var path = readTask1.generateFilePath(fileName: "dummyFile")
        //        print("heres the path \(path)")
        
        readTask1.addPdfFile {
            // This code block will be executed once the PDF is loaded
//            print("\(readTask1.isFileNil())")
//            print("LOADED FILE: \(readTask1.pdfFile)")
            self.tasksStore.addTask(task: readTask1)
        }
        
    }
    
}

func dummyText() -> String {
    var dummyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    return dummyText
}

#Preview {
    ContentView()
}
