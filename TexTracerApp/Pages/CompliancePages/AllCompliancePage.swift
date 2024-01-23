import SwiftUI

struct AllCompliancePage: View {
    
    @EnvironmentObject var tasksStore: TasksStore
    @State private var searchText = ""
    @State private var selectedCategory = 0
    @State private var selectedTask: Task? = nil

    var filteredTasks: [Task] {
        switch selectedCategory {
        case 0:
            // Filter SignDocumentTasks when "Sign" is selected
            return tasksStore.getTasks().filter { $0 is SignDocumentTask }
        case 1:
            // Filter ReadDocumentTasks when "Read" is selected
            return tasksStore.getTasks().filter { $0 is ReadDocumentTask }
        default:
            return []
        }
    }
    
    var body: some View {
        VStack {
            Picker("Select Category", selection: $selectedCategory) {
                Text("Sign").tag(0)
                Text("Read").tag(1)
                Text("History").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.top)
            
            SearchBar(searchText: $searchText).padding(.horizontal)
            
            ScrollView {
                LazyVStack {
                    // Use conditional casting to filter based on task type
                    if selectedCategory == 0 {
                        ForEach(filteredTasks.compactMap { $0 as? SignDocumentTask }) { task in
                            SignDocumentDetailBox(task: task)
                        }
                    } else if selectedCategory == 1 {
                        ForEach(filteredTasks.compactMap { $0 as? ReadDocumentTask }) { task in
                            ReadDocumentDetailBox(task: task)
                        }
                    }
                }.padding()
            }
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
}

// Preview
struct AllCompliancePage_Previews: PreviewProvider {
    static var previews: some View {
        AllCompliancePage()
            .environmentObject(TasksStore.test)
    }
}

