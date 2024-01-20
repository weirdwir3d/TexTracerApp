import SwiftUI

struct UploadPictureButton: View {
    @Binding var showAlert: Bool
    @Binding var showActionSheet: Bool
    @Binding var imagePickerSourceType: UIImagePickerController.SourceType?
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        Button(action: {
            //display alert
            showAlert = true
        }) {
            VStack {
                Image(systemName: "camera")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                Spacer().frame(height: 18)
                
                Text("Upload picture")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
            .padding(34)
            .background(Color.lightGrey)
            .cornerRadius(10)
        }
        .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Upload Picture"),
                        message: Text("Do you want to upload a picture?"),
                        primaryButton: .default(Text("Yes"), action: {
                            // Handle alert action if needed
                            // For example, you can show the action sheet here
                            showActionSheet = true
                        }),
                        secondaryButton: .cancel()
                    )
                }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Select Source"),
                buttons: [
                    .default(Text("Take a Picture"), action: {
                        imagePickerSourceType = .camera
                    }),
                    .default(Text("Upload from Library"), action: {
                        imagePickerSourceType = .photoLibrary
                    }),
                    .cancel()
                ]
            )
        }
    }
}

//#Preview {
//    UploadPictureButton()
//}
