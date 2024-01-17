import SwiftUI

struct SelectOrdersArea: View {
    
    @EnvironmentObject var selectedDataStore: SelectedDataStore
    @Binding var currentArea: Int
    @State private var markedOrders: Set<String> = Set()
    @State private var orders: [Order] = []  // Store the initial list of orders
    
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
                
            }
            
            
            CustomFullButton(action: {
                print("Selected order Steps: \(selectedDataStore.getSelectedSteps())")
                currentArea = 3
            }) {
                Text("Select orders")
            }
            .buttonStyle(PlainButtonStyle())
            
            CustomUnderlinedText(text: "Back to select steps") {
            }
            
        }
        .onAppear {
            // Set the initial list of orders when the view appears
            orders = selectedDataStore.getOrders()
        }
        
    }
}


#Preview {
    SelectOrdersArea(currentArea: .constant(3))
        .environmentObject(SelectedDataStore())
}
