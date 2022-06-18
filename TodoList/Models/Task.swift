//
//  Task.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import Foundation
import RealmSwift

enum Priority: String, CaseIterable, PersistableEnum {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

class Task: Object, Identifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    @Persisted var isCompleted: Bool = false
    @Persisted var priority = Priority.medium
    @Persisted var notes: List<Note> = List<Note>() 
}
