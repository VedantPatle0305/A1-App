//
//  UserCardView.swift
//  A1-App
//
//  Created by Vedant Patle on 20/09/25.
//

import SwiftUI

struct UserCardView: View {
    let user: UserItem
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile Image
            AsyncImage(url: URL(string: user.image)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Details
            VStack(alignment: .leading, spacing: 6) {
                Text(user.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(user.email)  // static like in screenshot
                    .font(.subheadline)
                    .foregroundColor(.red)
                
//                HStack(spacing: 4) {
//                    ForEach(0..<5) { index in
//                        Image(systemName: index < 3 ? "star.fill" : "star") // fake rating
//                            .foregroundColor(.orange)
//                            .font(.caption)
//                    }
//                }
                
                Text(user.dob) // static price
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Shop Button
            Button(action: {}) {
                Text("Age: \(user.age)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(
                        LinearGradient(colors: [Color.pink, Color.purple],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}

extension UserItem {
    static let preview = UserItem(
        image: "https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/10.jpg",
        email: "preview@email.com",
        name: "John Doe",
        age: 30,
        dob: "1995-01-01"
    )
}

#Preview {
    UserCardView(user: .preview)
        .padding()
}
