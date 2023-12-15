import SwiftUI

struct OrderEvidencePage: View {
    var body: some View {
        
        NavigationStack{
            
            Text("Order evidence")
            
        }.navigationTitle("Order evidence")
        
    }
}

#Preview {
    NavigationView{
        OrderEvidencePage()
    }
}
