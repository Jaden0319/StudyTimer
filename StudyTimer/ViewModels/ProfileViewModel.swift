//
//  ProfileViewModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 7/10/25.
//

import Foundation
import Firebase
import FirebaseAuth
//Check for taken usernames, when assigning
class ProfileViewModel: ObservableObject {
    
    @Published var isEditingNickname = false
    @Published var editedNickname = ""
    @Published var showDeleteConfirmation = false
    @Published var isEditingAvatar = false
    @Published var selectedAvatarIndex = 0
    
    func updateNickname(baseModel: BaseViewModel, newNickname: String) {
        guard let userId = baseModel.user.id else { return }

        let db = Firestore.firestore()
        let usersRef = db.collection("users")

        usersRef
            .whereField("nickname", isEqualTo: newNickname)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error checking nickname: \(error.localizedDescription)")
                    return
                }

                if let documents = snapshot?.documents,
                   documents.contains(where: { $0.documentID != userId }) {
                    print("Nickname '\(newNickname)' is already taken.")
                    return
                }

                let userRef = usersRef.document(userId)
                userRef.updateData(["nickname": newNickname]) { error in
                    if let error = error {
                        print("Error updating nickname: \(error.localizedDescription)")
                    } else {
                        print("Nickname updated successfully to \(newNickname)")
                        DispatchQueue.main.async {
                            baseModel.user.nickname = newNickname
                        }
                    }
                }
            }
    }
    
    //edit for deletion of weekly usage and act summary in fut
    func deleteAccount(baseModel: BaseViewModel, completion: @escaping (Error?) -> Void) {
        guard let userId = baseModel.user.id,
              let user = Auth.auth().currentUser else {
            completion(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }

        let db = Firestore.firestore()

        db.collection("users").document(userId).delete { error in
            if let error = error {
                print("Error deleting Firestore user: \(error.localizedDescription)")
                completion(error)
                return
            }

            user.delete { error in
                if let error = error {
                    print("Error deleting Auth user: \(error.localizedDescription)")
                    completion(error)
                } else {
                    print("User successfully deleted")
                    DispatchQueue.main.async {
                        baseModel.reset()
                        baseModel.user = .default
                    }
                    completion(nil)
                }
            }
        }
    }
    
    func updateAvatar(baseModel: BaseViewModel, avatarName: String) {
        guard let userId = baseModel.user.id else {
            print("No user ID available.")
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)

        userRef.updateData(["profileIcon": avatarName]) { error in
            if let error = error {
                print("Error updating avatar: \(error.localizedDescription)")
            } else {
                print("Avatar updated to \(avatarName)")
                DispatchQueue.main.async {
                    baseModel.user.profileIcon = avatarName
                }
            }
        }
    }
}
