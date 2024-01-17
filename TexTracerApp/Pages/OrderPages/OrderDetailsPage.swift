import SwiftUI

struct OrderDetailsPage: View {
    
    let task: UploadEvidenceTask
    @StateObject var selectedDataStore = SelectedDataStore()
    @Environment(\.presentationMode) var presentationMode
    @State var currentArea = 1
    
    let orders = [Order.test, Order.test2, Order.test3]
    
    var body: some View {
        VStack {
            Group {
                if currentArea == 1 {
                    SelectStepsArea(task: task, currentArea: $currentArea)
                } else if currentArea == 2 {
                    SelectSameStepsArea(currentArea: $currentArea)
                } else if currentArea == 3 {
                    SelectOrdersArea(currentArea: $currentArea)
                }
            }
            .environmentObject(selectedDataStore)
        }
        .onAppear {
            selectedDataStore.addTask(task)
            // Add the order steps to the SelectedDataStore when the view appears
            selectedDataStore.addAllOrderSteps(task.orderSteps)
            //TODO: add test orders
            selectedDataStore.addOrders(orders)
//            print("All Order Steps in selectedDataStore: \(selectedDataStore.getAllOrderSteps())")
            
            // Set the navigation bar title directly
            UINavigationBar.appearance().topItem?.title = "All orders"
        }
    }
}


#Preview {
    OrderDetailsPage(task:
                        UploadEvidenceTask(
                            id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [
                                OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
                            ]
                        )
    )
    .environmentObject(TasksStore.test)
}
