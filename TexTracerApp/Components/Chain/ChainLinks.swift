import SwiftUI

struct ChainLinks: View {
    let orderSteps: [OrderStep]

    @State private var isCheckmarkSelected: Bool = false
    @State private var fillColor = Color.theme.violetUltraLightColor

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(orderSteps.indices) { index in
                HStack {
                    VStack(spacing: 0) {
                        if index < orderSteps.indices.last ?? 0 {
                            OneChainLink(orderStep: orderSteps[index])
                            Rectangle()
                                .frame(width: 3, height: 32)
                                .foregroundColor(Color.theme.darkGreyColor)
                        } else {
                            LastChainLink(orderStep: orderSteps[index])
                            Rectangle()
                                .frame(width: 3, height: 32)
                                .foregroundColor(Color.clear) // Set transparent color for Rectangle after LastChainLink
                        }
                    }

                    Text(orderSteps[index].step.stringValue)
                        .padding(.bottom, 30)
                        .padding(.leading, 3)
                }
            }
        }
    }
}






//#Preview {
//    
//    @State var selectedOrderSteps: [OrderStep] = []
//
//    ChainLinks(orderSteps: [
//        OrderStep(id: UUID(), step: Step.Spinning, supplierId: UUID()),
//        OrderStep(id: UUID(), step: Step.Ginning, supplierId: UUID()),
//        OrderStep(id: UUID(), step: Step.Trims, supplierId: UUID()),
//        OrderStep(id: UUID(), step: Step.Packing, supplierId: UUID())
//    ])
//    
//}





