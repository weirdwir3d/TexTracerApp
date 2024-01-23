import SwiftUI
import PDFKit

struct ReadDocumentDetailsPage: View {
    
    @EnvironmentObject var readComplianceDataStore: ReadComplianceDataStore
    var task: ReadDocumentTask
    @State private var showPDFViewer = false
    @State private var toast: Toast? = nil
    @State private var navigateToNextPage = false
    @State private var isConfirmationChecked = false
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    HStack {
                        
                        VStack {
                            if let currentTask = readComplianceDataStore.getCurrentTask() {
                                Text("\(currentTask.pdfFileName).pdf")
                            } else {
                                Text("File name not available")
                            }
                            
                            if let filePath = readComplianceDataStore.getCurrentTask()?.filePath {
                                VStack {
                                    PDFThumbnail(pdfURL: filePath, thumbnailSize: CGSize(width: 130, height: 180))
                                }
                            } else {
                                Text("Thumbnail not available")
                            }
                        }
                        
                        VStack(alignment: .center, spacing: 12) {
                            CustomEmptyButton(action: {
                                showPDFViewer.toggle()
                            }) {
                                (Image(systemName: "square.and.arrow.up"), Text("Open"))
                            }
                            
                            CustomEmptyButton(action: {
                                downloadPDF()
                            }) {
                                (Image(systemName: "arrow.down.to.line.compact"), Text("Download"))
                            }
                        }
                        
                    }.padding()
                    
                    //all order info
                    VStack(alignment: .leading) {
                        Text("DOCUMENT INFORMATION").font(.caption).padding(.leading, 16)
                        WhiteBox(paddingAmount: 16, paddingEdges: [.leading, .trailing, .bottom]) {
                            VStack(alignment: .leading) {
                                
                                if let currentTask = readComplianceDataStore.getCurrentTask() {
                                    
                                    //from (client)
                                    Text("From").bold()
                                    Text("\(currentTask.assignerId)")
                                    Divider()
                                    
                                    //date
                                    Text("Date").bold()
                                    Text("\(currentTask.receivedDate)")
                                    Divider()
                                    
                                    //message
                                    if let currentTask = readComplianceDataStore.getCurrentTask(),
                                       let message = currentTask.messageFromSender {
                                        Text("Message").bold()
                                        Text("\(message)")
                                    }
                                    
                                } else {
                                    Text("Error: Document info not available")
                                }
                                
                                
                                
                            }
                            
                        }
                    }
                    
                    
                    CommentSection().environmentObject(readComplianceDataStore)
                    
                }
                
                Spacer().frame(width: 50, height: 20)
                
                Toggle("I confirm I am authorised to give reading confirmation", isOn: $isConfirmationChecked)
                    .toggleStyle(CheckboxToggleStyle())
                    .padding()
                
                CustomFullButton(action: {
                    navigateToNextPage = true
                }) {
                    Text("Reading confirmation")
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(!isConfirmationChecked)
                
                NavigationLink(
                    destination: UserFeedbackPage(), // Replace with the actual destination view
                    isActive: $navigateToNextPage
                ) {
                    EmptyView()
                }
                
            }
            
            
            
        }
        .navigationTitle("\(task.name)")
        .onAppear {
            readComplianceDataStore.setCurrentTask(task)
        }
        .sheet(isPresented: $showPDFViewer) {
            if let filePath = readComplianceDataStore.getCurrentTask()?.filePath {
                PDFViewer(pdfURL: filePath)
            }
        }
    }
    
    private func downloadPDF() {
        guard let currentTask = readComplianceDataStore.getCurrentTask() else {
            print("No current task available.")
            return
        }
        
        guard let pdfPath = currentTask.filePath,
              let pdfData = try? Data(contentsOf: pdfPath) else {
            print("Failed to load PDF data.")
            return
        }

        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            // Create the directory if it doesn't exist
            try FileManager.default.createDirectory(at: documentsDirectory, withIntermediateDirectories: true, attributes: nil)

            let destinationURL = documentsDirectory.appendingPathComponent(currentTask.pdfFileName)
            
            try pdfData.write(to: destinationURL)
            print("PDF downloaded successfully at: \(destinationURL)")
            
            // Show the success toast
            toast = Toast(style: .success, message: "\(currentTask.pdfFileName).pdf downloaded successfully!", width: 400)
            
        } catch {
            print("Failed to save PDF data: \(error.localizedDescription)")
            
            // Show an error toast
            toast = Toast(style: .error, message: "Failed to download PDF.", width: 400)
        }
    }

    
    
    
}

#Preview {
    ReadDocumentDetailsPage(task:
                            ReadDocumentTask(id: UUID(),
                                             receivedDate: Date(),
                                             assignerId: UUID(),
                                             assigneeId: UUID(),
                                             name: "Finestitch Delivery Manual 2023 (v2)",
                                             pdfFileName: "dummyFile",
                                             messageFromSender: dummyText())
                        
    )
    .environmentObject(ReadComplianceDataStore())
}
