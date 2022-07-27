//
//  FirebaseManager.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/27.
//

import Foundation

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    private static let decoder = JSONDecoder()
    private init() { }
    
    func gerUserInformation(uid: String, completion: @escaping (Result<[User], Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("Users").whereField("uid", isEqualTo: uid).getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var users: [User] = []
                for document in querySnapshot!.documents {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: document.data())
                        let user = try FirebaseManager.decoder.decode(User.self, from: data)
                        users.append(user)
                    } catch {
                        print(error)
                        completion(.failure(error))
                    }
                }
                completion(.success(users))
            }
        }
    }
}
