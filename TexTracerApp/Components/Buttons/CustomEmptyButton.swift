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
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(30)
        }
        .padding()
    }
}

#Preview {
    CustomEmptyButton(action: {}) {
        Text("Upload evidence")
    }
}
