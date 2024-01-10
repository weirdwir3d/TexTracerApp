import SwiftUI

struct TasksPage: View {
    
    @EnvironmentObject var tasksStore: TasksStore
    @State private var favoriteColor = 0
    
    var body: some View {
        NavigationStack {
            //TODO: add task segment picker
//            VStack {
//                        Picker("What is your favorite color?", selection: $favoriteColor) {
//                            Text("Red").tag(0)
//                            Text("Green").tag(1)
//                            Text("Blue").tag(2)
//                        }
//                        .pickerStyle(.segmented)
//
//                        Text("Value: \(favoriteColor)")
//                    }
            
            
            List {
                ForEach(tasksStore.getTasks()) { task in
                    TaskView(task: task)
                  }
                }
        }
        .navigationTitle("Tasks")
    }
}

#Preview {
    NavigationView {
                TasksPage()
                    .environmentObject(TasksStore())
            }
}
