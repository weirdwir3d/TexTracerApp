import SwiftUI

struct ImageBoxView: View {
    @EnvironmentObject var dataStore: DataStore
    let image: UIImage
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let selectedImage = dataStore.getSelectedImage() {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .background(Color.theme.darkGreyColor)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.theme.darkGreyColor, lineWidth: 2)
                    )
                    .padding(10)
                    .onTapGesture {
                        // Open the image when tapped
                        print("tapped")
                        openImage(selectedImage)
                    }

                Image(systemName: "x.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.red)
                    .offset(x: 16, y: -20)
                    .onTapGesture {
                        // Clear the selected image
                        dataStore.setSelectedImage(nil)
                    }
            } else {
                // Show a placeholder or handle the case when selectedImage is nil
                Text("No Image Selected")
            }
        }
        .padding(.top, 16)
    }

    private func openImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }

        let viewController = UIHostingController(rootView: ImagePreview(imageData: imageData))
        UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
}

struct ImagePreview: UIViewControllerRepresentable {
    let imageData: Data
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let imageView = UIImageView(image: UIImage(data: imageData))
        imageView.contentMode = .scaleAspectFit
        let imageSize = imageView.image?.size ?? CGSize(width: 300, height: 300)
        imageView.frame = CGRect(x: (viewController.view.bounds.width - imageSize.width) / 2,
                                 y: (viewController.view.bounds.height - imageSize.height) / 2,
                                 width: imageSize.width,
                                 height: imageSize.height) // Set the desired size
        viewController.view.addSubview(imageView)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update if needed
    }
}



struct ContentView_Previews: PreviewProvider {
    @State static private var selectedImage: UIImage? = UIImage(named: "exampleImage")
    @StateObject static private var dataStore: DataStore = DataStore()

    static var previews: some View {
        ImageBoxView(image: dataStore.getDummyImage())
            .previewLayout(.fixed(width: 200, height: 200))
            .environmentObject(dataStore)
    }
}
