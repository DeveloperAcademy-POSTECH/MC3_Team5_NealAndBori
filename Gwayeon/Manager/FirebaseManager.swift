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
    
    /// 유저이름과 pinCode(4자리)를 가지고 유저정보인 "User들을" 가져오는 함수(파베에선 해당 field값을 가진 문서가 유일하다고 판단 불가)
    /// - Parameters:
    ///   - userName: 유저이름
    ///   - pinCode: 핀코드
    func fetchUserInformation(userName: String, pinCode: String, completion: @escaping (Result<[User], Error>) -> Void) {
        
        FirebaseManager.db.collection("Users").whereField("userName", isEqualTo: userName).whereField("pinCode", isEqualTo: pinCode).getDocuments { querySnapshot, err in
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
    
    /// 유저의 uid를 가지고 유저정보인 "1명의 User를" 가져오는 함수
    /// - Parameters:
    ///   - uid: 유저 고유의 파이어베이스 문서ID
    func fetchUserInformation(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        let ref = FirebaseManager.db.collection("Users").document(uid)
        
        ref.getDocument(as: User.self) { results in
            switch results {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 특정 userName과 pinCode을 가진 사람이 쓴 "Recommend들을" 가져오는 함수
    /// - Parameters:
    ///   - userName: 유저의의 이름
    ///   - pinCode: 핀코드
    func fetchRecommendInformation(userName: String, pinCode: String, completion: @escaping (Result<[Recommend], Error>) -> Void) {

        FirebaseManager.db.collection("Recommends").whereField("pinCode", isEqualTo: pinCode).whereField("userName", isEqualTo: userName).getDocuments { querySnapshot, err in
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
    
    
    /// recommend 문서 ID를 가지고 Recommend를 가져오는 함수
    /// - Parameters:
    ///   - userName: 유저의의 이름
    ///   - pinCode: 핀코드
    func fetchRecommendInformation(recommendId: String, completion: @escaping (Result<Recommend, Error>) -> Void) {
        let ref = FirebaseManager.db.collection("Recommends").document(recommendId)
        
        ref.getDocument(as: Recommend.self) { results in
            switch results {
            case .success(let recommend):
                completion(.success(recommend))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 자기 자신의 고유 userId 사람이 쓴 "Recommend들을" 가져오는 함수
    /// - Parameters:
    ///   - uid: 유저의의 고유 userId
    func fetchRecommendInformation(uid: String, completion: @escaping (Result<[Recommend], Error>) -> Void) {

        FirebaseManager.db.collection("Recommends").whereField("userId", isEqualTo: uid).getDocuments { querySnapshot, err in
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
    
    /// 생성한 User정보를 Firebase Users로 보내는 함수
    /// - Parameters:
    ///   - userName: 유저가 설정한 이름
    ///   - pinCode: 앱에서 생성한 4자리 코드
    func requestUserInformation(userName: String, pinCode: String) {
        do {
            let ref = FirebaseManager.db.collection("Users").document()
            let user = User(uid: ref.documentID, email: "", userName: userName, pinCode: pinCode, userImageName: "peaches", friends: nil, buyFruits: nil, recommends: nil)
            try ref.setData(from: user)
            
        } catch let error {
            print("Error wrong to User to Firestore: \(error)")
        }
    }
    
    /// User가 추천평을 쓰는 함수
    /// - Parameters:
    ///   - userId: user의 고유 아이디
    ///   - userName: user의 고유이름
    ///   - fruitID: 과일 문서의 고유 ID
    ///   - comment: 추천평
    func requestRecommend(userId: String, userName: String, fruitId: String, comment: String) {
        let recommend = Recommend(userId: userId, fruitId: fruitId, userName: userName, comment: comment)
        
        do {
            let ref = FirebaseManager.db.collection("Recommends").document()
            try ref.setData(from: recommend)
            FirebaseManager.db.collection("Users").document(userId).updateData(["recommends": FieldValue.arrayUnion([ref.documentID])])
            
        } catch let error {
            print("Error wrong to User to Firestore: \(error)")
        }
    }
    
}
