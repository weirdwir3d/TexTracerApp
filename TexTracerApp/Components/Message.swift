import SwiftUI

struct Message: View {
    
    var content: String
    let dateTime: Date
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    if let readDocumentTask = Task.readDocumentTaskTest as? ReadDocumentTask {
            Message(
                content: dummyText(),
                dateTime: Date()
            )
        } else {
            // Handle the case where the conversion is not successful
            Text("Error: Unable to convert Task to ReadDocumentTask")
        }
}
