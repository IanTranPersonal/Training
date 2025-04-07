//
//  WorkoutInputView.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI

struct WorkoutExerciseRow: View {
    @Binding var workout: Workout
    @State private var isPresentingDown = false
    @State private var isCompleted = false
    var completeAction: () -> Void
    var deleteAction: () -> Void 
    
    var body: some View {
        VStack {
            HStack {
                // Status circle
                Circle()
                    .strokeBorder(Color.gray.opacity(0.3), lineWidth: 2)
                    .background(Circle().fill(isCompleted ? Color.white : Color.clear))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Group {
                            if isCompleted {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)
                            } else {
                                Image(systemName: workout.getSystemImage())
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                        }
                    )
                    .onTapGesture {
                        completeAction()
                        withAnimation {
                            isCompleted.toggle()
                        }
                    }
                
                // Exercise details
                VStack(alignment: .leading, spacing: 4) {
                    Text(workout.name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    if workout.workoutSet.contains(where: {$0.duration != nil}) {
                        Text("\(Int(workout.workoutSet.first(where: {$0.duration != nil})?.duration ?? 0)) min")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                        
                    }
                    
                    else if workout.workoutSet.count > 0 {
                        Text("\(workout.workoutSet.first?.reps ?? 0) reps x \(workout.workoutSet.count) sets")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                    }
                    
                    else {
                        Text("Check off when done")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                }
                
                
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut) {
                        isPresentingDown.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.down")
                }
                .foregroundStyle(.gray)
                .padding(.trailing, 10)
                
                // Options
                Menu(content: {
                    Button {
                        deleteAction()
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete")
                        }
                    }
                }, label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 40)
                })
            }
            if isPresentingDown {
                ExtendedWorkoutExerciseRow(isPresented: $isPresentingDown, workout: $workout)
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal)
    }
}

#Preview {
    struct WorkoutExerciseRowPreview: View {
        @State var workout: Workout = .dummyWorkout
        var body: some View {
            WorkoutExerciseRow(workout: $workout, completeAction: { print("A")}, deleteAction: {  print("")})
        }
    }
    return WorkoutExerciseRowPreview()
        .preferredColorScheme(.dark)
}

