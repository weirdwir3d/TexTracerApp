//
//  Chain.swift
//  TexTracerApp
//
//  Created by opendag on 12/12/2023.
//

import SwiftUI

struct Chain: View {
    
    @State private var isBlinking = false
    
    var body: some View {
        
        WhiteBox {
            VStack(spacing: 0) {
                //Red icon, title and date block next to assigned by block
                HStack {
                    HStack {
                        OrderBadge(number: 5)
                        VStack {
                            Text("Order")
                            Text("date")
                        }
                    }
                    Spacer()
                    Text("by: FashionLead")
                }
                
                Spacer().frame(height: 20)
                
                HStack {
                    VStack {
                        Text("Style number:")
                        Text("Delivery to:")
                        Text("Final client:")
                    }
                    
                    Spacer()
                }
                
                Spacer().frame(height: 26)
                
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.theme.accentColor)
                
                Rectangle()
                    .frame(width: 3, height: 32)
                    .foregroundColor(Color.theme.blackColor)
                
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 32)
                    .foregroundColor(Color.theme.accentColor)
                
                Rectangle()
                    .frame(width: 3, height: 32)
                    .foregroundColor(Color.theme.blackColor)
                
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.theme.accentColor)
                    .opacity(isBlinking ? 0.1 : 1)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
                            self.isBlinking.toggle()
                        }
                    }
            }
        }
        
    }
}

#Preview {
    Chain()
}
