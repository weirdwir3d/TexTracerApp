import SwiftUI

struct SelectSameOrdersArea: View {
    
    @EnvironmentObject var selectedDataStore: SelectedDataStore
    @Binding var currentArea: Int
    @State private var markedOrders: Set<String> = Set()
    @State private var orders: [Order] = []
    
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
                        print("Selected Orders: \(markedOrders)")
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
                            print("Selected Orders: \(markedOrders)")
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
                        selectedDataStore.addSelectedOrder(order)
                    }
                }
                selectedDataStore.alignSelectedStepsOrder()
                //TODO: navigate to another page
                print("All Steps: \(selectedDataStore.getAllOrderSteps())")
                print("Selected Steps: \(selectedDataStore.getSelectedSteps())")
                print("All orders: \(selectedDataStore.getOrders())")
                print("Selected orders: \(selectedDataStore.getSelectedOrders())")
                print("Steps with same evidence: \(selectedDataStore.getAllSameEvidenceSteps())")
            }) {
                Text("Start uploading evidence")
            }
            .buttonStyle(PlainButtonStyle())
            
            CustomEmptyButton(action: {
                currentArea = 2
            }) {
                Text("Back to Select steps with same evidence")
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .onAppear {
            // Set the initial list of orders when the view appears
            orders = selectedDataStore.getOrders()
        }
        
    }
}


#Preview {
    SelectSameOrdersArea(currentArea: .constant(3))
        .environmentObject(SelectedDataStore())
}
