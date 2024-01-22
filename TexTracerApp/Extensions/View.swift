import SwiftUI

extension View {
    
    @ViewBuilder
    func omit(if value: Bool) -> some View {
        if value {
            EmptyView()
        } else {
            self
        }
    }
    
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
