import SwiftUI

struct ChainLinks: View {
    let orderSteps: [OrderStep]

    @State private var isVisible = false
    @State private var isBlinking = true
    @State private var fillColor = Color.theme.violetUltraLightColor

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(orderSteps.indices) { index in
                HStack {
                    VStack(spacing: 0) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .foregroundColor(index == orderSteps.indices.last ? Color.theme.lightGreyColor : fillColor)
                            .onAppear {
                                startBlinking()
                            }
                            .onTapGesture {
                                isBlinking.toggle()
                                if isBlinking {
                                    startBlinking()
                                } else {
                                    print("stops blinking")
                                    stopBlinking()
                                }
                            }

                        if index != orderSteps.indices.last {
                            Rectangle()
                                .frame(width: 3, height: 32)
                                .foregroundColor(Color.theme.darkGreyColor)
                        }
                    }

                    Text(orderSteps[index].step.stringValue)
                        .padding(.bottom, 30)
                        .padding(.leading, 3)
                }
            }
        }
    }

    private func startBlinking() {
        isVisible = true
        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
            fillColor = Color.theme.violetUltraLightColor
        }
    }

    private func stopBlinking() {
        isVisible = false
        fillColor = Color.theme.accentColor
    }
}




#Preview {
    ChainLinks(orderSteps: [
        OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()),
        OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()),
        OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()),
        OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
    ]
    )
}




