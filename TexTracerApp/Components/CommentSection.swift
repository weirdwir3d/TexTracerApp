import SwiftUI
import Combine
//import ReadDocumentTask

struct CommentSection: View {
    
    @EnvironmentObject var signComplianceDataStore: SignComplianceDataStore
    @EnvironmentObject var readComplianceDataStore: ReadComplianceDataStore
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            
            Text("Comments").font(.title3).bold()
            
            if readComplianceDataStore.getCurrentTask()?.getMessages().isEmpty ?? true {
                VStack {
                    Text("No comments yet.")
                        .italic()
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Center the text
                }
            } else {
                ScrollView {
                    VStack {
                        ForEach(readComplianceDataStore.getCurrentTask()?.getMessages() ?? []) { message in
                            ChatBubble(direction: .right, date: DateUtility.formatDateTimeToString(Date())) {
                                Text(message.getContent())
                                    .padding(.all, 20)
                                    .foregroundColor(Color.white)
                                    .background(Color.theme.darkGreyColor)
                            }
                        }
                    }
                }
            }
            
            // Input bar
            CommentTextField().environmentObject(readComplianceDataStore)
            
        }
        .onAppear {
            // No need to initialize messages here
        }
        .padding(.bottom, keyboardHeight)
        .onReceive(readComplianceDataStore.getCurrentTask()!.$messages) { _ in
            // Update messages when the data store messages change
        }
        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}


extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}



#Preview {
    CommentSection()
        .environmentObject(ReadComplianceDataStore())
}
