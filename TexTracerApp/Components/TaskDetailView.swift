import SwiftUI

struct TaskDetailView: View {
    
    @State private var isChecked: Bool = false
    
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
    
    @State private var isUploadEvidenceViewActive = false

        var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        OrderEvidenceDetailBox(task: task)
                        
                        Spacer().frame(height: 26)
                        
                        Text("Multiple orders share these steps. You can select them below to upload the same order evidence for all of them.")
                            .padding()
                        
                        VStack {
                            ForEach(orders) { order in
                                Toggle(isOn: $isChecked) {
                                    HStack(spacing: 90) {
                                        Text(order.code)
                                        Text(order.styleNumber)
                                    }
                                    
                                }
                                .toggleStyle(CheckboxToggleStyle())
                                Divider()
                            }
                            
                        }
                            
                        Text("Do any of these steps share the same order evidence?")
                            .padding()
                        
                        var orderSteps = task.orderSteps
                        ForEach(orderSteps) { orderStep in
                            StepSwitch(text: orderStep.step.stringValue)
                        }

                        NavigationLink(
                            destination: UploadEvidenceView(),
                            isActive: $isUploadEvidenceViewActive,
                            label: {
                                EmptyView() // An invisible view to trigger the navigation
                            })
                            .hidden() // Hide the navigation link

                        CustomButton(action: {
                            // Activate the navigation link
                            isUploadEvidenceViewActive = true
                        }) {
                            Text("Upload evidence")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .environmentObject(tasksStore)
            }
        }
    }


#Preview {
    
        TaskDetailView(
            task: UploadEvidenceTask(
                id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [
                    OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
                ]
            )
        )
        .environmentObject(TasksStore())
}


