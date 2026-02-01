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
    @State private var editedEmail: String
    @State private var editedPhone: String
    @State private var editedWebsite: String
    //Address
    @State private var editedStreet: String
    @State private var editedCity: String
    @State private var editedZipCode: String
//    @State private var editedCompany: String
    
    init(user: UsersResponse, viewModel: UsersViewModel) {
        self.user = user
        self.viewModel = viewModel
        self._editedName = State(initialValue: user.name)
        self._editedEmail = State(initialValue: user.email)
        self._editedPhone = State(initialValue: user.phone)
        self._editedWebsite = State(initialValue: user.website)
        self._editedStreet = State(initialValue: user.address.street)
        self._editedCity = State(initialValue: user.address.city)
        self._editedZipCode = State(initialValue: user.address.zipcode)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User Information")) {
                    HStack{
                        Text("Name : ").font(.caption)
                        TextField("Name", text: $editedName)
                    }
                    HStack{
                        Text("Email : ").font(.caption)
                        TextField("Email", text: $editedEmail)
                    }
                    HStack{
                        Text("Phone : ").font(.caption)
                        TextField("Phone", text: $editedPhone)
                    }
                    HStack{
                        Text("Website : ").font(.caption)
                        TextField("Website", text: $editedWebsite)
                    }
                    VStack {
                        Text("Address").font(.caption)
                        HStack{
                            Text("Street : ").font(.caption)
                            TextField("Street", text: $editedStreet)
                        }
                        HStack{
                            Text("City : ").font(.caption)
                            TextField("City", text: $editedCity)
                        }
                        HStack{
                            Text("Zip : ").font(.caption)
                            TextField("Zip", text: $editedZipCode)
                        }
                    }
//                    TextField("Company", text: $editedCompany)
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
                    Button("Save Changes") {
                        saveChanges()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveChanges() {
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
