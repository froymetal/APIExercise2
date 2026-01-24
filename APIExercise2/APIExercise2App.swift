//
//  APIExercise2App.swift
//  APIExercise2
//
//  Created by Froylan Almeida on 1/22/26.
//

import SwiftUI

@main
struct APIExercise2App: App {
    var body: some Scene {
        WindowGroup {
            UsersView(viewModel: UsersViewModel())
        }
    }
}
