//
//  WorkoutDayLabelChange.swift
//  Training
//
//  Created by Vinh Tran on 1/4/2025.
//

import SwiftUI

struct WorkoutDayLabelChange: View {
    @Binding var label: String
    @State private var tempLabel: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("Edit Workout Name")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Text field
                TextField("", text: $tempLabel)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2))
                    )
                    .padding(.horizontal)
                
                // Save button
                Button(action: {
                    if !tempLabel.isEmpty {
                        label = tempLabel
                    }
                    dismiss()
                }) {
                    Text("Save")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
        .onAppear {
            tempLabel = label
        }
        .presentationDetents([.height(250)])
        .preferredColorScheme(.dark)
    }
}
#Preview{
    WorkoutDayLabelChange(label: .constant("Apple"))
}

