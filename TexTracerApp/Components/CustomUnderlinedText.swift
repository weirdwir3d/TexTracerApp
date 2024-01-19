import SwiftUI

struct CustomUnderlinedText: View {
    var text: String
    var action: () -> Void

    var body: some View {
        Text(text)
            .foregroundColor(Color("AccentColor"))
            .underline()
            .onTapGesture {
                action()
            }
    }
}
