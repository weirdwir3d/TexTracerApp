//
//  OrderBadge.swift
//  TexTracerApp
//
//  Created by opendag on 12/12/2023.
//

import SwiftUI

struct OrderBadge: View {
    var number: Int

        var body: some View {
            ZStack {
                Circle()
                    .foregroundColor(Color.theme.accentColor)
                    .frame(width: 20, height: 20)

                Text("\(number)")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .bold))
            }
        }
}

#Preview {
    OrderBadge(number: 10)
}
