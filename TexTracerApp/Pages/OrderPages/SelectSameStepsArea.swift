import SwiftUI

struct SelectSameStepsArea: View {
    
    @EnvironmentObject var dataStore: DataStore
    @State private var toggledSteps: [String] = []

    @Binding var currentArea: Int
    
    var body: some View {
        
        var orderSteps = dataStore.getSelectedSteps()
        
        ScrollView {
            
            Text("Steps selected:")
            ForEach(orderSteps) { orderStep in
                Text(orderStep.step.stringValue)
            }
            
            Text("What steps share the same order evidence?")
            ForEach(orderSteps) { orderStep in
                StepSwitch(
                    text: orderStep.step.stringValue,
                    isToggled: Binding(
                        get: { toggledSteps.contains(orderStep.step.stringValue) },
                        set: { newValue in
                            if newValue && !toggledSteps.contains(orderStep.step.stringValue) {
                                toggledSteps.append(orderStep.step.stringValue)
//                                print("Step \(orderStep.step.stringValue) added. Toggled steps: \(toggledSteps)")
                            } else if !newValue {
                                toggledSteps.removeAll { $0 == orderStep.step.stringValue }
//                                print("Step \(orderStep.step.stringValue) removed. Toggled steps: \(toggledSteps)")
                            }
                        }
                    ), onToggle: {}
                )
            }
            
            CustomFullButton(action: {
                
                dataStore.alignSelectedStepsOrder()
                
                for orderStep in orderSteps {
                    print("orderStep: \(orderStep.step.stringValue)")
                    if toggledSteps.contains(orderStep.step.stringValue) {
                        dataStore.addSameEvidenceStep(orderStep)
                    }
                }
                
                // create and add StepsPassage(s) to DataStore
                var stepsSameEv: [OrderStep] = []
                
                for step in orderSteps {
                    var steps: [OrderStep] = []
                    if !dataStore.getAllSameEvidenceSteps().contains(step) {
                        if stepsSameEv.count > 0 {
                            dataStore.addPassage(StepPassage(steps: stepsSameEv))
                            stepsSameEv.removeAll()
                        }

                        steps.append(step)
                        dataStore.addPassage(StepPassage(steps: steps))
                    } else {
                        stepsSameEv.append(step)
                    }
                }
                
                if stepsSameEv.count > 0 {
                    dataStore.addPassage(StepPassage(steps: stepsSameEv))
                    stepsSameEv.removeAll()
                }
                
                for passage in dataStore.getPassages() {
                    print("PASSAGE:")
                    passage?.printStepNames()
                }
                
                if let firstPassage = dataStore.getPassages().first {
                    dataStore.setCurrentPassage(firstPassage!)
                }

                
//                print("same evidence steps: \(selectedDataStore.getAllSameEvidenceSteps())")
//                print("Steps with same evidence: \(selectedDataStore.getAllSameEvidenceSteps())")
                
                currentArea = 3
            }) {
                Text("Next")
            }
            .buttonStyle(PlainButtonStyle())
            
            CustomEmptyButton(action: {
                currentArea = 1
            }) {
                (nil, Text("Back to Select steps"))
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .onAppear {
//            var steps = dataStore.getSelectedSteps()
//            print("all (selected) steps after SelectSteps page: \(steps)")
        }
        
    }
}

#Preview {
    SelectSameStepsArea(currentArea: .constant(2))
        .environmentObject(DataStore())
}
