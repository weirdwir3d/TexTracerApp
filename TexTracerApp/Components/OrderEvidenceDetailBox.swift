import SwiftUI

struct OrderEvidenceDetailBox: View {
    
    @State private var isBlinking = false
    
    let task: UploadEvidenceTask
    
    var body: some View {
        
        WhiteBox {
            VStack(spacing: 0) {
                //Red icon, title and date block next to assigned by block
                HStack {
                    HStack {
                        OrderBadge(number: 5)
                        VStack {
                            Text("Order \(task.orderCode)")
                            Text("date: \(task.receivedDate)")
                        }
                    }
                    Spacer()
                    Text("by: \(task.assignerId)")
                }
                
                Spacer().frame(height: 20)
                
                HStack {
                    VStack {
                        Text("Style number:")
                        Text("Delivery to:")
                        Text("Final client:")
                    }
                    
                    Spacer()
                }
                
                Spacer().frame(height: 26)
                
                Chain(task: task)
                
            }
        }
        
    }
}

#Preview {
    OrderEvidenceDetailBox(task: UploadEvidenceTask(
        id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [
            OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
        ]
    )
    )
}
