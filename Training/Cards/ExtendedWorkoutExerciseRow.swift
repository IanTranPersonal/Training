//
//  ExtendedWorkoutExerciseRow.swift
//  Training
//
//  Created by Vinh Tran on 1/4/2025.
//

import SwiftUI

struct ExtendedWorkoutExerciseRow: View {
    @Binding var isPresented: Bool
    @Binding var workout: Workout
    @State private var isPresentingEdit: Bool = false
    @State private var editedIndex: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Sets")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.gray)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(workout.workoutSet.indices, id: \.self) { index in
                        let set = workout.workoutSet[index]
                        
                        VStack(alignment: .center, spacing: 8) {
                            Text("Set \(set.setNumber + 1)")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                            
                            if set.duration != nil {
                                Text("\(Int(set.duration ?? 0)) min")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.gray)
                            } else {
                                Text("\(set.reps) reps")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.gray)
                                
                                Text("\(set.weight) kg")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .onTapGesture {
                            editedIndex = index
                            isPresentingEdit = true
                        }
                        .onLongPressGesture {
                            workout.workoutSet.remove(at: index)
                        }
                    }
                    
                    // Add Set Button
                    Button {
                        addNewSet()
                    } label: {
                        VStack {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 20))
                            Text("Add Set")
                                .font(.system(size: 14))
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .foregroundColor(.gray)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.1))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 10)
        .sheet(isPresented: $isPresentingEdit) {
            EditWorkoutSetView(set: $workout.workoutSet[editedIndex])
                .presentationDetents([.medium])
        }
    }
    
    private func addNewSet() {
        let newSetNumber = workout.workoutSet.count
        let lastSet = workout.workoutSet.last
        let newSet = WorkoutSet(
            reps: lastSet?.reps ?? 0,
            setNumber: newSetNumber,
            weight: lastSet?.weight ?? 0,
            duration: lastSet?.duration
        )
        workout.workoutSet.append(newSet)
    }
}

#Preview {
    struct ExtendedWorkoutPreview: View {
        @State var workout: Workout = .dummyWorkout
        var body: some View {
            ExtendedWorkoutExerciseRow(isPresented: .constant(true), workout: $workout)
        }
    }
    return ExtendedWorkoutPreview()
}


