//
//  UserViewModel.swift
//  Secondhand_Market
//
//  Created by Minseok Chey on 7/21/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore


class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isUserLoggedIn: Bool = false
    
    private var db = Firestore.firestore()
    
    init() {
        autoLogin()
    }
    
    func fetchCurrentUser() {
      guard let userId = Auth.auth().currentUser?.uid else {
        print("No user is currently logged in.")
        return
      }
      let docRef = db.collection("users").document(userId)
      docRef.getDocument { (document, error) in
        if let document = document, document.exists {
          do {
            self.currentUser = try document.data(as: User.self)
          } catch {
            print("Error decoding user: \(error.localizedDescription)")
          }
        } else {
          print("User does not exist")
        }
      }
    }
    
    func autoLogin() {
        guard let emailData = KeychainService.load(key: "email"),
              let passwordData = KeychainService.load(key: "password"),
              let email = String(data: emailData, encoding: .utf8),
              let password = String(data: passwordData, encoding: .utf8) else {
            DispatchQueue.main.async {
                self.isUserLoggedIn = false
            }
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.isUserLoggedIn = false
                print("Auto login failed: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.isUserLoggedIn = true
                    self.fetchCurrentUser()
                }
            }
        }
    }
    
    func saveUser(_ user: User) {
      guard let uid = Auth.auth().currentUser?.uid else { return }

      do {
        try db.collection("users").document(uid).setData(from: user) { error in
          if let error = error {
            print("Error saving user: \(error.localizedDescription)")
          } else {
            print("User saved successfully")
          }
        }
      } catch let error {
        print("Error saving user: \(error.localizedDescription)")
      }
    }
}
