//
//  LoginViewModel.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/18/25.
//

import Foundation
import Firebase
import FirebaseAuth


class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var isLoggedIn = false //will probably remove
    @Published var currentUser: User = .default
    @Published var showingCreateAccountView = false
    
    func loginUser(baseModel: BaseViewModel, onSuccess: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
                return
            }

            guard let user = result?.user else { return }

            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { snapshot, error in
                if let error = error {
                    self.alertMessage = "\(error.localizedDescription)"
                    self.showingAlert = true
                    return
                }

                if let fetchedUser = try? snapshot?.data(as: User.self) {
                    self.currentUser = fetchedUser
                    baseModel.user = self.currentUser
                    baseModel.settingsModel.settings = self.currentUser.settings
                    self.isLoggedIn = true
                    
                    baseModel.updateDaysData()
                    baseModel.dailyUsage()
                    
                    onSuccess()
                } else {
                    self.alertMessage = "Could not find user."
                    self.showingAlert = true
                }
            }
        }
    }
    
    
}
