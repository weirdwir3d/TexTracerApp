//
//  CompliancePage.swift
//  TexTracerApp
//
//  Created by opendag on 12/12/2023.
//

import SwiftUI

struct CompliancePage: View {
    var body: some View {
        
        NavigationStack{
            Text("Compliance")
        }.navigationTitle("Compliance")
        
    }
}

#Preview {
    NavigationView{
        CompliancePage()
    }
}
