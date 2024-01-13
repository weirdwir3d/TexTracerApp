import SwiftUI

struct TaskView: View {
    
    @EnvironmentObject var tasksStore: TasksStore
    let task: Task
    
    var body: some View {
        NavigationLink(destination: SelectStepsPage(task: task as! UploadEvidenceTask)) {
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
}


#Preview {
    NavigationView {
        TaskView(
            task: UploadEvidenceTask(id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: [OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()), OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID())])
        )
            .environmentObject(TasksStore())
    }
}

