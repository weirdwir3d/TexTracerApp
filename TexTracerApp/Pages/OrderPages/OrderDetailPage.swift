import SwiftUI

struct OrderDetailPage: View {
    
    @State private var isChecked: Bool = false
    
    let task: Task
    let orders = [
        Order(code: "FFA534", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA535", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA536", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA537", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA538", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA539", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
    ]
    
    @State private var isUploadEvidenceViewActive = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TaskDetailView(task: task)
                    
                    Chain(task: task)
                    //TODO: CREATE ORDER EVIDENCE GLOBAL STORE, SO YOU CAN KEEP TRACK OF ALL ORDERS AND STEPS SELECTED ACROSS THE WHOLE APP AFTER CLICKING ON UPLOAD EVIDENCE
                    CustomFullButton(action: {
                        // Activate the navigation link
                        isUploadEvidenceViewActive = true
                    }) {
                        Text("Upload evidence")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
                //TODO: i dont necessarily wanna see the title
                .navigationBarTitle("Order \(task.orderCode!)", displayMode: .inline)
                
            }
        }
        .padding()
        
        
    }
}

#Preview {
    OrderDetailPage(task: Task.uploadTaskTest)
        .environmentObject(TasksStore.test)
}

