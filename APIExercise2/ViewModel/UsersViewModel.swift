//
//  UsersViewModel.swift
//  APIExercise2
//
//  Created by Froylan Almeida on 1/22/26.
//

import Foundation
import Combine

@Observable
class UsersViewModel {
    var users: [UsersResponse] = []
    var isLoading = false
    var errorMessage: String?
    var showError = false
    
    private let networkService = NetworkService.shared
    
    
    func fetchUsers() {
        isLoading = true
        errorMessage = nil
        showError = false
        
        Task {
            do {
                let fetchedUsers = try await networkService.fetchUsers()
                await MainActor.run {
                    self.users = fetchedUsers
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                }
            }
        }
    }
    
    func updateUser(_ updatedUser: UsersResponse) {
        if let index = users.firstIndex(where: { $0.id == updatedUser.id }) {
            users[index] = updatedUser
        }
    }
}
