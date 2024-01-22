import SwiftUI

struct AllCompliancePage: View {
    
    @EnvironmentObject var tasksStore: TasksStore
    @State private var searchText = ""
    @State private var selectedCategory = 0
    @State private var selectedTask: Task? = nil

    var filteredTasks: [Task] {
        switch selectedCategory {
        case 0:
            return tasksStore.getTasks().filter { $0 is ReviewEvidenceTask }
        case 1:
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
                    ForEach(filteredTasks.compactMap { $0 as? ReadDocumentTask }) { task in
                        DocumentDetailBox(task: task)
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

#Preview {
    AllCompliancePage()
        .environmentObject(ReadComplianceDataStore())
}


#Preview {
    AllCompliancePage()
        .environmentObject(ReadComplianceDataStore())
}
