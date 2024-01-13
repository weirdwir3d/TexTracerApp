import SwiftUI

struct OrderDetailsArea<T: Task>: View {
    
    let task: T
    
    var body: some View {
        
        VStack(spacing: 0) {
            // Red icon, title and date block next to assigned by block
            HStack {
                HStack {
                    OrderBadge(number: 5)
                    VStack(alignment: .leading) {
                        Text("Order \(task.orderCode!)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("12/04/2023")
                            .font(.caption)
                    }
                }
                Spacer()
                VStack {
                    Text("Assigned by:")
                        .fontWeight(.bold)
                    Text("FashionLead")
                }
            }
            
            Spacer().frame(height: 20)
            
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Style number:")
                            .fontWeight(.bold)
                        Text("AW23D001")
                    }
                    HStack {
                        Text("Delivery to:")
                            .fontWeight(.bold)
                        Text("EleganceForge")
                    }
                    HStack {
                        Text("Final client:")
                            .fontWeight(.bold)
                        Text("H&M")
                    }
                }
                
                Spacer()
            }
            
            Spacer().frame(height: 26)
            
//            HStack {
//                Chain(task: task)
//                Spacer()
//            }
        }
        
    }
}

#Preview {
    OrderDetailsArea(task: Task.uploadTaskTest)
}
