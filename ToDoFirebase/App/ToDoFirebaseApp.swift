//
//  ToDoFirebaseApp.swift
//  ToDoFirebase
//
//  Created by Ivan Dimitrov on 5.02.21.
//

import SwiftUI
import Firebase

@main
struct ToDoFirebaseApp: App {
    
    init() {
      FirebaseApp.configure()
        if Auth.auth().currentUser == nil {
      Auth.auth().signInAnonymously()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
