import SwiftUI

struct UploadEvidencePage: View {
    let passage: StepPassage
    @EnvironmentObject var dataStore: DataStore
    @State private var task: UploadEvidenceTask = Task.uploadTaskTest as! UploadEvidenceTask
    @State private var showAlert: Bool = false
    @State private var showActionSheet: Bool = false
    @State var allStyleNrs: [String] = []
    @State private var imagePickerSourceType: UIImagePickerController.SourceType?
    @State private var selectedImage: UIImage? {
        didSet {
            dataStore.setSelectedImage(selectedImage)
        }
    }
    
    var body: some View {
        VStack {
            ProgressBar().environmentObject(dataStore)
            let _ = print("---------View appeared or re-rendered-----------")
            let _ = print("ALL STEPS: \(dataStore.getSelectedSteps())")
            let _ = print("DONE STEPS: \(dataStore.getDoneStepsProgressBar())")
            let _ = print("REMAINING STEPS: \(dataStore.getRemainingSteps())")
            let _ = print("CURRENT PASSAGE: \(String(describing: dataStore.getCurrentPassage()))")
            let _ = print("NEXT PASSAGE: \(String(describing: dataStore.nextPassage(after: passage)))")
            
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
                        
                    }.padding()
                    
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
            
            //             next page
            NavigationLink(destination: nextPage()) {
                CustomFullButton(action: {
                    
                    if let nextPassage = dataStore.nextPassage(after: passage) {
                        dataStore.setCurrentPassage(nextPassage)
                    }
                    
                    dataStore.addStepsToDoneStepsProgressBar(passage.steps)
                    dataStore.clearCurrentSteps()
                    dataStore.resetSelectedImage()
                    
                    print("done steps: \(dataStore.getDoneStepsProgressBar())")
                }) {
                    Text("Next")
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            
            //back page
            CustomEmptyButton(action: {
                //
            }) {
                (nil, Text("Back to Select steps"))
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        
    }
    
    @ViewBuilder
    private func nextPage() -> some View {
        if let nextPassage = dataStore.nextPassage(after: passage) {
            let _ = print("Navigating to next passage: \(nextPassage)")
            return UploadEvidencePage(passage: nextPassage)
        } else {
            let _ = print("Navigating to UserFeedbackPage")
            return UserFeedbackPage()
        }
    }

    
}



#Preview {
    UploadEvidencePage(passage: StepPassage(steps:
                                                [OrderStep(id: UUID(), step: Step.Dyeing, supplierId: UUID()),
                                                 OrderStep(id: UUID(), step: Step.Tanning, supplierId: UUID()),
                                                 OrderStep(id: UUID(), step: Step.FabricTrading, supplierId: UUID()),
                                                 OrderStep(id: UUID(), step: Step.DesignAndDevelopment, supplierId: UUID()),
                                                 OrderStep(id: UUID(), step: Step.Printing, supplierId: UUID()),
                                                ]
                                           )
    )
    .environmentObject(DataStore())
}
