//
//  UserModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/18/25.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var email: String
    var nickname: String
    var settings: Settings
    
    static let `default` = User(id: nil, email: "", nickname: "defualt", settings: .default)
}
