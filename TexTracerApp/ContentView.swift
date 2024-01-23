import SwiftUI

struct ContentView: View {
    
    @StateObject var tasksStore = TasksStore()
    @StateObject var readComplianceStore = ReadComplianceDataStore()
    @StateObject var signComplianceStore = SignComplianceDataStore()
    
    var body: some View {
        NavigationView {
            TabView {
                TasksPage()
                    .environmentObject(tasksStore)
                    .environmentObject(readComplianceStore)
                    .environmentObject(signComplianceStore)
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
                    .environmentObject(signComplianceStore)
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
    
//    DUMMY DATA
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
        
        //dummy sign doc task
        let signTask1 = SignDocumentTask(id: UUID(),
                                         receivedDate: Date(),
                                         assignerId: fashionLead.id,
                                         assigneeId: texfiber.id,
                                         name: "Code of Conduct Update - Zara",
                                         pdfFileName: "Pinocchio",
                                         messageFromSender: "You better sign this",
                                         signDeadline: DateUtility.formatDateTimeToString(Date()))
        signTask1.addMessage(content: "I don't follow your rules", dateTime: DateUtility.formatDateTimeToString(Date()))

        //dummy read doc task
        let readTask1 = ReadDocumentTask(id: UUID(),
                                         receivedDate: Date(),
                                         assignerId: fashionLead.id,
                                         assigneeId: texfiber.id,
                                         name: "Finestitch Delivery Manual 2023 (v2)",
                                         pdfFileName: "dummyFile",
                                         messageFromSender: dummyText())
        readTask1.addMessage(content: dummyText(), dateTime: DateUtility.formatDateTimeToString(Date()))
        readTask1.addMessage(content: "This is another message, who would have thought", dateTime: DateUtility.formatDateTimeToString(Date()))
        readTask1.addMessage(content: "That does not look like a Delivery manual to me", dateTime: DateUtility.formatDateTimeToString(Date()))
        readTask1.addMessage(content: "It's actually an amazing book about PTSD (first found and studied in Vietnam veterans) and its impact on society", dateTime: DateUtility.formatDateTimeToString(Date()))
        //        print("heres the path \(path)")
        
        readTask1.addPdfFile {
            // This code block will be executed once the PDF is loaded
//            print("\(readTask1.isFileNil())")
//            print("LOADED FILE: \(readTask1.pdfFile)")
            self.tasksStore.addTask(task: readTask1)
            self.readComplianceStore.addTask(readTask1)
            print("readTaskStore: \(readComplianceStore)")
        }
        
        signTask1.addPdfFile {
            // This code block will be executed once the PDF is loaded
//            print("\(readTask1.isFileNil())")
//            print("LOADED FILE: \(readTask1.pdfFile)")
            self.tasksStore.addTask(task: signTask1)
            self.signComplianceStore.addTask(signTask1)
            print("signTaskStore: \(signComplianceStore)")
        }
 
        
    }
    
}



func dummyText() -> String {
    var dummyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
    return dummyText
}

#Preview {
    ContentView()
}
