import SwiftUI
import PDFKit

struct PDFThumbnail: View {
    let pdfURL: URL
    let thumbnailSize: CGSize
    @State private var showPDFViewer = false
    
    var body: some View {
        Button(action: {
                    showPDFViewer.toggle()
                }) {
                    if let thumbnailImage = generateThumbnail() {
                        Image(uiImage: thumbnailImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: thumbnailSize.width, height: thumbnailSize.height)
                    } else {
                        // Placeholder or default image in case of failure
                        Text("Thumbnail not available")
                    }
                }
                .sheet(isPresented: $showPDFViewer) {
                    PDFViewer(pdfURL: pdfURL)
                }
    }
    
    private func generateThumbnail() -> UIImage? {
        guard let pdfDocument = PDFDocument(url: pdfURL),
              let pdfPage = pdfDocument.page(at: 0) else {
            return nil
        }
        
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.documentView?.backgroundColor = UIColor.clear
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.pageShadowsEnabled = false
        
        let thumbnailSize = CGSize(width: pdfPage.bounds(for: .mediaBox).width,
                                   height: pdfPage.bounds(for: .mediaBox).height)
        
        return pdfView.exportAsImage(for: pdfPage, at: thumbnailSize)
    }
}

extension PDFView {
    func exportAsImage(for page: PDFPage, at size: CGSize) -> UIImage? {
        let pdfRect = page.bounds(for: .mediaBox)
        let scale = min(size.width / pdfRect.width, size.height / pdfRect.height)
        let scaledRect = CGRect(x: 0, y: 0, width: pdfRect.width * scale, height: pdfRect.height * scale)
        
        let renderer = UIGraphicsImageRenderer(size: scaledRect.size)
        let image = renderer.image { (context) in
            UIColor.white.set()
            context.fill(scaledRect)
            
            context.cgContext.translateBy(x: 0, y: scaledRect.height)
            context.cgContext.scaleBy(x: 1, y: -1)
            context.cgContext.scaleBy(x: scale, y: scale)
            
            page.draw(with: .mediaBox, to: context.cgContext)
        }
        
        return image
    }
}

struct PDFThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        PDFThumbnail(pdfURL: URL(fileURLWithPath: "dummyFile.pdf"), thumbnailSize: CGSize(width: 100, height: 150))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
