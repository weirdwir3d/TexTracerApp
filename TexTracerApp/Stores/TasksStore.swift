import Foundation

@MainActor
class TasksStore: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    func getTasks() -> [Task] {
        let tasksCopy = self.tasks
        return self.tasks
    }
    
    func addTask(task: Task) {
        self.tasks.append(task)
    }
}
