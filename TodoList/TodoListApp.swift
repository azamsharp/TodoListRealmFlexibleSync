//
//  TodoListApp.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import SwiftUI

@main
struct TodoListApp: App {
    
    @StateObject private var realmManager = RealmManager.shared
    
    var body: some Scene {
        WindowGroup {
            VStack {
                
                if let configuration = realmManager.configuration, let realm = realmManager.realm {
                    ContentView()
                        .environment(\.realmConfiguration, configuration)
                        .environment(\.realm, realm)
                }
                
                
            }.task {
                try? await realmManager.initialize()
            }
        }
    }
}
