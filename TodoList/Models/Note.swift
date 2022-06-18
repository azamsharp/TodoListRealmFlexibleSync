//
//  Note.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import Foundation
import RealmSwift

class Note: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var text: String = ""
}
