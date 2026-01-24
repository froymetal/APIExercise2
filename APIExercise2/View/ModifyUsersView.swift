//
//  ModifyUsersView.swift
//  APIExercise2
//
//  Created by Froylan Almeida on 1/22/26.
//

import SwiftUI

struct ModifyUsersView: View {
    @Environment(\.dismiss) var dismiss
    let user: UsersResponse
    let viewModel: UsersViewModel
    @State private var editedName: String
    @State private var editedPhone: String
    @State private var editedWebsite: String
    
    init(user: UsersResponse, viewModel: UsersViewModel) {
        self.user = user
        self.viewModel = viewModel
        self._editedName = State(initialValue: user.name)
        self._editedPhone = State(initialValue: user.phone)
        self._editedWebsite = State(initialValue: user.website)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User Information")) {
                    TextField("Name", text: $editedName)
                    TextField("Phone", text: $editedPhone)
                    TextField("Website", text: $editedWebsite)
                }
            }
            .navigationTitle("Modify User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveChanges()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveChanges() {
        // Crear un nuevo UsersResponse con los valores editados
        // La dirección se mantiene sin cambios
        let updatedUser = UsersResponse(
            id: user.id,
            name: editedName,
            username: user.username,
            email: user.email,
            address: user.address,
            phone: editedPhone,
            website: editedWebsite,
            company: user.company
        )
        
        // Update  user in viewModel
        viewModel.updateUser(updatedUser)
    }
}
