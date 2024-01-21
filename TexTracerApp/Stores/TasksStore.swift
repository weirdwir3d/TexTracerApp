import Foundation

class TasksStore: ObservableObject, CustomStringConvertible {
    @Published var tasks: [Task] = []

    func getTasks() -> [Task] {
        return tasks
    }

    func addTask(task: Task) {
        self.tasks.append(task)
    }

    func getTaskByIndex(index: Int) -> Task {
        return tasks[index]
    }

    var description: String {
        return """
        TasksStore:
          - Tasks: \(tasks)
        """
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

        let readDocumentTaskTest = Task.readDocumentTaskTest // Include the read document task
        
        tasksStore.addTask(task: uploadTaskTest)
        tasksStore.addTask(task: uploadTaskTest2)
        tasksStore.addTask(task: uploadTaskTest3)
        
        tasksStore.addTask(task: reviewTaskTest)
        tasksStore.addTask(task: reviewTaskTest2)
        
        tasksStore.addTask(task: readDocumentTaskTest) // Add the read document task
        
        return tasksStore
    }
}


