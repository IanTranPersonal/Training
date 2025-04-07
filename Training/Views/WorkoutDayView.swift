//
//  WorkoutDayView.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI

struct WorkoutDayView: View {
    @EnvironmentObject var base: Base
    @ObservedObject var workoutDay: WorkoutDay
    @State private var showingAddExercise = false
    @State private var showWorkoutNameEditor = false
    @Environment(\.dismiss) private var dismiss
    @State private var order: Int = 0
    @State var timerTime: TimeInterval = 60
    @State private var isEditingTimer: Bool = false
    
    init(workoutDay: WorkoutDay) {
        self.workoutDay = workoutDay
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Header with timer
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Button(action: {
                            Task {
                                await base.updateWorkoutDay(workoutDay)
                                dismiss()
                            }
                        }) {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Options
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            // Finish workout
                            Task {
                                let newWorkout = workoutDay
                                newWorkout.completedOn = Date()
                                await base.addHistoryData(newWorkout)
                                dismiss()
                            }
                        }) {
                            Text("Finish")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(Color.gray.opacity(0.3))
                                )
                        }
                        .padding(.leading, 15)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text(workoutDay.label)
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Button {
                            print("editing")
                            showWorkoutNameEditor.toggle()
                            
                        } label: {
                            Image(systemName: "pencil.circle")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    // Timer display
                    BreakTimerView(seconds: $timerTime)
                        .onLongPressGesture {
                            isEditingTimer.toggle()
                        }
                }
                
                // Workout exercises list
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(Array(workoutDay.workout.enumerated()), id: \.element.hashValue) { index, workout in
                            WorkoutExerciseRow(workout: $workoutDay.workout[index],
                                               completeAction: { workoutDay.workout[index].completed = true },
                                               deleteAction: { deleteWorkout(at: index) }
                            )
                            
                        }
                        
                        // Add exercise button
                        Button(action: {
                            showingAddExercise = true
                        }) {
                            HStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .font(.system(size: 24))
                                            .foregroundColor(.white)
                                    )
                                
                                Text("Add exercises")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                HStack(spacing: 5) {
                                    ForEach(0..<3) { _ in
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 5, height: 5)
                                    }
                                }
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 15)
                            .padding(.horizontal)
                        }
                    }
                }
                
                // Bottom "up next" section
                HStack {
                    // Only show if there's at least one workout
                    if !workoutDay.workout.isEmpty {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: workoutDay.workout.first?.getSystemImage() ?? "dumbbell.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            )
                        VStack(alignment: .leading) {
                            Text(workoutDay.workout[order].name)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Up next")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Next action
                            guard order < workoutDay.workout.count - 1 else { return }
                            workoutDay.workout[order].completed = true
                            order += 1
                            print("Next")
                        }) {
                            HStack {
                                Text("Next")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(
                                Capsule()
                                    .fill(Color.gray.opacity(0.3))
                            )
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .navigationBarBackButtonHidden(true)
            }
        }
        .sheet(isPresented: $showingAddExercise) {
            // Integrate the NewWorkoutInputView as a sheet
            NewWorkoutInputView(onSave: { newWorkout in
                workoutDay.workout.append(newWorkout)
                showingAddExercise = false
            })
            .preferredColorScheme(.dark)
        }
        .sheet(isPresented: $showWorkoutNameEditor) {
            WorkoutDayLabelChange(label: $workoutDay.label)
        }
        .sheet(isPresented: $isEditingTimer) {
            EditingTimerView(timerValue: $timerTime, isPresented: $isEditingTimer)
                .presentationDetents([.medium])
        }
    }
    
    private func deleteWorkout(at index: Int) {
        workoutDay.workout.remove(at: index)
        print("Removed workout at index \(index)")
    }
}


#Preview {
    WorkoutDayView(
        workoutDay: .init(
            label: "Cardio",
            icon: "figure.walk",
            workout: [
                .init(name: "Barbell Squat", workoutSet: WorkoutSet.dummySet, completed: false)
            ]
        ))
    .environmentObject(Base(workoutDay: [.dummyWorkoutDay]))
}

