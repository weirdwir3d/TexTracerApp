import SwiftUI

struct OneChainLink: View {
    
    var orderStep: OrderStep
    
    @EnvironmentObject var selectedDataStore: DataStore
    @State var isSelected: Bool = false
    @State private var fillColor = Color.theme.violetUltraLightColor
    @State private var symbol = "circle.fill"
    
    var body: some View {
        
        Image(systemName: symbol)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .foregroundColor(fillColor)
            .onTapGesture {
                isSelected.toggle()
                fillColor = isSelected ? Color.theme.accentColor : Color.theme.violetUltraLightColor
                symbol = isSelected ? "checkmark.circle.fill" : "circle.fill"
                
                if isSelected {
                    selectedDataStore.addSelectedStep(orderStep)
                    
//                    print("all selected steps: \(selectedDataStore.getSelectedSteps())")
                } else {
                    selectedDataStore.removeSelectedStep(orderStep)
                    
//                    print("all selected steps: \(selectedDataStore.getSelectedSteps())")
                }
            }
    }
}


#Preview {
    OneChainLink(orderStep: OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()), isSelected: false)
}
