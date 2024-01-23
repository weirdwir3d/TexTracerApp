import Foundation

class SignComplianceDataStore: ObservableObject, CustomStringConvertible {
    @Published private var tasks: [SignDocumentTask] = []
    @Published private var currentTask: SignDocumentTask?

    // MARK: - Getters

    func getTasks() -> [SignDocumentTask] {
        return tasks
    }

    func getCurrentTask() -> SignDocumentTask? {
        return currentTask
    }

    // MARK: - Add Tasks

    func addTasks(_ newTasks: [SignDocumentTask]) {
        tasks.append(contentsOf: newTasks)
    }

    func addTask(_ newTask: SignDocumentTask) {
        tasks.append(newTask)
    }

    // MARK: - Set Current Task

    func setCurrentTask(_ task: SignDocumentTask?) {
        DispatchQueue.main.async {
            self.currentTask = task
        }
    }

    var description: String {
        return """
        SignComplianceDataStore:
          - Tasks: \(tasks)
          - Current Task: \(currentTask?.description ?? "None")
        """
    }
}
