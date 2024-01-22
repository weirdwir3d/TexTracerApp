import SwiftUI

struct WhiteBox<Content: View>: View {
    var content: Content
    var paddingAmount: CGFloat
    var paddingEdges: Edge.Set
    
    init(paddingAmount: CGFloat? = nil, paddingEdges: Edge.Set? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.paddingAmount = paddingAmount ?? 0
        self.paddingEdges = paddingEdges ?? .all
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            )
            .padding(paddingEdges, paddingAmount)
    }
}


#Preview {
    WhiteBox(paddingAmount: 20, paddingEdges: .all) {
        Text("Your content here")
    }
}


