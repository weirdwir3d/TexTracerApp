import SwiftUI

struct ChatBubble<Content>: View where Content: View {
    let direction: ChatBubbleShape.Direction
    let content: () -> Content
    let date: String  // Add a property for date
    init(direction: ChatBubbleShape.Direction, date: String, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.direction = direction
        self.date = date
    }
    
    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            
            VStack {
                HStack{
                    Spacer()
                    content().clipShape(ChatBubbleShape(direction: direction))
                }
                
                
                HStack {
                    Spacer()  // Pushes the text to the right
                    Text(date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            if direction == .left {
                Spacer()
            }
        }
        .padding([(direction == .left) ? .leading : .trailing, .top, .bottom], 6)
        .padding((direction == .right) ? .leading : .trailing, 50)
    }
}

#Preview {
    ChatBubble(direction: .right, date: DateUtility.formatDateTimeToString(Date())) {
        Text("Hello friend")
            .padding(.all, 20)
            .foregroundColor(Color.white)
            .background(Color.theme.darkGreyColor)
    }
}

