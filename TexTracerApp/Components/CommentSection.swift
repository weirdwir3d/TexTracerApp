import SwiftUI

struct CommentSection: View {
    
    //
    
    var body: some View {
        
        
        Text("Comments").font(.title3).bold()
        
        
        
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
//            ChatBubble(direction: .right) {
//                Image.init("dummyImage.pdf")
//                    .resizable()
//                    .frame(width: UIScreen.main.bounds.width - 70,
//                           height: 200).aspectRatio(contentMode: .fill)
//            }
            
            
        }
        
        //inputbar
        CommentTextField()
        
    }
}

#Preview {
    CommentSection()
}
