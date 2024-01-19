import SwiftUI

struct StepSwitch: View {
    let text: String
    @Binding var isToggled: Bool
    var onToggle: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(isToggled ? Color.theme.accentColor : Color.theme.accentColor.opacity(0))
                .stroke(isToggled ? .white : Color.theme.accentColor, lineWidth: 2)
                .frame(width: 130, height: 44)
                .onTapGesture {
                    withAnimation {
                        isToggled.toggle()
                        onToggle()
                    }
                }

            HStack(spacing: 16) {
                Text(text)
                    .foregroundColor(isToggled ? .white : Color.theme.accentColor)
                    .font(.headline)

                Image(systemName: isToggled ? "checkmark" : "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(isToggled ? .white : Color.theme.accentColor)
                    .frame(width: 24, height: 24)
            }
            .onTapGesture {
                withAnimation {
                    isToggled.toggle()
                    onToggle()
                }
            }
        }
    }
}



//#Preview {
//    StepSwitch(text: "porcodio", isToggled: toggleState())
//    
//    
//}
