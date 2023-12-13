import SwiftUI

struct CustomButton: View {
    let text: Text

    var body: some View {
        Button(action: {
            // Add your button action here
        }) {
            text
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(30)
        }
        .padding()
    }
}

#Preview {
    CustomButton(text: Text("Upload evidence"))
}

