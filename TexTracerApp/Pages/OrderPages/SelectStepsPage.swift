import SwiftUI

struct SelectStepsPage: View {
    
    let task: UploadEvidenceTask
    @StateObject var selectedDataStore = SelectedDataStore()
    @Environment(\.presentationMode) var presentationMode
    @State private var isNextPageActive: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                Text("For what steps do you want to upload order evidence?")
                
                Chain(task: task)
                    .environmentObject(selectedDataStore)
                
                CustomFullButton(action: {
                    print("Selected order Steps: \(selectedDataStore.getSelectedSteps())")
                    isNextPageActive = true
                }) {
                    Text("Next")
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer().frame(height: 20)
                
                CustomUnderlinedText(text: "Back to all orders") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
            NavigationLink(
                destination: SelectSameEvidenceStepsPage().environmentObject(selectedDataStore),
                isActive: $isNextPageActive,
                label: {
                    EmptyView()
                }
            )
        }
        .onAppear {
            selectedDataStore.addTask(task)
            // Add the order steps to the SelectedDataStore when the view appears
            selectedDataStore.addAllOrderSteps(task.orderSteps)
            print("All Order Steps in selectedDataStore: \(selectedDataStore.getAllOrderSteps())")
            
            // Set the navigation bar title directly
            UINavigationBar.appearance().topItem?.title = "All orders"
        }
    }
}





#Preview {
    SelectStepsPage(task:
                        UploadEvidenceTask(
                            id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [
                                OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
                            ]
                        )
    )
    .environmentObject(TasksStore.test)
}
