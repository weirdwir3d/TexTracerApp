import SwiftUI

struct SelectSameOrdersArea: View {
    
    @EnvironmentObject var dataStore: DataStore
    @Binding var currentArea: Int
    @State private var markedOrders: Set<String> = Set()
    @State private var orders: [Order] = []
    @State private var isNavigationActive = false
    
    var body: some View {
        
        ScrollView {
            
            Text("Multiple orders share these steps. You can select them below to upload the same order evidence for all of them.")
            
            VStack(alignment: .leading) {
                
                Toggle(isOn: Binding(
                    get: {
                        markedOrders.count == orders.count
                    },
                    set: { newValue in
                        if newValue {
                            markedOrders = Set(orders.map { $0.code })
                        } else {
                            markedOrders.removeAll()
                        }
//                        print("Selected Orders: \(markedOrders)")
                    }
                )) {
                    Text("Select All")
                }
                .toggleStyle(CheckboxToggleStyle())
                
                ForEach(orders) { order in
                    Toggle(isOn: Binding(
                        get: { markedOrders.contains(order.code) },
                        set: { newValue in
                            if newValue {
                                markedOrders.insert(order.code)
                            } else {
                                markedOrders.remove(order.code)
                            }
//                            print("Selected Orders: \(markedOrders)")
                        }
                    )) {
                        HStack(spacing: 90) {
                            Text(order.code)
                            Text(order.styleNumber)
                        }
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    Divider()
                }
                
            }.padding()
            
            CustomFullButton(action: {
                for order in orders {
                    if markedOrders.contains(order.code) {
                        dataStore.addSelectedOrder(order)
                    }
                }
//                print("Steps with same evidence before aligning: \(selectedDataStore.getAllSameEvidenceSteps())")
                dataStore.alignSelectedStepsOrder()
                
                let filteredSteps = dataStore.getSelectedSteps()
                    .filter { orderStep in markedOrders.contains(orderStep.step.stringValue) }


                    for orderStep in filteredSteps {
                        dataStore.addSameEvidenceStep(orderStep)
                    }
                
//                print("All Steps: \(selectedDataStore.getAllOrderSteps())")
//                print("Selected Steps: \(selectedDataStore.getSelectedSteps())")
//                print("All orders: \(selectedDataStore.getOrders())")
//                print("Selected orders: \(selectedDataStore.getSelectedOrders())")
//                print("Steps with same evidence: \(selectedDataStore.getAllSameEvidenceSteps())")
                
                // generate StepsProgressBar that will show up in the next page
                dataStore.createListBooleanSteps()
                let booleanStepsDictionary = dataStore.getListBooleanSteps()
                
//                print("----------------------------------")
//                booleanStepsDictionary.forEach { (step, boolValue) in
//                    print("Step: \(step), Bool Value: \(boolValue)")
//                }
                
                let orderedSteps = dataStore.getSelectedSteps()
                orderedSteps.forEach { step in
                    if let boolValue = booleanStepsDictionary[step] {
                        dataStore.addStepToProgressBar(step)
                        dataStore.addStepsIsSameEvidence(boolValue)
                    } else {
                        print("\(step) not found in booleanStepsDictionary")
                    }
                }
//                print("SelectSameOrdersArea: selectedDataStore.getStepsIsSameEvidence().first: \(selectedDataStore.getStepsIsSameEvidence().first)")
                var steps = dataStore.getSelectedSteps()
                print("all (selected) steps after SelectSameOrdersPage: \(steps)")
                
                //navigate to next page
                isNavigationActive = true
            }) {
                Text("Start uploading evidence")
            }
            .buttonStyle(PlainButtonStyle())
            
            // NavigationLink to the next page
            NavigationLink("", destination: UploadEvidencePage().environmentObject(dataStore), isActive: $isNavigationActive)
            
            CustomEmptyButton(action: {
                currentArea = 2
            }) {
                Text("Back to Select steps with same evidence")
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .onAppear {
            // Set the initial list of orders when the view appears
            orders = dataStore.getOrders()
            
            var steps = dataStore.getSelectedSteps()
            print("all (selected) steps after SelectSteps page: \(steps)")
        }
        
    }
}


#Preview {
    SelectSameOrdersArea(currentArea: .constant(3))
        .environmentObject(DataStore())
}
