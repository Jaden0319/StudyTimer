
import Foundation
import Firebase
import FirebaseAuth

class CreateAccountViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    @Published var showingAlert = false
    @Published var alertMessage: String = ""
    //need to add code to check for empty nickname
    
    func registerNewUser(completion: @escaping (Bool) -> Void) {
        
        let db = Firestore.firestore()
        let trimmedNickname = nickname.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if trimmedNickname.isEmpty {
            self.alertMessage = "Nickname Cannot be Empty."
            self.showingAlert = true
            completion(false)
            return
        }
        
        // Check if nickname already exists
        db.collection("users")
            .whereField("nickname", isEqualTo: self.nickname)
            .getDocuments { snapshot, error in
                if let error = error {
                    self.alertMessage = "Nickname check failed: \(error.localizedDescription)"
                    self.showingAlert = true
                    completion(false)
                    return
                }
                
                if let documents = snapshot?.documents, !documents.isEmpty {
                    self.alertMessage = "That nickname is already taken. Please choose another."
                    self.showingAlert = true
                    completion(false)
                    return
                }
                
                Auth.auth().createUser(withEmail: self.email, password: self.password) { result, error in
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
                    let newUser = User(id: uid, email: self.email, nickname: self.nickname, settings: defaultSettings, profileIcon: "man1")
                    
                    do {
                        try db.collection("users").document(uid).setData(from: newUser)
                        
                        // Weekly usage
                        let calendar = Calendar.current
                        let now = Date()
                        let week = calendar.component(.weekOfYear, from: now)
                        let year = calendar.component(.yearForWeekOfYear, from: now)
                        
                        let usageData: [String: Any] = [
                            "userId": uid,
                            "nickname": self.nickname,
                            "profileIcon": "man1",
                            "weekOfYear": week,
                            "year": year,
                            "totalSeconds": 0
                        ]
                        
                        db.collection("users")
                            .document(uid)
                            .collection("weeklyUsage")
                            .addDocument(data: usageData)
                        
                        // Activity summary
                        let activityData: [String: Any] = [
                            "userId": uid,
                            "totalSeconds": 0.0,
                            "lastDayActive": Timestamp(date: now),
                            "dayStreak": 0,
                            "daysAccessed": 1
                        ]
                        
                        db.collection("users")
                            .document(uid)
                            .collection("activitySummary")
                            .document("summary")
                            .setData(activityData)
                        
                        completion(true)
                        
                    } catch {
                        self.alertMessage = "Firestore error: \(error.localizedDescription)"
                        self.showingAlert = true
                        completion(false)
                    }
                }
            }
    }
}
