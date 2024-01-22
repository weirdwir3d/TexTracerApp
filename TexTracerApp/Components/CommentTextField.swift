import SwiftUI
import Combine

struct CommentTextField: View {
    @EnvironmentObject var readComplianceDataStore: ReadComplianceDataStore
    @State private var messageText: String = ""

    var body: some View {
        VStack {
            List(readComplianceDataStore.getCurrentTask()?.getMessages() ?? [], id: \.self) { message in
                ChatBubble(direction: .right, date: message.dateTime) {
                    Text(message.content)
                        .padding(.all, 20)
                        .foregroundColor(Color.white)
                        .background(Color.theme.darkGreyColor)
                }
            }

            HStack {
                VStack {
                    TextField("Type a comment", text: $messageText)
                        .modifier(KeyboardAdaptive())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 42)
                }
                .onTapGesture {
                    self.endEditing()
                }

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
                    .stroke(Color.theme.lightGreyColor, lineWidth: 2)
            )
            .padding(.horizontal)
        }
        .onAppear {
            // Fetch initial messages when the view appears
            refreshMessages()
        }
    }

    // Function to refresh messages from the environment object
    func refreshMessages() {
        // Use the environment object to get messages and update the local state
        let currentTask = readComplianceDataStore.getCurrentTask()
        if let messages = currentTask?.getMessages() {
            currentTask?.setMessages(messages)
        }
    }

    func sendMessage() {
        guard !messageText.isEmpty else { return }
        let newMessage = Message(content: messageText, dateTime: DateUtility.formatDateTimeToString(Date()))
        readComplianceDataStore.getCurrentTask()?.addMessage(content: messageText, dateTime: DateUtility.formatDateTimeToString(Date()))
        messageText = ""

        // After sending a message, refresh the view
        refreshMessages()
    }
}


extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct KeyboardAdaptive: ViewModifier {
    @ObservedObject private var keyboard = KeyboardResponder()

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboard.currentHeight)
            .animation(.easeOut(duration: 0.16))
    }
}

final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0

    var keyboardWillShowNotification = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
    var keyboardWillHideNotification = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)

    init() {
        keyboardWillShowNotification.map { notification in
            CGFloat((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0)
        }
        .assign(to: \.currentHeight, on: self)
        .store(in: &cancellableSet)

        keyboardWillHideNotification.map { _ in
            CGFloat(0)
        }
        .assign(to: \.currentHeight, on: self)
        .store(in: &cancellableSet)
    }

    private var cancellableSet: Set<AnyCancellable> = []
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextField()
            .environmentObject(ReadComplianceDataStore())
    }
}
