//
//  ViewModel.swift
//  A1-App
//
//  Created by Vedant Patle on 20/09/25.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var allUsers: [UserItem] = []
    @Published var users: [UserItem] = []
    @Published var isLoading = false
    @Published var hasMore = true
    
    private var currentPage = 0
    private let pageSize = 10
    
    
    func fetchAllUsers() async {
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "https://core-apis.a1apps.co/ios/interview-details"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let response = try JSONDecoder().decode(UserResponse.self, from: data)
            self.allUsers = response.data
            print(self.allUsers)
            
            // Load the first page
            self.users = Array(self.allUsers.prefix(pageSize))
            self.currentPage = 1
            self.hasMore = self.users.count < self.allUsers.count
            
        } catch {
            print("Error fetching users:", error.localizedDescription)
            self.hasMore = false
        }
        
        isLoading = false
    }
    
    
    func loadMoreUser() {
        guard hasMore, !isLoading else { return }
        
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, allUsers.count)
        
        guard startIndex < endIndex else {
            hasMore = false
            return
        }
        
        isLoading = true
        
        // Simulating lazy loading to see the paging effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.users.append(contentsOf: self.allUsers[startIndex..<endIndex])
            self.currentPage += 1
            self.isLoading = false
            self.hasMore = self.users.count < self.allUsers.count
        }
    }
}
