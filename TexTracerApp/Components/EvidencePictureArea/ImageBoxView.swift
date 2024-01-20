import SwiftUI

struct ImageBoxView: View {
    let image: UIImage
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
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
            
            Image(systemName: "x.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(.red)
                .offset(x: 16, y: -20)
                .onTapGesture {
                    // Clear the selected image
                    selectedImage = nil
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static private var selectedImage: UIImage? = UIImage(named: "exampleImage")

    static var previews: some View {
        ImageBoxView(image: selectedImage ?? UIImage(), selectedImage: $selectedImage)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}

