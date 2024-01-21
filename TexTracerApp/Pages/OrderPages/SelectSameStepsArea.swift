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
                for orderStep in orderSteps {
                    if toggledSteps.contains(orderStep.step.stringValue) {
                        dataStore.addSameEvidenceStep(orderStep)
                    }
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
