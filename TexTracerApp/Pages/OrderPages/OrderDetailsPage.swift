import SwiftUI

struct OrderDetailsPage: View {
    
    let task: UploadEvidenceTask
    @StateObject var selectedDataStore = DataStore()
    @Environment(\.presentationMode) var presentationMode
    @State var currentArea = 1
    
    let orders = [Order.test, Order.test2, Order.test3]
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    if currentArea == 1 {
                        SelectStepsArea(task: task, currentArea: $currentArea)
                    } else if currentArea == 2 {
                        SelectSameStepsArea(currentArea: $currentArea)
                    } else if currentArea == 3 {
                        SelectSameOrdersArea(currentArea: $currentArea)
                    }
                }
                .environmentObject(selectedDataStore)
            }
            .onAppear {
                selectedDataStore.addCurrentTask(task)
                // Add the order steps to the SelectedDataStore when the view appears
                selectedDataStore.addAllOrderSteps(task.orderSteps)
                // add test orders
                selectedDataStore.addOrders(orders)
                //            print("All Order Steps in selectedDataStore: \(selectedDataStore.getAllOrderSteps())")
            }
        }
        .navigationBarTitle("Order details", displayMode: .inline)
        
    }
}


#Preview {
    OrderDetailsPage(task:
                        UploadEvidenceTask(
                            id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [
                                OrderStep(id: UUID(), step: Step.Dyeing, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Tanning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.FabricTrading, supplierId: UUID()), OrderStep(id: UUID(), step: Step.DesignAndDevelopment, supplierId: UUID())
                            ]
                        )
    )
    .environmentObject(TasksStore.test)
}
