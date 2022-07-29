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
    
//    친구추가시 사용되는 함수, 닉네임과 핀코드를 가지고 사람 정보를 불러온다 .
    func getUserInformationFromPinCode(username: String, pinCode: String, completion: @escaping (Result<[User], Error>) -> Void) {
        
        FirebaseManager.db.collection("User").whereField("pinCode", isEqualTo: pinCode).whereField("username", isEqualTo: username).getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(.failure(err))
                } else {
                    let datas = querySnapshot!.documents.map { try? $0.data(as: User.self) }
                    let users = datas.compactMap({ $0 })
                    if users.count > 1 {
                        completion(.failure(APIError.duplicatedUser))
                    }
                    completion(.success(users))
                }
        }
    }

//    pinCode와 nickname을 가지고 해당 유저가 만
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
    
//    pinCode와 username을 가지고 새로운 User정보를 생산한다.
    func sendUserInformation(pinCode: String, username: String) {
        let user = User(pinCode: pinCode, username: username, friends: [], recommends: [])
        do {
            try FirebaseManager.db.collection("Users").document().setData(from: user)
        } catch let error {
            print("Error wrong to User to Firestore: \(error)")
        }
    }
    
    func sendRecommend(uid: String, nickname: String, fruitID: String, comment: String) {
        let recommend = Recommend(uid: uid, fruitID: fruitID, nickname: nickname, comment: comment)
        do {
            let ref = FirebaseManager.db.collection("Recommends").document()
            try ref.setData(from: recommend)
            FirebaseManager.db.collection("Users").whereField("uid", isEqualTo: uid).whereField("username", isEqualTo: nickname).getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    querySnapshot?.documents.forEach({ document in
                        document.reference.updateData(["recommendLists": FieldValue.arrayUnion([ref.documentID])])
                    })
                }
            }
            
        } catch let error {
            print("Error wrong to User to Firestore: \(error)")
        }
    }
    
}
