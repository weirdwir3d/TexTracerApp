import Foundation

class ReadComplianceDataStore: ObservableObject, CustomStringConvertible {
    @Published private var tasks: [ReadDocumentTask] = []
    @Published private var currentTask: ReadDocumentTask?

    // MARK: - Getters

    func getTasks() -> [ReadDocumentTask] {
        return tasks
    }

    func getCurrentTask() -> ReadDocumentTask? {
        return currentTask
    }

    // MARK: - Add Tasks

    func addTasks(_ newTasks: [ReadDocumentTask]) {
        tasks.append(contentsOf: newTasks)
    }

    func addTask(_ newTask: ReadDocumentTask) {
        tasks.append(newTask)
    }

    // MARK: - Set Current Task

    func setCurrentTask(_ task: ReadDocumentTask?) {
        DispatchQueue.main.async {
            self.currentTask = task
        }
    }

    var description: String {
        return """
        ReadComplianceDataStore:
          - Tasks: \(tasks)
          - Current Task: \(currentTask?.description ?? "None")
        """
    }
}



