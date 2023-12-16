import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let label: () -> Text

    var body: some View {
        Button(action: action) {
            label()
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
    CustomButton(action: {}) {
        Text("Upload evidence")
    }
}



