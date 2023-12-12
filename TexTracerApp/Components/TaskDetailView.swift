//
//  TaskDetailView.swift
//  TexTracerApp
//
//  Created by opendag on 12/12/2023.
//

import SwiftUI

struct TaskDetailView: View {
    
    let task: Task
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TaskDetailView(task: Task(id: 1, receivedDate: Date.now))
}
