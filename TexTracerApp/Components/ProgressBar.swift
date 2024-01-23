import SwiftUI

struct ProgressBar: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        
        HStack {
            
            ForEach(0..<dataStore.getSelectedSteps().count) { index in
                // Draw the circle based on the current step
                drawCircle(for: dataStore.getSelectedSteps()[index])
                
                // Draw the separator line, except for the last step
                if index < dataStore.getSelectedSteps().count - 1 {
                    Rectangle()
                        .frame(width: 50, height: 4)
                        .foregroundColor(Color.theme.violetLightColor)
                }
            }
            
        }
        
//        let _ = print("CURRENT STEPS: \(findCurrentSteps())")
        
        
        //        HStack(spacing: 40) {
        //            ForEach(allSteps) { step in
        //                Text(orderStep.step.stringValue)
        //            }
        //
        //        }
    }
    
//    func findCurrentSteps() -> [OrderStep] {
//        var currentSteps: [OrderStep] = []
//        
//        if let firstStep = leftSteps.first {
//            currentSteps.append(firstStep)
//            
//            if sameEvidenceSteps.contains(firstStep) {
//                for step in leftSteps {
//                    if step != leftSteps.first {
//                        if sameEvidenceSteps.contains(step) {
//                            currentSteps.append(step)
//                        }
//                    }
//                }
//            }
//        }
//        
//        return currentSteps
//    }
    
    
    @ViewBuilder
    func drawCircle(for step: OrderStep) -> some View {
        if let currentPassage = dataStore.getCurrentPassage(), currentPassage.hasStep(step) {
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
    
    
}





#Preview {
        ProgressBar()
}
