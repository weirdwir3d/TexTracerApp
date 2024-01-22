import SwiftUI
import PDFKit

struct DocumentDetailsPage: View {
    
    @EnvironmentObject var readComplianceDataStore: ReadComplianceDataStore
    var task: ReadDocumentTask
    @State private var showPDFViewer = false
    
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
                                //TODO: this does not work
                                showPDFViewer.toggle()
                            }) {
                                (Image(systemName: "square.and.arrow.up"), Text("Open"))
                            }
                            
                            CustomEmptyButton(action: {
                                // Action when button is tapped
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
                
                CustomFullButton(action: {
                }) {
                    Text("Reading confirmation")
                }
                .buttonStyle(PlainButtonStyle())
                
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
    
}

#Preview {
    DocumentDetailsPage(task:
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
