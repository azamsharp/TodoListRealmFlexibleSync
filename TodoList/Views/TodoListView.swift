//
//  TodoListView.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import SwiftUI
import RealmSwift

enum Sections: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct TodoListView: View {
    
    @Environment(\.realm) private var realm
    @ObservedResults(Task.self) var tasks: Results<Task>
    
    var pendingTasks: [Task] {
        tasks.filter { $0.isCompleted == false }
    }
    
    var completedTasks: [Task] {
        tasks.filter { $0.isCompleted == true }
    }
    
    var body: some View {
        List {
            ForEach(Sections.allCases, id: \.self) { section in
                Section {
                    
                    let filteredTasks = section == .pending ? pendingTasks: completedTasks
                    
                    if filteredTasks.isEmpty {
                        Text("No tasks.")
                    }
 
                    ForEach(filteredTasks, id: \._id) { task in
                       TaskCellView(task: task)
                    }.onDelete { indexSet in
                        
                        indexSet.forEach { index in
                            let task = filteredTasks[index]
                            
                            guard let taskToDelete = realm.object(ofType: Task.self, forPrimaryKey: task._id) else {
                                return
                            }
                            
                            // delete all notes of a selected task
                            for note in taskToDelete.notes {
                                try? realm.write {
                                    realm.delete(note)
                                }
                            }
                            
                            $tasks.remove(taskToDelete)
                            
                        }
                        
                    }
                } header: {
                    Text(section.rawValue)
                }

            }
        }.listStyle(.plain)
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
