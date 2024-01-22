import SwiftUI
import PDFKit

struct PDFViewer: UIViewControllerRepresentable {
    let pdfURL: URL

    func makeUIViewController(context: Context) -> UIViewController {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: pdfURL)

        let viewController = UIViewController()
        viewController.view.addSubview(pdfView)
        pdfView.frame = viewController.view.bounds

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the view controller if needed
    }
}
