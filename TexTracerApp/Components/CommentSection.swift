import SwiftUI

struct CommentSection: View {
    
    var body: some View {
        
        
        Text("Comments").font(.title3).bold()
        
        //inputbar
        CommentTextField()
        
    }
}

#Preview {
    CommentSection()
}
