import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var baseVM: BaseViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var profileVM: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(30)
                        .padding(.top, 33)
                }

                VStack(spacing: 16) {

                    Button(action: {
                        profileVM.selectedAvatarIndex = Settings.avatars.first(where: { $0.value == baseVM.user.profileIcon })?.key ?? 0
                        profileVM.isEditingAvatar = true
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            Image(baseVM.user.profileIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .padding(.top, 20)

                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.black)
                                .background(Color.white.clipShape(Circle()))
                                .font(.system(size: 24))
                                .offset(x: 1, y: 1)
                        }
                    }

                    Text(baseVM.user.nickname)
                        .font(Font.custom("Avenir-Medium", size: 23))
                        .padding(.bottom, 30)

                    Divider().background(Color.black)

                    VStack(spacing: 20) {
                        ProfileButton(title: "Change Nickname", background: Color(UIColor(hex: 0xefefef)), textColor: .black) {
                            profileVM.editedNickname = baseVM.user.nickname
                            profileVM.isEditingNickname = true
                        }

                        ProfileButton(title: "Log Out", background: Color(UIColor(hex: 0xefefef)), textColor: .black) {
                            baseVM.user = .default
                            baseVM.settingsModel.settings = Settings.default
                            baseVM.reset()
                            baseVM.minutes = baseVM.settingsModel.getModeTime(mode: baseVM.settingsModel.settings.currentMode)
                            dismiss()
                        }

                        ProfileButton(title: "Delete Account", background: Color(UIColor(hex: 0xe60000)).opacity(0.7), textColor: .black) {
                            profileVM.showDeleteConfirmation = true
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    Spacer()
                }
                .frame(width: screenSize.width, height: screenSize.height)
                .background(Color.white)
            }
            .frame(width: screenSize.width, height: screenSize.height, alignment: .topLeading)
            .background(Color.white)

            // MARK: - Nickname Editing Overlay
            if profileVM.isEditingNickname {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Edit Nickname")
                        .font(Font.custom("Avenir-Medium", size: 18))
                        .padding(.top)

                    TextField("Enter new nickname", text: $profileVM.editedNickname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    HStack(spacing: 30) {
                        Button("Cancel") {
                            profileVM.isEditingNickname = false
                        }
                        .font(Font.custom("Avenir-Medium", size: 18))

                        Button("Save") {
                            if !profileVM.editedNickname.isEmpty {
                                profileVM.updateNickname(baseModel: baseVM, newNickname: profileVM.editedNickname)
                                baseVM.user.nickname = profileVM.editedNickname
                            
                                baseVM.updateWeeklyUsageMetadata()
                                
                            }
                            profileVM.isEditingNickname = false
                        }
                        .font(Font.custom("Avenir-Medium", size: 18))
                    }
                    .padding(.bottom)

                }
                .frame(width: screenSize.width - 90)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
            }

            // MARK: - Delete Confirmation Overlay
            if profileVM.showDeleteConfirmation {
                Color.black.opacity(0.4).ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Are you sure?")
                        .font(Font.custom("Avenir-Medium", size: 18))

                    Text("Deleting your account is permanent and cannot be undone.")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Avenir-Medium", size: 18))
                        .padding(.horizontal)

                    HStack(spacing: 30) {
                        Button("Cancel") {
                            profileVM.showDeleteConfirmation = false
                        }.font(Font.custom("Avenir-Medium", size: 18))

                        Button("Delete") {
                            profileVM.deleteAccount(baseModel: baseVM) { _ in
                            }
                            baseVM.user = .default
                            baseVM.reset()
                            baseVM.minutes = baseVM.settingsModel.getModeTime(mode: baseVM.settingsModel.settings.currentMode)
                            dismiss()
                        }
                        .foregroundColor(.red)
                        .font(Font.custom("Avenir-Medium", size: 18))
                    }
                }
                .frame(width: screenSize.width - 90)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
            }

            // MARK: - Avatar Picker Overlay
            if profileVM.isEditingAvatar {
                Color.black.opacity(0.4).ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Select Your Avatar")
                        .font(Font.custom("Avenir-Medium", size: 18))
                        .padding(.top)

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                        ForEach(Settings.avatars.sorted(by: { $0.key < $1.key }), id: \.key) { index, imageName in
                            avatarButton(for: index, imageName: imageName)
                        }
                    }
                    .padding(.horizontal, 16)

                    HStack(spacing: 40) {
                        Button("Cancel") {
                            profileVM.isEditingAvatar = false
                        }.font(Font.custom("Avenir-Medium", size: 18))

                        Button("Save") {
                            let selectedAvatar = Settings.avatars[profileVM.selectedAvatarIndex] ?? baseVM.user.profileIcon

                                guard selectedAvatar != baseVM.user.profileIcon else {
                                    profileVM.isEditingAvatar = false
                                    return
                                }

                                baseVM.user.profileIcon = selectedAvatar
                                profileVM.updateAvatar(baseModel: baseVM, avatarName: selectedAvatar)
                                baseVM.updateWeeklyUsageMetadata()
                            profileVM.isEditingAvatar = false
                        }.font(Font.custom("Avenir-Medium", size: 18))
                    }
                    .padding(.top)

                }
                .frame(width: screenSize.width - 60)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
            }
        }
    }

    @ViewBuilder
    private func avatarButton(for index: Int, imageName: String) -> some View {
        Button(action: {
            profileVM.selectedAvatarIndex = index
        }) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(6)
                .background(
                    Circle()
                        .stroke(profileVM.selectedAvatarIndex == index ? Color.blue : Color.clear, lineWidth: 3)
                )
        }
    }
}

struct ProfileButton: View {
    let title: String
    let background: Color
    let textColor: Color
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.custom("Avenir-Medium", size: 18))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(background)
                .cornerRadius(10)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(BaseViewModel())
}
