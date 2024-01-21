import Foundation
import PDFKit

class ReadDocumentTask: Task {
    let assignerId: UUID
    let assigneeId: UUID
    let name: String
    let pdfFileName: String
    var pdfFile: Data?
    var filePath: URL?
    var messageFromSender: String?
//    var pdfView = PDFView()
    
    init(id: UUID, receivedDate: Date, assignerId: UUID, assigneeId: UUID, name: String, pdfFileName: String, messageFromSender: String?) {
        self.assignerId = assignerId
        self.assigneeId = assigneeId
        self.name = name
        self.pdfFileName = pdfFileName
        self.messageFromSender = messageFromSender
//        self.pdfFile = nil  // Initialize to nil

        super.init(id: id, receivedDate: receivedDate)
        self.description = "Read \(name)"
        
        self.filePath = generateFilePath(fileName: pdfFileName)
        
//        addPdfFile {
//            // This code block will be executed once the PDF is loaded
//            print("\(self.isFileNil())")
//        }
    }
    
//    func loadPdf() {
//        guard let url = Bundle.main.url(forResource: pdfFileName, withExtension: "pdf") else {
//            return
//        }
//        
//        guard let document = PDFDocument(url: url) else {
//            return
//        }
//        
//        self.pdfView.document = document
    //    }
    
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
    
    // Function to add the PDF file later
//    func addPdfFile() {
//        DispatchQueue.global().async { [self] in
//            if let pdfPath = Bundle.main.url(forResource: pdfFileName, withExtension: "pdf") {
//                print("PDF path: \(pdfPath)")
//                if let pdfData = try? Data(contentsOf: pdfPath) {
//                    DispatchQueue.main.async {
//                        self.pdfFile = pdfData
//                        print("PDF loaded successfully")
//                    }
//                } else {
//                    print("Failed to load PDF data")
//                }
//            } else {
//                print("PDF file not found in bundle")
//            }
//        }
//    }


    
    func isFileNil() -> Bool {
        return pdfFile == nil
    }
//}
//
//class PDFLoader {
//    static func loadPDF() -> Data? {
//        // Replace "example" with the name of your PDF file (without the file extension)
//        if let pdfPath = Bundle.main.url(forResource: "dummyFile", withExtension: "pdf") {
//            do {
//                let pdfData = try Data(contentsOf: pdfPath)
//                return pdfData
//            } catch {
//                print("Error loading PDF data: \(error)")
//            }
//        } else {
//            print("PDF file not found in bundle.")
//        }
//        return nil
//    }
}





