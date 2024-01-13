import SwiftUI

struct SelectStepsPage: View {
    
    let task: Task
    @StateObject var selectedDataStore = SelectedDataStore()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                Text("For what steps do you want to upload order evidence?")
                
                Chain(task: task)
                
                CustomButton(action: {
                    // Activate the navigation link
                    
                }) {
                    Text("Upload evidence")
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            
            
        }
        .navigationBarTitle("Select steps")
        
    }
}

#Preview {
    SelectStepsPage(task: Task.uploadTaskTest)
        .environmentObject(TasksStore.test)
}
