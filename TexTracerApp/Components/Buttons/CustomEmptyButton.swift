import SwiftUI

import SwiftUI

struct CustomEmptyButton: View {
    let action: () -> Void
    let label: () -> Text
    
    var body: some View {
        Button(action: action) {
            label()
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
        Text("Upload evidence")
    }
}
