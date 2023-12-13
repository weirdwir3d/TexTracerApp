import Foundation

class Task: Identifiable, ObservableObject, Hashable {
    let id: UUID
    let receivedDate: Date
    let taskStatus: TaskStatus
    var description: String
    
    init(id: UUID, receivedDate: Date) {
        self.id = id
        self.receivedDate = receivedDate
        self.description = ""
        self.taskStatus = TaskStatus.Incomplete
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}

