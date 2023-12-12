//
//  MyAccountPage.swift
//  TexTracerApp
//
//  Created by opendag on 12/12/2023.
//

import SwiftUI

struct MyAccountPage: View {
    var body: some View {
        
        NavigationStack {
            Text("My Account")
        }.navigationTitle("My Account")
    }
}

#Preview {
    NavigationView{
        MyAccountPage()
    }
}
