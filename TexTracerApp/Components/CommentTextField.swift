import SwiftUI

struct CommentTextField: View {
    @State private var messageText: String = ""
    @State private var messages: [String] = []
    
    var body: some View {
        VStack {
            List(messages, id: \.self) { message in
                Text(message)
            }
            
            HStack {
                TextField("Type a comment", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 42)
                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .padding(.horizontal, 2)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.theme.lightGreyColor, lineWidth: 2) // Set the border color and width here
            )
            .padding(.horizontal)
            
        }
    }
    
    func sendMessage() {
        guard !messageText.isEmpty else { return }
        messages.append(messageText)
        messageText = ""
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextField()
    }
}
