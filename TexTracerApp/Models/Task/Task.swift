import Foundation

class Task: Identifiable, ObservableObject, Hashable {
    let id: UUID
    let receivedDate: String
    let taskStatus: TaskStatus
    var description: String
    var orderCode: String? // Optional field

    init(id: UUID, receivedDate: Date, orderCode: String? = nil) {
        self.id = id
        self.receivedDate = DateUtility.formatDateTimeToString(receivedDate)
        self.description = ""
        self.taskStatus = TaskStatus.Incomplete
        self.orderCode = orderCode
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }

    // Getter function for receivedDate
    func getReceivedDate() -> String {
        return receivedDate
    }

    // Getter function for taskStatus
    func getTaskStatus() -> TaskStatus {
        return taskStatus
    }

    // Getter function for description
    func getDescription() -> String {
        return description
    }

    // Getter function for orderCode
    func getOrderCode() -> String? {
        return orderCode
    }
    
    func toString() -> String {
            var result = "Task Details:\n"
            result += "ID: \(id)\n"
            result += "Received Date: \(receivedDate)\n"
            result += "Task Status: \(taskStatus)\n"
            result += "Description: \(description)\n"
            result += "Order Code: \(orderCode ?? "N/A")\n"
            return result
        }
    
}

extension Task {
    static var uploadTaskTest: Task {

        let orderSteps = [OrderStep(id: UUID(), step: Step.Dyeing, supplierId: UUID()),
                          OrderStep(id: UUID(), step: Step.Tanning, supplierId: UUID()),
                          OrderStep(id: UUID(), step: Step.FabricTrading, supplierId: UUID()),
                          OrderStep(id: UUID(), step: Step.DesignAndDevelopment, supplierId: UUID()),
                          OrderStep(id: UUID(), step: Step.Printing, supplierId: UUID()),
        ]

        return UploadEvidenceTask(id: UUID(), receivedDate: Date(), orderCode: "FFA534", assignerId: UUID(), assigneeId: UUID(), orderSteps: orderSteps)
    }

    static var reviewTaskTest: Task {

        let orderSteps = [OrderStep(id: UUID(), step: Step.Harvesting, supplierId: UUID()),
                          OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID())
        ]

        return ReviewEvidenceTask(id: UUID(), receivedDate: Date(), orderCode: "TQX276", assignerId: UUID(), assigneeId: UUID(), orderSteps: orderSteps)
    }
    
    static var readDocumentTaskTest: Task {
            let pdfFileName = "dummyFile"

            if let pdfPath = Bundle.main.path(forResource: pdfFileName, ofType: "pdf"),
               let pdfData = try? Data(contentsOf: URL(fileURLWithPath: pdfPath)) {
                return ReadDocumentTask(
                    id: UUID(),
                    receivedDate: Date(),
                    assignerId: UUID(),
                    assigneeId: UUID(),
                    name: "Delivery Manual 2023 (v3)",
                    pdfFileName: pdfFileName,
                    messageFromSender: dummyText()
                )
            } else {
                fatalError("Unable to load the PDF file.")
            }
        }
    
    static var signDocumentTaskTest: Task {
            let pdfFileName = "PinocchioFile"

            if let pdfPath = Bundle.main.path(forResource: pdfFileName, ofType: "pdf"),
               let pdfData = try? Data(contentsOf: URL(fileURLWithPath: pdfPath)) {
                return ReadDocumentTask(
                    id: UUID(),
                    receivedDate: Date(),
                    assignerId: UUID(),
                    assigneeId: UUID(),
                    name: "Delivery Manual 2023 (v3)",
                    pdfFileName: pdfFileName,
                    messageFromSender: dummyText()
                )
            } else {
                fatalError("Unable to load the PDF file.")
            }
        }
}
