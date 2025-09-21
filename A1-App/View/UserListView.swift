//
//  MainSceenView.swift
//  A1-App
//
//  Created by Vedant Patle on 20/09/25.
//

    import SwiftUI

    struct UserListView: View {
        @StateObject private var vm = UserViewModel()
        
        var body: some View {
            NavigationStack {
                ZStack(alignment: .top) {
                    // Background
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        // Header Gradient
                        LinearGradient(colors: [Color.purple, Color.pink],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                            .frame(height: 200)
                            .overlay(
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("User Details")
                                        .font(.largeTitle.bold())
                                        .foregroundColor(.white)
                                    
                                    Text("Fetched user from API's")
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                .padding(),
                                alignment: .bottomLeading
                            )
                        
                        // List of Users
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(vm.users) { user in
                                    UserCardView(user: user)
                                        .onAppear {
                                            if user.id == vm.users.last?.id {
                                                vm.loadMoreUser()
                                            }
                                        }
                                }
                                
                                if vm.isLoading {
                                    ProgressView().padding()
                                }
                                
                                if !vm.hasMore {
                                    Text("No more users")
                                        .foregroundColor(.gray)
                                        .padding()
                                }
                            }
                            .padding()

                        }
                    }
                    .ignoresSafeArea()
                }
    //            .navigationBarHidden(true)
            }
            .task {
                await vm.fetchAllUsers()
            }
        }
    }

    #Preview {
        let mockVM = UserViewModel()
        mockVM.allUsers = [
            UserItem(image: "...", email: "john@example.com", name: "John Doe", age: 30, dob: "1995-01-01"),
            UserItem(image: "...", email: "jane@example.com", name: "Jane Doe", age: 28, dob: "1997-03-15"),
            UserItem(image: "...", email: "bob@example.com", name: "Bob Smith", age: 35, dob: "1990-07-22"),
            UserItem(image: "...", email: "alice@example.com", name: "Alice Brown", age: 25, dob: "1998-08-10"),
            UserItem(image: "...", email: "mark@example.com", name: "Mark Lee", age: 32, dob: "1991-09-09")
        ]
        mockVM.users = Array(mockVM.allUsers.prefix(4))

        
        return UserListView()
            .environmentObject(mockVM)
    }

