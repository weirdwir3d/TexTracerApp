import SwiftUI

struct TaskView: View {
    
    @EnvironmentObject var signComplianceDataStore: SignComplianceDataStore
    @EnvironmentObject var readComplianceDataStore: ReadComplianceDataStore
    @EnvironmentObject var tasksStore: TasksStore
    let task: Task
    
    var body: some View {
        NavigationLink(destination: destinationForTask()) {
            HStack {
                Text(task.description)
                    .font(.subheadline)
                    .lineLimit(2)
                Spacer()
            }
            .padding(.vertical, 8)
        }
        .environmentObject(tasksStore)
    }
    
    private func destinationForTask() -> some View {
        if let uploadTask = task as? UploadEvidenceTask {
            return AnyView(OrderDetailsPage(task: uploadTask))
        } else if let readTask = task as? ReadDocumentTask {
            // Handle other task types
            readComplianceDataStore.setCurrentTask(readTask)
            return AnyView(ReadDocumentDetailsPage(task: readTask).environmentObject(readComplianceDataStore))
        } else if let signTask = task as? SignDocumentTask {
            // Handle other task types
            signComplianceDataStore.setCurrentTask(signTask)
            return AnyView(SignDocumentDetailsPage(task: signTask).environmentObject(signComplianceDataStore))
        } else {
            // Default destination or handle other cases
            return AnyView(ErrorTaskView())
        }
    }

    
}




#Preview {
    NavigationView {
        TaskView(
            task: UploadEvidenceTask(id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID())])
        )
            .environmentObject(TasksStore())
            .environmentObject(ReadComplianceDataStore())
            .environmentObject(SignComplianceDataStore())
    }
}

