import Foundation
import PDFKit

class SignDocumentTask: Task {
    let assignerId: UUID
    let assigneeId: UUID
    let name: String
    let pdfFileName: String
    var pdfFile: Data?
    var filePath: URL?
    var messageFromSender: String?
    @Published var messages: [Message] = []
    let signDeadline: String
//    var pdfView = PDFView()
    
    init(id: UUID, receivedDate: Date, assignerId: UUID, assigneeId: UUID, name: String, pdfFileName: String, messageFromSender: String?, signDeadline: String) {
        self.assignerId = assignerId
        self.assigneeId = assigneeId
        self.name = name
        self.pdfFileName = pdfFileName
        self.messageFromSender = messageFromSender
        self.signDeadline = signDeadline

        super.init(id: id, receivedDate: receivedDate)
        self.description = "Sign \(name)"
        
        self.filePath = generateFilePath(fileName: pdfFileName)
        
    }
    
    func setMessages(_ newMessages: [Message]) {
        messages = newMessages
    }
    
    func getMessages() -> [Message] {
            return messages
        }
        
        func addMessage(content: String, dateTime: String) {
            let newMessage = Message(content: content, dateTime: dateTime)
            messages.append(newMessage)
        }
        
        func addMessages(_ newMessages: [Message]) {
            messages.append(contentsOf: newMessages)
        }
    
    func generateFilePath(fileName: String) -> URL? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "pdf") else {
            return nil
        }
        
        return url
    }
    
    func addPdfFile(completion: @escaping () -> Void) {
        DispatchQueue.global().async { [self] in
            if let pdfPath = Bundle.main.url(forResource: pdfFileName, withExtension: "pdf") {
//                print("PDF path: \(pdfPath)")
                if let pdfData = try? Data(contentsOf: pdfPath) {
                    DispatchQueue.main.async {
                        self.pdfFile = pdfData
                        print("PDF loaded successfully")
                        completion() // Call the completion handler here
                    }
                } else {
                    print("Failed to load PDF data")
                }
            } else {
                print("PDF file not found in bundle")
            }
        }
    }
    
    func isFileNil() -> Bool {
        return pdfFile == nil
    }

}
