import SwiftUI

struct TaskDetailView: View {
    
    @State private var isChecked: Bool = false
    @State private var toggledSteps: [String] = []
    @State private var selectedOrders: Set<String> = Set()
    
    
    @EnvironmentObject var tasksStore: TasksStore
    @EnvironmentObject var selectedDataStore: SelectedDataStore
    
    let task: Task
    let orders = [
        Order(code: "FFA534", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA535", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA536", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA537", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA538", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
        Order(code: "FFA539", orderlineId: UUID(), styleNumber: "AW23D001", contractualPartner: ContractualPartner(id: UUID(), registrationNr: 3, name: "Best Partner"), brand: Brand(id: UUID(), registrationNr: 1, name: "Zara")),
    ]
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    OrderDetailsArea(task: task)
                    
                    Spacer().frame(height: 26)
                    
                    Text("Multiple orders share these steps. You can select them below to upload the same order evidence for all of them.")
                    
                    
                    VStack(alignment: .leading) {
                        
                        Toggle(isOn: Binding(
                            get: {
                                selectedOrders.count == orders.count
                            },
                            set: { newValue in
                                if newValue {
                                    selectedOrders = Set(orders.map { $0.code })
                                } else {
                                    selectedOrders.removeAll()
                                }
                                print("Selected Orders: \(selectedOrders)")
                            }
                        )) {
                            Text("Select All")
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        ForEach(orders) { order in
                            Toggle(isOn: Binding(
                                get: { selectedOrders.contains(order.code) },
                                set: { newValue in
                                    if newValue {
                                        selectedOrders.insert(order.code)
                                    } else {
                                        selectedOrders.remove(order.code)
                                    }
                                    print("Selected Orders: \(selectedOrders)")
                                }
                            )) {
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
                    
                    
                    if let uploadEvidenceTask = task as? UploadEvidenceTask {
                        var orderSteps = uploadEvidenceTask.orderSteps
                        ForEach(orderSteps) { orderStep in
                            StepSwitch(
                                text: orderStep.step.stringValue,
                                isToggled: Binding(
                                    get: { toggledSteps.contains(orderStep.step.stringValue) },
                                    set: { newValue in
                                        if newValue && !toggledSteps.contains(orderStep.step.stringValue) {
                                            toggledSteps.append(orderStep.step.stringValue)
                                            print("Step \(orderStep.step.stringValue) added. Toggled steps: \(toggledSteps)")
                                        } else if !newValue {
                                            toggledSteps.removeAll { $0 == orderStep.step.stringValue }
                                            print("Step \(orderStep.step.stringValue) removed. Toggled steps: \(toggledSteps)")
                                        }
                                    }
                                ), onToggle: {}
                            )
                        }
                        
                        //                        NavigationLink(
                        //                            destination: UploadEvidenceView(),
                        //                            isActive: $isUploadEvidenceViewActive,
                        //                            label: {
                        //                                EmptyView() // An invisible view to trigger the navigation
                        //                            })
                        //                        .hidden() // Hide the navigation link
                        
                        
                    }
                    
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
        .environmentObject(TasksStore.test)
}


