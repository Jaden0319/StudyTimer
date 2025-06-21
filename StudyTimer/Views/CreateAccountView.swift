//
//  SignUpView.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/18/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct CreateAccountView: View {
    @StateObject private var createAccountModel = CreateAccountViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .padding()
                
                VStack(spacing: 20) {
                    Text("Create Account")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    TextField("Email", text: $createAccountModel.email)
                        .padding()
                        .background(Color(UIColor(hex: 0xefefef)))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    TextField("Nickname", text: $createAccountModel.nickname)
                        .padding()
                        .background(Color(UIColor(hex: 0xefefef)))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $createAccountModel.password)
                        .padding()
                        .background(Color(UIColor(hex: 0xefefef)))
                        .cornerRadius(8)
                        .submitLabel(.done)
                    
                    Button(action: {
                        createAccountModel.registerNewUser() { success in
                            if success {
                                dismiss()
                            }
                        }
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                    
                    Button("Already have an account? Log in") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                    .font(.footnote)
                    .padding(.top, 10)
                }
                .padding(30)
                .frame(width: screenSize.width * 0.85)
                .background(Color.white)
                .cornerRadius(12)
                .alert(createAccountModel.alertMessage, isPresented: $createAccountModel.showingAlert) {
                    Button("OK", role: .cancel) {}
                }
            }
            .frame(width: screenSize.width, height: screenSize.height, alignment: .center)
            .background(Color(UIColor(hex: 0xE84D4D)))
     
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .padding(12)
                    .background(Color.white.opacity(0.9))
                    .clipShape(Circle())
                    .shadow(radius: 2)
            }
            .padding(.top, 50)
            .padding(.leading, 20)
        }.background(Color(UIColor(hex: 0xE84D4D)))
    }
}


#Preview {
    CreateAccountView()
}

