import SwiftUI

struct TaskDetailView: View {
    
    @EnvironmentObject var tasksStore: TasksStore
    let task: UploadEvidenceTask
    let orders = [
        Order(code: "FFA534", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA535", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA536", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA537", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA538", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA539", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                OrderEvidenceDetailBox(task: task)
                
                Spacer().frame(height: 26)
                
                Text("Multiple orders share these steps. You can select them below to upload the same order evidence for all of them.")
                    .padding()
                
                // get orders belonging to the same orderline and having the same steps
                
                List {
                    ForEach(orders) { order in
                        Text(order.code)
                    }
                }
                .onAppear {
                    for order in orders {
                        print(order.code)
                    }
                }
                
                
                
                CustomButton(text: Text("Upload evidence"))
            }
        }
        .environmentObject(tasksStore)
    }
}

#Preview {
    NavigationView {
        TaskDetailView(
            task: UploadEvidenceTask(
                id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [
                    OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
                ]
            )
        )
        .environmentObject(TasksStore())
    }
}


