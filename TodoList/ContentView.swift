//
//  ContentView.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State private var taskName: String = ""
    @State private var priority: Priority = .medium
    
    @ObservedResults(Task.self) var tasks: Results<Task>
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                TextField("Enter task", text: $taskName)
                    .textFieldStyle(.roundedBorder)
                Picker("Priority", selection: $priority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue)
                    }
                }.pickerStyle(.segmented)
                
                Button {
                    // action
                    let task = Task()
                    task.title = taskName
                    task.priority = priority
                    
                    $tasks.append(task)
                    
                    taskName = ""
                    
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)

                TodoListView()
                
                Spacer()
                
                .navigationTitle("Tasks")
                
            }.padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
