//
//  LeaderboardView.swift
//  StudyTimer
//
//  Created by Jaden Creech on 6/20/25.
//
import SwiftUI

struct LeaderboardView: View {
    @StateObject private var viewModel = LeaderboardViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            
            // Back button
            /*HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                    Text("Back")
                        .foregroundColor(.black)
                }
                .padding(.leading)
                Spacer()
            }
            .padding(.top, 8)*/
 

            // Subtitle
            Text("Focus Time This Week")
                .font(Font.custom("Avenir-Medium", size: 16))
                .bold()
                .padding(.top, 12)
                .padding(.bottom, 4)

            // Header row
            HStack {
                Text(" ")
                    .frame(width: 30)
                Text("User")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                    .minimumScaleFactor(0.7)
                Spacer()
                Text("TIME (HH:MM)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                    .frame(width: 80, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .padding(.horizontal)
            .padding(.bottom, 6)
            
            Divider()

            // Leaderboard entries
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(Array(viewModel.entries.enumerated()), id: \.1.id) { index, entry in
                        
                    
                        HStack {
                            Text("\(index + 1)")
                                .frame(width: 30, alignment: .trailing)
                                .font(.system(size: 16, weight: .bold))

                            Text(entry.nickname)
                                .font(.system(size: 16))
                                .lineLimit(1)
                                .truncationMode(.tail)

                            Spacer()

                            Text(viewModel.formatTimeHHMM(seconds: entry.totalSeconds))
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.gray)
                                .frame(width: 80, alignment: .trailing)
                            
                            
                            
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(index % 2 == 0 ? Color.red.opacity(0.08) : Color.clear)
                        .cornerRadius(1)
                        
                        Divider()
                    }
                }
                .padding(.bottom)
                
            }
        }
    }
}


#Preview {
    LeaderboardView()
}
