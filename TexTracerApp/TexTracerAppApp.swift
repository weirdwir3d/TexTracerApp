//
//  TexTracerAppApp.swift
//  TexTracerApp
//
//  Created by opendag on 01/12/2023.
//

import SwiftUI

@main
struct TexTracerAppApp: App {
    var body: some Scene {
        WindowGroup {
            
            //Zara assigns a contractual partner to fill in the supply chain steps of a new orderline
            let zara = Brand(id: UUID(), registrationNr: 1, name: "Zara")
            let texfiber = Supplier(id: UUID(), registrationNr: 2, name: "Texfiber")
            let finestitch = Supplier(id: UUID(), registrationNr: 3, name: "Finestitch")
            
            //steps:
            //trims, spinning, ginning, packing -> Texfiber
            //sewing -> Finestitch
            
            //then comes the time when Texfiber is asked to upload order evidence for trims, spinning, ginning and packing. This request is linked to a certain order number, in this case FFA534, linked to orderline of id 1
            
            ContentView()
        }
    }
}
