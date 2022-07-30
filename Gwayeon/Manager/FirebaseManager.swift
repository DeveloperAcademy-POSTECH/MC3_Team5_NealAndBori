//
//  FirebaseManager.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/27.
//

import Foundation

import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    private static let decoder = JSONDecoder()
    private static let store = Firestore.firestore()
    private static let auth = Auth.auth()
    
    private init() { }
    
    func createNewAccount(email: String, password: String) async {
        do {
            try await FirebaseManager.auth.createUser(withEmail: email, password: password)
            print("Successfully created user")
        } catch {
            print("Failed to create user")
        }
    }
    
    func storeUserInformation(email: String, userName: String, pinCode: String, userImageName: String) async {
        guard let uid = FirebaseManager.auth.currentUser?.uid else { return }
        do {
            let userData = ["email": email, "uid": uid, "userName": userName, "pinCode": pinCode, "userImageName": userImageName]
            try await FirebaseManager.store.collection("users").document(uid).setData(userData)
        } catch {
            print("Store User error")
        }
    }
    
}
