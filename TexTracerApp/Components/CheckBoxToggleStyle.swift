import Foundation
import SwiftUI
 
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(configuration.isOn ? Color.accentColor : Color.clear)
                        .frame(width: 25, height: 25)
                        .cornerRadius(5.0)
                        .overlay {
                            Image(systemName: "checkmark")
                                .foregroundColor(configuration.isOn ? .white : .clear)
                        }
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
            configuration.label
        }
    }
}


