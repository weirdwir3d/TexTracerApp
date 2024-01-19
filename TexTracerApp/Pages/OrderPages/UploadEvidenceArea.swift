import SwiftUI

struct UploadEvidenceArea: View {
    
    @EnvironmentObject var dataStore: DataStore
    @State private var task: UploadEvidenceTask = Task.uploadTaskTest as! UploadEvidenceTask
    
    let index: Int
    
    var body: some View {
        StepsProgressBar(steps: dataStore.getStepsProgressBar(), stepsIsSameEvidence: dataStore.getStepsIsSameEvidence())
            .environmentObject(dataStore)
        
        VStack {
            //upload picture button
            Button(action: {
                //onButtonClick
            }) {
                VStack {
                    Image(systemName: "camera")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Text("Upload picture")
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.theme.lightGreyColor)
                .cornerRadius(10)
            }
            
            Text("Area nr. \(index)")
            
            //all order info

            //current steps
            Text("Current steps")
//            Text("\(dataStore.getC)")
            
            //orders
            
            //assigned by
            
            //date
            
            //style nrs
            
            //final client
            
            
//            ForEach(orders) { order in
//                Toggle(isOn: Binding(
//                    get: { markedOrders.contains(order.code) },
//                    set: { newValue in
//                        if newValue {
//                            markedOrders.insert(order.code)
//                        } else {
//                            markedOrders.remove(order.code)
//                        }
////                            print("Selected Orders: \(markedOrders)")
//                    }
//                )) {
//                    HStack(spacing: 90) {
//                        Text(order.code)
//                        Text(order.styleNumber)
//                    }
//                }
//                .toggleStyle(CheckboxToggleStyle())
//                Divider()
//            }
            
        }
        .onAppear {
            self.task = dataStore.getCurrentTask() as! UploadEvidenceTask
            
            print("currentTask: \(task.toString())")
        }
        
        
    }
}

#Preview {
    UploadEvidenceArea(index: 1).environmentObject(DataStore())
}
