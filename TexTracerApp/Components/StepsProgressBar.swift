import SwiftUI

struct StepsProgressBar: View {
    
    @EnvironmentObject var dataStore: DataStore
    var steps: [OrderStep]
    var stepsIsSameEvidence: [Bool]
    //    @State var completedSteps: [OrderStep] = []
    //TODO: see if this is needed at all
    @State var currentSteps: [OrderStep] = []
    
    @ViewBuilder
        func drawCircle(for step: OrderStep) -> some View {
            if currentSteps.contains(step) {
                yellowCircle()
            } else if dataStore.getDoneStepsProgressBar().contains(step) {
                greenCircle()
            } else {
                redCircle()
            }
        }
    
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
    
    var body: some View {
            HStack {
                
                ForEach(0..<steps.count) { index in
                                // Draw the circle based on the current step
                                drawCircle(for: steps[index])
                                
                                // Draw the separator line, except for the last step
                                if index < steps.count - 1 {
                                    Rectangle()
                                        .frame(width: 50, height: 4)
                                        .foregroundColor(Color.theme.violetLightColor)
                                }
                            }
                
//                let viewsToDisplay: [StepViewItem] = steps.indices.flatMap { index -> [StepViewItem?] in
//                    print("ALL STEPS: \(steps)")
//                    if dataStore.getDoneStepsProgressBar().contains(steps[index]) {
//                        return [StepViewItem(text: "greenCircle", view: AnyView(greenCircle()))]
//                    } else {
//                        if steps.first == steps[index] && dataStore.getStepsIsSameEvidence().first == true {
//                            var views: [StepViewItem] = []
//                            
//                            for (boolIndex, boolVal) in dataStore.getStepsIsSameEvidence().enumerated() {
////                                print("boolIndex: \(boolIndex), boolVal: \(boolVal)")
//                                let correspondingStep = steps[boolIndex]
//                                if boolVal {
//                                    views.append(StepViewItem(text: "yellowCircle", view: AnyView(yellowCircle())))
//                                    dataStore.addStepToCurrentSteps(steps[index])
//                                    currentSteps.append(steps[index])
//                                }
//                            }
//
//                            return views
//                        } else if steps.first == steps[index] && dataStore.getStepsIsSameEvidence().first == false {
//                            dataStore.addStepToCurrentSteps(steps[index])
//                            currentSteps.append(steps[index])
//                            return [StepViewItem(text: "yellowCircle", view: AnyView(yellowCircle()))]
//                        } else {
//                            if dataStore.getStepsIsSameEvidence()[index] == false {
//                                return [StepViewItem(text: "redCircle", view: AnyView(redCircle()))]
//                            }
//                            return []
//                        }
//                    }
//                    
//                }
//                    .compactMap { $0 }
//                
//                ForEach(0..<viewsToDisplay.count - 1) { index in
//                    HStack {
//                        viewsToDisplay[index].view
//                            .id(viewsToDisplay[index].text)
//                        
//                        Rectangle()
//                            .frame(width: 50, height: 4)
//                            .foregroundColor(Color.theme.violetLightColor)
//                        
//                    }
//                }
                
//                if let lastView = viewsToDisplay.last {
//                    lastView.view
//                        .id(lastView.text)
//                }
                
                
            }
            .onAppear {
                findCurrentSteps()
//                var boolList = dataStore.getStepsIsSameEvidence()
//                for bool in boolList {
////                    print("selectedDataStore.getStepsIsSameEvidence(): \(bool)")
//                }
//                dataStore.clearCurrentSteps()
                
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
    
    func findCurrentSteps() {
        //1. get all steps
        var allSteps = dataStore.getSelectedSteps()
        
        //2. get all done steps
        var doneSteps = dataStore.getDoneStepsProgressBar()
        
        //3. get list that tells you which steps share the same evidence
        var sameEvidenceSteps = dataStore.getAllSameEvidenceSteps()
        
        //4. get list of steps left to upload evidence for (allSteps minus doneSteps)
        var leftSteps = allSteps.filter { !doneSteps.contains($0) }
        
        //4. if doneSteps doesnt contain any Step, it means the user has to either upload order evidence for the first step of allSteps, or upload order evidence for the first step + all other steps that share the same evidence
        
//        var currentSteps: [OrderStep] = []
        
        for step in allSteps {
            if doneSteps.contains(step) {
                // Draw green circle
            } else {
                // 5. Determine current step(s)
                var firstLeftStep = leftSteps.first
                
                // 6. Check if that step shares the same evidence with other neighbor steps
                if leftSteps.count != 0 {
                    if !sameEvidenceSteps.contains(firstLeftStep!) {
                        // Draw yellow circle, cause this step will be the only one to be the current step
                        currentSteps.append(firstLeftStep!)
                    } else {
                        // 7. It means that firstLeftStep shares evidence with other steps, so we have to loop through sameEvidenceSteps to find which ones
                        
                        for sharedStep in sameEvidenceSteps {
                            currentSteps.append(sharedStep)
                        }
                        
                        //
                    }
                    
                    // 8. draw the step
                    if currentSteps.contains(step) {
                        // draw yellow circle
                    } else {
                        // draw red circle
                    }
                    
                }
            }
            
            
        }
        
        

        
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
