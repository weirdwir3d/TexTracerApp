//
//  TasksPage.swift
//  TexTracerApp
//
//  Created by opendag on 12/12/2023.
//

import SwiftUI

struct TasksPage: View {
    
    @State var tasks = [
        Task(id: 1, receivedDate: Date()),
        Task(id: 2, receivedDate: Date()),
        Task(id: 3, receivedDate: Date())
    ]
    
    var body: some View {
        NavigationStack {
            List {
                  ForEach(tasks) { task in
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
    }
}
