//
//  User.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/27.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    let uid, email, userName, pinCode, userImageName: String
    let friends, buyingFruits, recommends: [String]?
    
}
