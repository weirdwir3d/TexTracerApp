import SwiftUI

struct SelectStepsArea: View {
    
    let task: UploadEvidenceTask
    @EnvironmentObject var selectedDataStore: SelectedDataStore
    @Environment(\.presentationMode) var presentationMode
    @Binding var currentArea: Int

    
    var body: some View {
        
        ScrollView {
            Text("For what steps do you want to upload order evidence?")
            
            Chain(task: task)
                .environmentObject(selectedDataStore)
            
            CustomFullButton(action: {
                currentArea = 2
            }) {
                Text("Next")
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        
    }
}

#Preview {
    SelectStepsArea(task:
                        UploadEvidenceTask(
                            id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [
                                OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
                            ]
                        ),
                    currentArea: .constant(1)
    )
    .environmentObject(SelectedDataStore())
}
