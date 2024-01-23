import SwiftUI

struct SignDocumentDetailBox: View {
    
    @EnvironmentObject var signComplianceDataStore : SignComplianceDataStore
    var task: SignDocumentTask
    
    var body: some View {
        NavigationLink(destination: SignDocumentDetailsPage(task: task).environmentObject(signComplianceDataStore)) {
            WhiteBox {
                HStack {
                    
                    if let filePath = task.filePath {
                        PDFThumbnail(pdfURL: filePath, thumbnailSize: CGSize(width: 60, height: 90))
                    } else {
                        Text("Thumbnail not available")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("\(task.name)").fontWeight(.bold)
                        Text("H&M")
                            .font(.subheadline)
                            .italic()
                        //                        .foregroundColor(Color.theme.darkGreyColor)
                    }
                    
                    VStack {
                        if let convertedDateString = DateUtility.convertDateTimeToDateString(task.getReceivedDate()) {
                            Text(convertedDateString).font(.caption)
                                .italic()
                        } else {
                            Text("No date")
                        }
                        Spacer().frame(width: 1, height: 76)
                        
                    }
                    
                    
                }
                
            }
        }
    }
}

#Preview {
    ReadDocumentDetailBox(task:
                        ReadDocumentTask(id: UUID(),
                                         receivedDate: Date(),
                                         assignerId: UUID(),
                                         assigneeId: UUID(),
                                         name: "Finestitch Delivery Manual 2023 (v2)",
                                         pdfFileName: "dummyFile",
                                         messageFromSender: dummyText()
                                        )
    )
}
