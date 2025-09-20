//
//  DataModel.swift
//  A1-App
//
//  Created by Vedant Patle on 20/09/25.
//
import Foundation

struct UserResponse: Codable {
    let data: [UserItem]
}

struct UserItem: Codable, Identifiable{
    var id: String {email}
    let image: String
    let email: String
    let name: String
    let age: Int
    let dob: String
}


