import SwiftUI

struct TasksPage: View {
    
    @EnvironmentObject var tasksStore: TasksStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasksStore.getTasks()) { task in
                    TaskView(task: task)
                  }
                }
        }
        .navigationTitle("Tasks")
    }
}

#Preview {
    NavigationView {
                TasksPage()
                    .environmentObject(TasksStore())
            }
}
