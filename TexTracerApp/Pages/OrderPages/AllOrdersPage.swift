import SwiftUI
import Foundation

struct AllOrdersPage: View {
    
    @EnvironmentObject var tasksStore: TasksStore
    @State private var searchText = ""
    @State private var selectedCategory = 0 // Start with Review
    @State private var selectedTask: Task? = nil

    var filteredTasks: [Task] {
        switch selectedCategory {
        case 0:
            return tasksStore.getTasks().filter { $0 is ReviewEvidenceTask }
        case 1:
            return tasksStore.getTasks().filter { $0 is UploadEvidenceTask }
        default:
            return []
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Category", selection: $selectedCategory) {
                    Text("Review").tag(0)
                    Text("Upload").tag(1)
                    Text("History").tag(2)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.top)
                
                SearchBar(searchText: $searchText).padding(.horizontal)
                
                if filteredTasks.isEmpty {
                    Text("No Tasks")
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(filteredTasks) { task in
                                OrderEvidenceDetailBox(task: task)
                            }
                        }
                    }

                }
            }
            .onAppear {
                // Set the navigation bar title directly
                UINavigationBar.appearance().topItem?.title = "All orders"
            }
            .background(Color(.systemBackground))
            .navigationBarTitle("All orders", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    // Handle the action when the filters button is tapped
                }) {
                    Text("Filters")
                }
            )
        }
        .background(Color(.systemBackground))
    }
}



#Preview {
    NavigationView{
        AllOrdersPage()
            .environmentObject(TasksStore.test)
    }
}


struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
    }
}



