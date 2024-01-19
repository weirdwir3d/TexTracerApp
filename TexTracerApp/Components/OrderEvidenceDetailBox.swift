import SwiftUI

struct OrderEvidenceDetailBox<T: Task>: View {
    
    let task: T
    
    var body: some View {
        NavigationLink(destination: OrderDetailsPage(task: task as! UploadEvidenceTask)) {
//        NavigationLink(destination: OrderDetailPage(task: task)) {
            WhiteBox {
                VStack {
                    OrderDetailsArea(task: task)
                    Chain(task: task)
                }
                
            }
        }
        
    }
}

#Preview {
    OrderEvidenceDetailBox(task: Task.uploadTaskTest)
}
