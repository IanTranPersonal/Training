//
//  WorkoutDayCard.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI

struct WorkoutDayCard: View {
    
    @ObservedObject var item: WorkoutDay
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: 110)
                .padding([.leading, .trailing])
            
            HStack(spacing: 20) {
                // Icon in circle container
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.05))
                        .frame(width: 70, height: 70)
                    
                    Image(systemName: item.icon)
                        .font(.system(size: 32))
                        .foregroundColor(.black)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    // Workout day name
                    Text(item.label)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    // Workout count
                    Text("\(item.workout.count) workout\(item.workout.count != 1 ? "s" : "")")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.6))
                    
                    // Display workout names
                    if !item.workout.isEmpty {
                        Text(item.workout.map { $0.name }.joined(separator: ", "))
                            .font(.caption)
                            .foregroundColor(.black.opacity(0.4))
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                .padding(.leading, 5)
                
                Spacer()
                
                // Arrow indicator
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black.opacity(0.3))
                    .padding(.trailing, 20)
            }
            .padding(.horizontal, 25)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        WorkoutDayCard(item: WorkoutDay(
            label: "Leg Day",
            icon: "figure.walk",
            workout: [
                Workout(name: "Barbell Squat", workoutSet: [.init(reps: 3, setNumber: 1, weight: 40)], completed: false),
            ]
        ))
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}

