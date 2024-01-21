import SwiftUI

struct CustomEmptyButton: View {
    let action: () -> Void
    let label: () -> (Image?, Text)
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = label().0 {
                    icon // Display the icon if it is not nil
                }
                label().1
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white)
            .foregroundColor(Color.accentColor)
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    CustomEmptyButton(action: {}) {
        (Image(systemName: "arrow.up.circle.fill"), Text("Upload evidence"))
    }
}
