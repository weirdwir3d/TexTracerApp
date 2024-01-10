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

extension TasksStore {
    
    static var test: TasksStore {
        
        var tasksStore = TasksStore()
        
        // Create and add tasks to the store
        let uploadTaskTest = Task.uploadTaskTest
        let uploadTaskTest2 = Task.uploadTaskTest
        let uploadTaskTest3 = Task.uploadTaskTest
        
        let reviewTaskTest = Task.reviewTaskTest
        let reviewTaskTest2 = Task.reviewTaskTest
        
        tasksStore.addTask(task: uploadTaskTest)
        tasksStore.addTask(task: uploadTaskTest2)
        tasksStore.addTask(task: uploadTaskTest3)
        
        tasksStore.addTask(task: reviewTaskTest)
        tasksStore.addTask(task: reviewTaskTest2)
        
        return tasksStore
    }
}
