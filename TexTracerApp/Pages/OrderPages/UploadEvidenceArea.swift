import SwiftUI
import UIKit

struct UploadEvidenceArea: View {
    
    @EnvironmentObject var dataStore: DataStore
    @State private var task: UploadEvidenceTask = Task.uploadTaskTest as! UploadEvidenceTask
    @State var allStyleNrs: [String] = []
    @State private var showAlert: Bool = false
    @State private var showActionSheet: Bool = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType?
    let index: Int
    @State private var selectedImage: UIImage? {
        didSet {
            dataStore.setSelectedImage(selectedImage)
        }
    }
    
    var body: some View {
        StepsProgressBar(steps: dataStore.getStepsProgressBar())
            .environmentObject(dataStore)
        
        Spacer().frame(height: 50)
        
        ScrollView {
            
            VStack {                
                if let selectedImage = dataStore.getSelectedImage() {
                    ImageBoxView(image: selectedImage).environmentObject(dataStore)
                } else {
                    UploadPictureButton(showAlert: $showAlert, showActionSheet: $showActionSheet, imagePickerSourceType: $imagePickerSourceType, selectedImage: $selectedImage)
                }
                
                //all order info
                WhiteBox {
                        VStack(alignment: .leading) {
                            
                            //current steps
                            Text("Current steps").bold()
                            Text(dataStore.getCurrentSteps().map { "\($0.step.stringValue)" }.joined(separator: ", "))
                            Divider()
                            
                            //orders
                            Text("Orders").bold()
                            Text(dataStore.getSelectedOrders().map { "\($0.code)" }.joined(separator: ", "))
                            Divider()
                            
                            //assigned by
                            Text("Assigned by").bold()
                            Text("\(task.assignerId)")
                            Divider()
                            
                            //date
                            Text("Date").bold()
                            Text("\(task.receivedDate)")
                            Divider()
                            
                            //style nrs
                            Text("Style numbers").bold()
                            Text(allStyleNrs.map { "\($0)" }.joined(separator: ", "))
                            Divider()
                            
                            //final client
                            Text("Final client").bold()
                            if let orderCode = task.orderCode {
                                Text(orderCode)
                            } else {
                                Text("No order code")
                            }
                            
                        }
                    
                }
                
//                                if let selectedImage = selectedImage {
//                                    ImageBoxView(image: selectedImage)
//                                }
                
            }
            .onAppear {
                self.task = dataStore.getCurrentTask() as! UploadEvidenceTask
                
                for order in dataStore.getOrders() {
                    let styleNr = order.getStyleNumber()
                    if !allStyleNrs.contains(styleNr) {
                        allStyleNrs.append(styleNr)
                    }
                }
                
                print("CURRENT STEPS: \(dataStore.getCurrentSteps().map { "\($0.step.stringValue)" }.joined(separator: ", "))")
//                print("currentTask: \(task.toString())")
            }
            .sheet(isPresented: Binding<Bool>(
                get: { imagePickerSourceType != nil },
                set: { _ in imagePickerSourceType = nil }
            )) {
                ImagePickerView(sourceType: imagePickerSourceType ?? .camera) { image in
                    // Use the selected image, you can implement your logic here
                    selectedImage = image
//                    print("Selected image: \(image)")
                }
            }
            
            
        }
        
    }
    
}


#Preview {
    UploadEvidenceArea(index: 1).environmentObject(DataStore())
}
