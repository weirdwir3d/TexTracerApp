//
//  TaskDetailsView.swift
//  TexTracerApp
//
//  Created by opendag on 12/12/2023.
//

import SwiftUI

struct TaskView: View {
    
    let task: Task
    
    var body: some View {
        NavigationLink(destination: TaskDetailView(task: task)) {
              HStack {
//                Image(playlist.coverImage)
//                  .resizable()
//                  .aspectRatio(contentMode: .fill)
//                  .frame(width: 70, height: 70)
//                  .cornerRadius(5)
//                  .padding(.leading, 8)
                  Text("Task with id \(task.id)")
                  .font(.headline)
                  .lineLimit(1)
                Spacer()
              }
              .padding(.vertical, 8)
            }
          }
    }


//#Preview {
//    TaskDetailsView(task: task)
//}
