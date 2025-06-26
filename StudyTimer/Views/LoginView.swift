//
//  ProfileView.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/16/25.
//
import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
// Assuming screenSize is defined globally or elsewhere in your app

// Starting login view --> Create Account View --> login view

struct LoginView: View {
    
    @EnvironmentObject private var baseVM: BaseViewModel
    @StateObject private var loginModel = LoginViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            VStack {
                
                Image(systemName: "graduationcap")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .padding()
                
                VStack(spacing: 20) {
                    
                    Text("Log In")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    TextField("Email", text: $loginModel.email)
                        .padding()
                        .background(Color(UIColor(hex: 0xefefef)))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $loginModel.password)
                        .padding()
                        .background(Color(UIColor(hex: 0xefefef)))
                        .cornerRadius(8)
                        .submitLabel(.done)
                    
                    Button(action: {
                        loginModel.loginUser(baseModel: baseVM) {
                            
                            dismiss()
                        }
                    }) {
                        Text("Log In")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        loginModel.showingCreateAccountView = true
                    }) {
                        Text("Don't have an account? Sign up")
                            .foregroundColor(.black)
                            .font(.footnote)
                    }
                    .padding(.top, 10)
                }
                .padding(30)
                .frame(width: screenSize.width * 0.85)
                .background(Color.white)
                .cornerRadius(12)
                .alert(loginModel.alertMessage, isPresented: $loginModel.showingAlert) {
                    Button("OK", role: .cancel) {}
                }
            }
            .frame(width: screenSize.width, height: screenSize.height, alignment: .center)
            .background(Color(UIColor(hex: 0xE84D4D))) // Red background
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $loginModel.showingCreateAccountView) {
                CreateAccountView()
                    .onDisappear() {
                        // done
                    }
            }
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
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
    LoginView()
        .environmentObject(BaseViewModel())
}
