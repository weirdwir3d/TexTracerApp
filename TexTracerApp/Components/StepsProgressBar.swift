import SwiftUI

struct StepsProgressBar: View {
    
    @EnvironmentObject var selectedDataStore: DataStore
    var steps: [OrderStep]
    var stepsIsSameEvidence: [Bool]
    //    @State var completedSteps: [OrderStep] = []
    @State var currentSteps: [OrderStep] = []
    
    struct StepViewItem: Hashable {
        var text: String
        var view: AnyView
        
        static func == (lhs: StepViewItem, rhs: StepViewItem) -> Bool {
            return lhs.text == rhs.text
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(text.hashValue)
        }
    }
    
    //how to decide what circle to use?
    //1. compare each element of stepsProgressBar list to doneStepsProgressBar list, and keep track of the first element you find, that is not in the doneStepsProgressBar list
    //for that step, check the corresponding index in the stepsIsSameEvidence list. if the boolean value is false, then add the corresponding step to the currentSteps list and generate a currentCircle for that step. then proceed to the next step
    //if the boolean value is true AND it's the first element of the list, then keep track of it and loop through the stepsIsSameEvidence list to find all the true values in proximity. for all of them, generate a currentCircle
    //all the steps in the doneStepsProgressBar list will be drawn by doneCircle, and all the remaining ones that are neither in the doneStepsProgressBar list nor in the currentSteps list will be drawn by a blurredCircle
    
    var body: some View {
            HStack {
                let viewsToDisplay: [StepViewItem] = steps.indices.flatMap { index -> [StepViewItem?] in
                    if selectedDataStore.getDoneStepsProgressBar().contains(steps[index]) {
                        return [StepViewItem(text: "greenCircle", view: AnyView(greenCircle()))]
                    } else {
                        if steps.first == steps[index] && selectedDataStore.getStepsIsSameEvidence().first == true {
                            var views: [StepViewItem] = []
                            
                            for (boolIndex, boolVal) in selectedDataStore.getStepsIsSameEvidence().enumerated() {
//                                print("boolIndex: \(boolIndex), boolVal: \(boolVal)")
                                let correspondingStep = steps[boolIndex]
                                if boolVal {
                                    views.append(StepViewItem(text: "yellowCircle", view: AnyView(yellowCircle())))
                                }
                            }

                            return views
                        } else if steps.first == steps[index] && selectedDataStore.getStepsIsSameEvidence().first == false {
                            return [StepViewItem(text: "yellowCircle", view: AnyView(yellowCircle()))]
                        } else {
                            if selectedDataStore.getStepsIsSameEvidence()[index] == false {
                                return [StepViewItem(text: "redCircle", view: AnyView(redCircle()))]
                            }
                            return []
                        }
                    }
                    
                }
                    .compactMap { $0 }
                
                ForEach(0..<viewsToDisplay.count - 1) { index in
                    HStack {
                        viewsToDisplay[index].view
                            .id(viewsToDisplay[index].text)
                        
                        Rectangle()
                            .frame(width: 50, height: 4)
                            .foregroundColor(Color.theme.violetLightColor)
                        
                    }
                }
                
                if let lastView = viewsToDisplay.last {
                    lastView.view
                        .id(lastView.text)
                }
                
                
            }
            .onAppear {
                var boolList = selectedDataStore.getStepsIsSameEvidence()
                for bool in boolList {
//                    print("selectedDataStore.getStepsIsSameEvidence(): \(bool)")
                }
                
            }
        
        HStack(spacing: 40) {
            ForEach(steps) { orderStep in
                
                Text(orderStep.step.stringValue)
            }
        }
    }
    
    @ViewBuilder
    func greenCircle() -> some View {
        Circle()
//            .foregroundColor(numberColor)
            .frame(width: 40, height: 40)
//            .overlay(
//                Text("\(index + 1)")
//                    .foregroundColor(circleColor)
//                    .font(.headline)
//            )
            .overlay(
                Circle()
                    .stroke(Color.green, lineWidth: 2)
            )
    }
    
    @ViewBuilder
    func redCircle() -> some View {
        Circle()
//            .foregroundColor(numberColor)
            .frame(width: 40, height: 40)
//            .overlay(
//                Text("\(index + 1)")
//                    .foregroundColor(circleColor)
//                    .font(.headline)
//            )
            .overlay(
                Circle()
                    .stroke(Color.red, lineWidth: 2)
            )
    }
    
    @ViewBuilder
    func yellowCircle() -> some View {
        Circle()
//            .foregroundColor(numberColor)
            .frame(width: 40, height: 40)
//            .overlay(
//                Text("\(index + 1)")
//                    .foregroundColor(circleColor)
//                    .font(.headline)
//            )
            .overlay(
                Circle()
                    .stroke(Color.yellow, lineWidth: 2)
            )
    }

}

#Preview {
    StepsProgressBar(steps: [
        OrderStep(id: UUID(), step: Step.Dyeing, supplierId: UUID()),
        OrderStep(id: UUID(), step: Step.Tanning, supplierId: UUID()),
        OrderStep(id: UUID(), step: Step.FabricTrading, supplierId: UUID()),
        OrderStep(id: UUID(), step: Step.DesignAndDevelopment, supplierId: UUID())
    ], stepsIsSameEvidence: [
        true, true, false, false
    ]
    ).environmentObject(DataStore())
}
