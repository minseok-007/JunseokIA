//
//  User.swift
//  Secondhand_Market
//
//  Created by Minseok Chey on 7/21/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var email: String
    var password: String
    var username: String
    var products: [Product]
    var score: Double
    
    init(id: String, email: String, password: String, username: String) {
        self.id = id
        self.email = email
        self.password = password
        self.username = username
    }
}
