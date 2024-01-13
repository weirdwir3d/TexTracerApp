import SwiftUI

struct SelectOrdersPage: View {
    
    @EnvironmentObject var selectedDataStore: SelectedDataStore
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SelectOrdersPage()
        .environmentObject(SelectedDataStore())
}
