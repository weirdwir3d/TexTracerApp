//TODO: class that is supposed to provide X button on the right corner of ImagePreview in the ImageBoxView class
//import SwiftUI
//
//class ImagePreviewContainer: ObservableObject {
//    @Published var isImagePreviewPresented = false
//    var imageData: Data?
//
//    @objc func dismissImagePreview() {
//        isImagePreviewPresented = false
//    }
//}
//
//struct ImagePreview: UIViewControllerRepresentable {
//    let imageData: Data
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        let viewController = UIViewController()
//        let imageView = UIImageView(image: UIImage(data: imageData))
//        imageView.contentMode = .scaleAspectFit
//
//        // Set the image view frame to center it within the view controller
//        let imageSize = imageView.image?.size ?? CGSize(width: 300, height: 300)
//        imageView.frame = CGRect(x: (viewController.view.bounds.width - imageSize.width) / 2,
//                                 y: (viewController.view.bounds.height - imageSize.height) / 2,
//                                 width: imageSize.width,
//                                 height: imageSize.height)
//
//        viewController.view.addSubview(imageView)
//
//        // Add dismiss button
//        let dismissButton = UIButton(type: .system)
//        dismissButton.setTitle("X", for: .normal)
//        dismissButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        dismissButton.frame = CGRect(x: viewController.view.bounds.width - 40, y: 20, width: 40, height: 40)
//        dismissButton.addTarget(context.coordinator, action: #selector(context.coordinator.dismissView), for: .touchUpInside)
//        viewController.view.addSubview(dismissButton)
//
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        // Update if needed
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: ImagePreview
//
//        init(_ parent: ImagePreview) {
//            self.parent = parent
//        }
//
//        @objc func dismissView() {
//            parent.dismissAction?()
//        }
//    }
//
//    var dismissAction: (() -> Void)?
//}
//
//struct Preview: View {
//    @StateObject private var imagePreviewContainer = ImagePreviewContainer()
//
//    var body: some View {
//        Button("Show Image") {
//            imagePreviewContainer.imageData = // Set your image data here
//            imagePreviewContainer.isImagePreviewPresented = true
//        }
//        .sheet(isPresented: $imagePreviewContainer.isImagePreviewPresented) {
//            ImagePreview(imageData: imagePreviewContainer.imageData!)
//                .onDisappear {
//                    // Handle any cleanup here if needed
//                }
//        }
//        .environmentObject(imagePreviewContainer)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

