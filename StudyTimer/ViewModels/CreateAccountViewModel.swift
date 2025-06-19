
import Foundation
import Firebase
import FirebaseAuth

class CreateAccountViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showingAlert = false
    @Published var alertMessage: String = ""
    
    func registerNewUser(completion: @escaping (Bool) -> Void) {
           Auth.auth().createUser(withEmail: email, password: password) { result, error in
               if let error = error {
                   self.alertMessage = "Auth error: \(error.localizedDescription)"
                   self.showingAlert = true
                   completion(false)
                   return
               }

               guard let uid = result?.user.uid else {
                   self.alertMessage = "Could not get user ID."
                   self.showingAlert = true
                   completion(false)
                   return
               }

               let defaultSettings = Settings()
               let newUser = User(id: uid, email: self.email, settings: defaultSettings)

               do {
                   try Firestore.firestore().collection("users").document(uid).setData(from: newUser)
                   completion(true)
               } catch {
                   self.alertMessage = "Firestore error: \(error.localizedDescription)"
                   self.showingAlert = true
                   completion(false)
               }
           }
       }
}
