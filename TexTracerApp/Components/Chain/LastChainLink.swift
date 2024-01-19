import SwiftUI

struct LastChainLink: View {
    
    var orderStep: OrderStep
    
    var body: some View {
        
        Image(systemName: "circle.dashed")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .foregroundColor(Color.theme.lightGreyColor)
    }
    
}

#Preview {
    LastChainLink(orderStep: OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()))
}
