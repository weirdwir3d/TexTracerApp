import SwiftUI

struct UploadEvidencePage: View {
    
    @EnvironmentObject var dataStore: DataStore
    @State private var steps: [OrderStep] = []
    @State private var visibleAreas: [UploadEvidenceArea] = []
    @State private var currentAreaIndex: Int = 0

    var isSelectedPicture: Bool {
            guard currentAreaIndex < visibleAreas.count else {
                return true
            }

        return dataStore.getSelectedImage() == nil
        }
    
    var body: some View {
        VStack {
            
            // Display the current UploadEvidenceArea
            if visibleAreas.indices.contains(currentAreaIndex) {
                visibleAreas[currentAreaIndex].environmentObject(dataStore)
            }
            
                CustomFullButton(action: {
                    // save selectedPicture to array in dataStore and reset selectedPicture value so that it can be used for the next area
                    dataStore.saveSelectedImage()
                    let currentSteps = dataStore.getCurrentSteps()
                    dataStore.addStepsToDoneStepsProgressBar(currentSteps)
                    dataStore.resetSelectedImage()
                    
                    navigateToNextArea()
                    
                    
                }) {
                    Text("Next")
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(currentAreaIndex == visibleAreas.count - 1 || isSelectedPicture)

                
                CustomEmptyButton(action: {
                    navigateToPreviousArea()
                }) {
                    (nil, Text("Previous"))
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(currentAreaIndex == 0)

        }
        .onAppear {
            // Assign the result directly to visibleAreas
            visibleAreas = generatePagesForSteps(dataStore)
//            print("visible areas: \(visibleAreas)")
        }
    }

    func generatePagesForSteps(_ dataStore: DataStore) -> [UploadEvidenceArea] {
        let listBooleanSteps = dataStore.getListBooleanSteps()
        var counter: Int = 0
        var hasFoundTrue = false
        
        for boolVal in listBooleanSteps.values {
            if boolVal && !hasFoundTrue {
                counter += 1
                hasFoundTrue = true
            }
            if !boolVal {
                counter += 1
            }
        }
        
        var visibleAreas: [UploadEvidenceArea] = []
        
        for n in 0..<counter {
            visibleAreas.append(UploadEvidenceArea(index: n))
        }
        
        return visibleAreas
    }

    func navigateToPreviousArea() {
        if currentAreaIndex > 0 {
            currentAreaIndex -= 1
        }
    }

    func navigateToNextArea() {
        if currentAreaIndex < visibleAreas.count - 1 {
            currentAreaIndex += 1
        }
    }
}



#Preview {
    UploadEvidencePage()
        .environmentObject(DataStore())
}
