import Foundation

class Task {
    let id: Int
    let receivedDate: Date
    let taskStatus: TaskStatus
    
    init(id: Int, receivedDate: Date) {
        self.id = id
        self.receivedDate = receivedDate
        self.taskStatus = TaskStatus.Incomplete
    }
}
