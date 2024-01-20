import SwiftUI

struct StepsProgressBar: View {
    
    @EnvironmentObject var dataStore: DataStore
    var steps: [OrderStep]
    @State var currentSteps: [OrderStep] = []
    
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
                            
            }
            .onAppear {
                currentSteps = []
                dataStore.clearCurrentSteps()
                findCurrentSteps()
                print("CURRENT STEPS IN STEPSPROGRESSBAR: \(currentSteps)")
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
        func drawCircle(for step: OrderStep) -> some View {
            if currentSteps.contains(step) {
                yellowCircle()
            } else if dataStore.getDoneStepsProgressBar().contains(step) {
                greenCircle()
            } else {
                redCircle()
            }
        }
    
    @ViewBuilder
    func greenCircle() -> some View {
        Circle()
            .foregroundColor(Color.green)
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
            .foregroundColor(Color.red)
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
            .foregroundColor(Color.yellow)
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
        let allSteps = dataStore.getSelectedSteps()
        
        //2. get all done steps
        let doneSteps = dataStore.getDoneStepsProgressBar()
        
        //3. get list that tells you which steps share the same evidence
        let sameEvidenceSteps = dataStore.getAllSameEvidenceSteps()
        
        //4. get list of steps left to upload evidence for (allSteps minus doneSteps)
        let leftSteps = allSteps.filter { !doneSteps.contains($0) }
        
        // 5. Determine first step among the leftSteps
        let firstLeftStep = leftSteps.first
        
        //4. if doneSteps doesnt contain any Step, it means the user has to either upload order evidence for the first step of allSteps, or upload order evidence for the first step + all other steps that share the same evidence
        
        //        var currentSteps: [OrderStep] = []
        
        for step in allSteps {
            if doneSteps.contains(step) {
                // Draw green circle
            } else {
                // 6. Check if that step shares the same evidence with other neighbor steps
                
                if step == leftSteps.first {
                    currentSteps.append(step)
                } else {
                    if sameEvidenceSteps.contains(step) {
                        currentSteps.append(step)
                    }
                }
//                    if !sameEvidenceSteps.contains(firstLeftStep!) {
//                        // Draw yellow circle, cause this step will be the only one to be the current step
//                        if !currentSteps.contains(firstLeftStep!) {
//                            currentSteps.append(firstLeftStep!)
//                            dataStore.addStepToCurrentSteps(step)
//                        }
//                        
//                    } else {
//                        // 7. It means that firstLeftStep shares evidence with other steps, so we have to loop through sameEvidenceSteps to find which ones
//                        
//                        for sharedStep in sameEvidenceSteps {
//                            currentSteps.append(sharedStep)
//                            dataStore.addStepToCurrentSteps(step)
//                        }
//                        
//                        //
//                    }
                    // 8. draw the actual circles!
                    
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
    ]).environmentObject(DataStore())
}
