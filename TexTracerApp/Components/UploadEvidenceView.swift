import SwiftUI

struct UploadEvidenceView: View {
    @State private var showAlert = false
    @State private var hasAllowedCamera = false
    @State private var hasAllowedLocation = false
    @State private var showActionSheet = false
    
    var body: some View {
        //put ScrollView
        VStack {
            Text("Here goes the checkout stepped progress bar")
            if !hasAllowedCamera {
                Button(action: {
                    showAlert = true
                }) {
                    Text("Upload picture")
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(hasAllowedLocation ? "Allow Tex.tracer to access Camera" : "Allow Tex.tracer to access Location"),
                        message: Text("This is the alert message."),
                        primaryButton: .default(Text("Allow")) {
                            print("Allow")
                            if (hasAllowedLocation) {
                                hasAllowedCamera = true
                                showActionSheet = true
                            }
                            hasAllowedLocation = true
                        },
                        secondaryButton: .destructive(Text("Don't Allow")) {
                            // Action for Option 2
                            print("Don't Allow")
                        }
                    )
                }
            } else {
                Rectangle()
                    .fill(Color.blue) // Adjust the color as needed
                    .frame(width: 200, height: 50) // Adjust the size as needed
                    .cornerRadius(10)
            }
            
            //TODO: fix this
            //            put a label and separator for each element of list
            VStack {
                Label(
                    title: {
                        Text("Steps:")
                            .foregroundColor(.blue)
                            .font(.headline)
                    },
                    icon: {
                        Image(systemName: "gear")
                            .foregroundColor(.blue)
                    }
                )
                Divider()
                Text("Orders:")
                Text("Assigned by:")
                Text("Date:")
                Text("Style number:")
                Text("Final client:")
                // Add more Text views or other views as list items
            }
            //                        .navigationTitle("My List")
            
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Select source"),
                message: Text("Choose an option from below"),
                buttons: [
                    .default(Text("Library")) {
                        // Handle Option 1
                        print("Option 1 selected")
                    },
                    .default(Text("Camera")) {
                        // Handle Option 2
                        print("Option 2 selected")
                    },
                    .cancel() {
                        // Handle cancellation
                        print("Cancelled")
                    }
                ]
            )
        }
    }
}

#Preview {
    UploadEvidenceView()
}
