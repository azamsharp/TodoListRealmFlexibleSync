//
//  TaskCellView.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import SwiftUI

struct TaskCellView: View {
    
    let task: Task
    @Environment(\.realm) var realm
        
    private func priorityBackground(_ priority: Priority) -> Color {
        switch priority {
            case .low:
                return .gray
            case .medium:
                return .orange
            case .high:
                return .red
        }
    }

    var body: some View {
        NavigationLink {
            NotesView(task: task)
        } label: {
            HStack {
                Image(systemName: task.isCompleted ? "checkmark.square": "square")
                    .onTapGesture {
                        let taskToUpdate = realm.object(ofType: Task.self, forPrimaryKey: task._id)
                        try? realm.write {
                            taskToUpdate?.isCompleted.toggle()
                        }
                    }
                Text(task.title)
                Spacer()
                Text(task.priority.rawValue)
                    .padding(6)
                    .frame(width: 75)
                    .background(priorityBackground(task.priority))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }
        }
    }
}

