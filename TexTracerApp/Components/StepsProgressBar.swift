import SwiftUI

struct StepsProgressBar: View {
    
    let orderSteps: [OrderStep]
    @State var completedSteps: [OrderStep]
    @State var currentSteps: [OrderStep]
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            ForEach(orderSteps.indices) { index in
                HStack(spacing: 0) {
                    VStack {
                        circle(index: index)
                    }
                    
                    
                    if index != orderSteps.indices.last {
                        Rectangle()
                            .frame(width: 50, height: 4)
                            .foregroundColor(Color.theme.violetLightColor)
                    }
                }
                
                
                
            }
            
            
            
            
        }
        HStack(spacing: 40) {
            ForEach(orderSteps) { orderStep in
                
                Text(orderStep.step.stringValue)
            }
        }
    }
    
    func addToCompleted(orderStep : OrderStep) {
        self.completedSteps.append(orderStep)
    }
    
    
    func circle(index: Int) -> some View {
        let orderStep = orderSteps[index]
        var circleColor: Color = Color.theme.accentColor
        var numberColor: Color = Color(.white)

        if completedSteps.contains(where: { $0.id == orderStep.id }) {
            return AnyView(
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(circleColor)
            )
        } else if currentSteps.contains(where: { $0.id == orderStep.id }) {
            return AnyView(
                Circle()
                    .foregroundColor(circleColor)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text("\(index + 1)")
                            .foregroundColor(numberColor)
                            .font(.headline)
                    )
            )
        } else {
            return AnyView(
                Circle()
                    .foregroundColor(numberColor)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text("\(index + 1)")
                            .foregroundColor(circleColor)
                            .font(.headline)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.theme.accentColor, lineWidth: 2)
                    )
            )
        }
    }


    



}

#Preview {
    StepsProgressBar(orderSteps: [
        OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()),
        OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()),
        OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()),
        OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
    ],
                     completedSteps: [
                        OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID())
                     ],
                     currentSteps: [
                        OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()),
                        OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID())
                     ]
    )
}
