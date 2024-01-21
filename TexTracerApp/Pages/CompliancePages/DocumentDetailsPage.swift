import SwiftUI

struct DocumentDetailsPage: View {
    
    @EnvironmentObject var readComplianceDataStore: ReadComplianceDataStore
    var task: ReadDocumentTask
    
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
                                    PDFThumbnailView(pdfURL: filePath, thumbnailSize: CGSize(width: 130, height: 180))
                                }
                            } else {
                                Text("Thumbnail not available")
                            }
                        }
                        
                        VStack(alignment: .center, spacing: 12) {
                            CustomEmptyButton(action: {
                                // Action when button is tapped
                            }) {
                                (Image(systemName: "square.and.arrow.up"), Text("Open in Browser"))
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
                                        Divider()
                                    }
                                    
                                } else {
                                    Text("Error: Document info not available")
                                }
                                
                                
                                
                            }
                            
                        }
                    }
                    
                    //                    CommentSection()
                    VStack {
                        ChatBubble(direction: .left) {
                            Text("Hello!")
                                .padding(.all, 20)
                                .foregroundColor(Color.white)
                                .background(Color.theme.accentColor)
                        }
                        ChatBubble(direction: .right) {
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut semper quam. Phasellus non mauris sem. Donec sed fermentum eros. Donec pretium nec turpis a semper. ")
                                .padding(.all, 20)
                                .foregroundColor(Color.white)
                                .background(Color.theme.accentColor)
                        }
                        ChatBubble(direction: .right) {
                            Image.init("dummyImage")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 70,
                                       height: 200).aspectRatio(contentMode: .fill)
                        }
                    }
                    
                }
                
            }
            
        }
        .navigationTitle("\(task.name)")
        .onAppear {
                    readComplianceDataStore.setCurrentTask(task)
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
