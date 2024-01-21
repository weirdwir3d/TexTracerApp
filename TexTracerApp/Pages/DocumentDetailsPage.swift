import SwiftUI

struct DocumentDetailsPage: View {
    
    var task: ReadDocumentTask
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    HStack {
                        
                        VStack {
                            Text("\(task.pdfFileName).pdf")
                            
                            VStack {
                                PDFThumbnailView(pdfURL: task.filePath!, thumbnailSize: CGSize(width: 130, height: 180))
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
                        WhiteBox(paddingAmount: 8, paddingEdges: [.leading, .trailing, .bottom]) {
                            VStack(alignment: .leading) {
                                
                                //from (client)
                                Text("From").bold()
                                Text("\(task.assignerId)")
                                Divider()
                                
                                //date
                                Text("Date").bold()
                                Text("\(task.receivedDate)")
                                Divider()
                                
                                //message
                                if let message = task.message {
                                    Text("Message").bold()
                                    Text("\(message)")
                                    Divider()
                                }
                                
                            }
                            
                        }
                    }
                    
                    CommentSection()
                    
                }
                
            }
            
        }.navigationTitle(task.name)
        
    }
}

#Preview {
    DocumentDetailsPage(task: Task.readDocumentTaskTest as! ReadDocumentTask)
}
