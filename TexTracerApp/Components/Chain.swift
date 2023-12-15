import SwiftUI

struct Chain: View {
    let task: UploadEvidenceTask

    var body: some View {
        VStack {
            generateChain()
        }
    }

    func generateChain() -> some View {

        return VStack(spacing: 0) {
            ChainLinks(orderSteps: task.orderSteps)
            }
        }
    }



#Preview {
    Chain(task: UploadEvidenceTask(
        id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [
            OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()),
            OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()),
            OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()),
            OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
        ]
    ))
}
