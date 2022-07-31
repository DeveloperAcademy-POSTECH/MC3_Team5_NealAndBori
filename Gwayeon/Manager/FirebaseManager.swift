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
    private static let db = Firestore.firestore()
    
    private init() { }
    
    func getUserInformation(uid: String, completion: @escaping (Result<[User], Error>) -> Void) {
        
        FirebaseManager.db.collection("Users").whereField("uid", isEqualTo: uid).getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(.failure(err))
                } else {
                        let datas = querySnapshot!.documents.map { try? $0.data(as: User.self) }
                        let users = datas.compactMap({ $0 })
                        completion(.success(users))
                }
        }
    }
    
    func getRecommendInformation(uid: String, nickname: String, completion: @escaping (Result<[Recommend], Error>) -> Void) {
        
        FirebaseManager.db.collection("Recommends").whereField("uid", isEqualTo: uid).whereField("nickname", isEqualTo: nickname).getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                    let datas = querySnapshot!.documents.map { try? $0.data(as: Recommend.self) }
                    let recommends = datas.compactMap({ $0 })
                    completion(.success(recommends))
            }
        }
    }
    
    func sendUserInformation(uid: String, nickname: String) {
        let user = User(uid: uid, username: nickname, friends: [], recommends: [])
        do {
            try FirebaseManager.db.collection("Users").document().setData(from: user)
        } catch let error {
            print("Error wrong to User to Firestore: \(error)")
        }
    }
    
    func sendRecommend(uid: String, nickname: String, fruitID: String, comment: String) {
        let recommend = Recommend(id: uid, comment: fruitID, userId: nickname, fruitId: comment)
        do {
            let ref = FirebaseManager.db.collection("Recommends").document()
            try ref.setData(from: recommend)
            FirebaseManager.db.collection("Users").whereField("uid", isEqualTo: uid).whereField("username", isEqualTo: nickname).getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    querySnapshot?.documents.forEach({ document in
                        document.reference.updateData(["recommends": FieldValue.arrayUnion([ref.documentID])])
                    })
                }
            }
            
        } catch let error {
            print("Error wrong to User to Firestore: \(error)")
        }
    }
    
}
