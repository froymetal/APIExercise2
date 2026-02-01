//
//  UsersView.swift
//  APIExercise2
//
//  Created by Froylan Almeida on 1/22/26.
//

import SwiftUI

struct UsersView: View {
    @State var viewModel: UsersViewModel
    @State private var searchText = ""
    @State private var selectedUser: UsersResponse?
    @State private var showModifyView = false
    
    var filteredUsers: [UsersResponse] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { user in
                user.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        if viewModel.isLoading && viewModel.users.isEmpty {
            ProgressView("Loading users...")
        } else {
            NavigationStack {
//            VStack(alignment: .center) {
//                Text("Users")
//                    .font(.largeTitle)
//            }
                VStack {
                    List {
                        ForEach(filteredUsers) { user in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("User: \(user.name)")
                                    .bold()
                                    .font(.body)
                                Text("Email: \(user.email)")
                                    .font(.caption)
                                Text("website: \(user.website)")
                                    .font(.caption)
                                Text("Phone Number: \(user.phone)")
                                    .font(.caption)
                                    .padding(.bottom, 6)
                                Text("Address: \(user.address.street), \(user.address.suite) \n \(user.address.city)\n \(user.address.zipcode), \(user.address.zipcode)")
                                    .font(.caption)
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    selectedUser = user
                                    showModifyView = true
                                } label: {
                                    Label("Modify", systemImage: "person.fill.checkmark")
                                }
                                .tint(.green)
                            }
                        }
                    }
                    .padding()
                    .listStyle(PlainListStyle())
                }
                .navigationTitle(Text("Users"))
                .searchable(text: $searchText, placement: .automatic, prompt: "Search by name") // Search bar
                .sheet(isPresented: $showModifyView) {
//                    guard selectedUser != nil else {
//                        return
//                    }
                    if let user = selectedUser {
                        ModifyUsersView(user: user, viewModel: viewModel)
                    }
                }
                .onAppear {
                    viewModel.fetchUsers()
                }
            }
            
        }
    }
}
