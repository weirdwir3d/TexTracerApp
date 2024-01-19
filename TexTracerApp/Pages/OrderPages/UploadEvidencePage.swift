import SwiftUI

struct UploadEvidencePage: View {
    
    @EnvironmentObject var selectedDataStore: SelectedDataStore
    @State private var steps: [OrderStep] = []
    
    var body: some View {
        VStack {
            StepsProgressBar(steps: selectedDataStore.getStepsProgressBar(), stepsIsSameEvidence: selectedDataStore.getStepsIsSameEvidence())
                .environmentObject(selectedDataStore)
            
//            let booleanStepsDictionary = selectedDataStore.getListBooleanSteps()
            
//            StepsProgressBar(steps: $steps)
//                .onAppear {
//                    selectedDataStore.createListBooleanSteps()
//                    let booleanStepsDictionary = selectedDataStore.getListBooleanSteps()
//                    
//                    let orderedSteps = selectedDataStore.getSelectedSteps()
//                    orderedSteps.forEach { step in
//                        if let boolValue = booleanStepsDictionary[step] {
//                            steps.append(step)
//                        } else {
//                            print("\(step) not found in booleanStepsDictionary")
//                        }
//                    }
//                }
//                .onChange(of: steps) {
//                    StepsProgressBar(steps: $steps)
//                }
            
        }
//        .onAppear {
//            print("UploadEvidencePage: selectedDataStore.getStepsIsSameEvidence().firs: \(selectedDataStore.getStepsIsSameEvidence().first)")
//        }
//        .onAppear {
//            selectedDataStore.createListBooleanSteps()
//            let booleanStepsDictionary = selectedDataStore.getListBooleanSteps()
//            
//            print("----------------------------------")
//            booleanStepsDictionary.forEach { (step, boolValue) in
//                print("Step: \(step), Bool Value: \(boolValue)")
//            }
//            
//        }
        
        
    }
}

#Preview {
    UploadEvidencePage()
        .environmentObject(SelectedDataStore())
}
