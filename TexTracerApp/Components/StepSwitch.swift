//
//  StepSelectorRectangle.swift
//  TexTracerApp
//
//  Created by opendag on 15/12/2023.
//

import SwiftUI

struct StepSwitch: View {
    let text: String
    @State private var isToggled = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(isToggled ? Color.theme.accentColor : Color.theme.accentColor.opacity(0))
                .stroke(isToggled ? .white : Color.theme.accentColor, lineWidth: 2)
                .frame(width: 130, height: 44) // Adjusted height to match a typical button size
                .onTapGesture {
                    withAnimation {
                        isToggled.toggle()
                    }
                }
            
            HStack(spacing: 16) {
                Text(text)
                    .foregroundColor(isToggled ? .white : Color.theme.accentColor)
                    .font(.headline) // Adjusted font size to match a typical button size
                
                Image(systemName: isToggled ? "checkmark" : "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(isToggled ? .white : Color.theme.accentColor)
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        withAnimation {
                            isToggled.toggle()
                        }
                    }
            }
        }
    }
}

#Preview {
    StepSwitch(text: "Ginning")
}
