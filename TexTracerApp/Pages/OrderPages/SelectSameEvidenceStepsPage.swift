import SwiftUI
import UIKit

struct SelectSameEvidenceStepsPage: View {
    
    @EnvironmentObject var selectedDataStore: SelectedDataStore
    @State private var toggledSteps: [String] = []
    @State private var isNextPageActive: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ScrollView {
            Text("What steps share the same order evidence?")
            var orderSteps = selectedDataStore.getSelectedSteps()
            ForEach(orderSteps) { orderStep in
                StepSwitch(
                    text: orderStep.step.stringValue,
                    isToggled: Binding(
                        get: { toggledSteps.contains(orderStep.step.stringValue) },
                        set: { newValue in
                            if newValue && !toggledSteps.contains(orderStep.step.stringValue) {
                                toggledSteps.append(orderStep.step.stringValue)
                                print("Step \(orderStep.step.stringValue) added. Toggled steps: \(toggledSteps)")
                            } else if !newValue {
                                toggledSteps.removeAll { $0 == orderStep.step.stringValue }
                                print("Step \(orderStep.step.stringValue) removed. Toggled steps: \(toggledSteps)")
                            }
                        }
                    ), onToggle: {}
                )
            }
            
            CustomFullButton(action: {
                print("Selected order Steps: \(selectedDataStore.getSelectedSteps())")
                isNextPageActive = true
            }) {
                Text("Select orders")
            }
            .buttonStyle(PlainButtonStyle())
            
            CustomUnderlinedText(text: "Back to select steps") {
                presentationMode.wrappedValue.dismiss()
            }
            
        }
        
        NavigationLink(
            destination: SelectOrdersPage().environmentObject(selectedDataStore),
            isActive: $isNextPageActive,
            label: {
                EmptyView()
            }
        )
        
    }
}

#Preview {
    SelectSameEvidenceStepsPage()
        .environmentObject(SelectedDataStore())
}
