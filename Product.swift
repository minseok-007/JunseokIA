//
//  Product.swift
//  Secondhand_Market
//
//  Created by Minseok Chey on 7/24/24.
//

import Foundation

struct Product: Codable {
    var productName: String
    var price: String
    var username: String
    
    init(id: String, email: String, password: String, username: String) {
        self.id = id
        self.email = email
        self.password = password
        self.username = username
    }
}
