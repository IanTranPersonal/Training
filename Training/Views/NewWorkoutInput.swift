//
//  NewWorkoutInput.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI

public struct NewWorkoutInputView: View {
    @State private var name: String = "Barbell Squat"
    @State private var reps: Int = 6
    @State private var sets: Int = 3
    @State private var duration: Double?
    @State private var isCardio: Bool = false
    private var formatter = NumberFormatter()
    @State private var typeName: Workout.WorkoutTypes = .legs
    
    public init(onSave: @escaping (Workout) -> Void) {
        self.onSave = onSave
    }
    
    // Callback function to pass the new workout back
    var onSave: (Workout) -> Void
    
    // Environment value to dismiss the sheet
    @Environment(\.dismiss) private var dismiss
    
    public var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: 350)
                .padding([.leading, .trailing])
            
            VStack(spacing: 24) {
                HStack {
                    Text("Add Exercise")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.7))
                    
                    Spacer()
                    
                    Button {
                        let newWorkout =
                        generateNewWorkout()
                        onSave(newWorkout)
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Circle().fill(Color.black))
                    }
                }
                .padding(.vertical, 8)
                
                // Exercise type toggle
                HStack(spacing: 12) {
                    Text("Type:")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .frame(width: 70, alignment: .leading)
                    
                    Picker("", selection: $typeName) {
                        ForEach(Workout.WorkoutTypes.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black.opacity(0.2), lineWidth: 1)
                    )
                    .onChange(of: typeName) {
                        switch typeName {
                        case .legs: name = Workout.legWorkouts.first ?? ""
                        case .back: name = Workout.backWorkouts.first ?? ""
                        case .biceps: name = Workout.bicepWorkouts.first ?? ""
                        case .chest: name = Workout.chestWorkouts.first ?? ""
                        case .triceps: name = Workout.tricepWorkouts.first ?? ""
                        case .cardio: name = Workout.cardioWorkouts.first ?? ""
                            isCardio = true
                        }
                    }
                }
                
                // Workout selection
                HStack(spacing: 12) {
                    Text("Workout:")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .frame(width: 70, alignment: .leading)
                    
                    Picker("", selection: $name) {
                        switch typeName {
                        case .legs:
                            ForEach(Workout.legWorkouts, id: \.self) {
                                Text($0)
                            }
                        case .back:
                            ForEach(Workout.backWorkouts, id: \.self) {
                                Text($0)
                            }
                        case .biceps:
                            ForEach(Workout.bicepWorkouts, id: \.self) {
                                Text($0)
                            }
                        case .chest:
                            ForEach(Workout.chestWorkouts, id: \.self) {
                                Text($0)
                            }
                        case .triceps:
                            ForEach(Workout.tricepWorkouts, id: \.self) {
                                Text($0)
                            }
                        case .cardio:
                            ForEach(Workout.cardioWorkouts, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black.opacity(0.2), lineWidth: 1)
                    )
                    
                }
                
                if isCardio {
                    // Duration field for cardio
                    HStack(spacing: 12) {
                        Text("Duration:")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(width: 70, alignment: .leading)
                        
                        Stepper("\(Int(duration ?? 10)) min", value: Binding(
                            get: { Int(duration ?? 10) },
                            set: { duration = Double($0) }
                        ), in: 1...120)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                        .foregroundStyle(.blue)
                    }
                } else {
                    // Reps field
                    HStack(spacing: 12) {
                        Text("Reps:")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(width: 70, alignment: .leading)
                        
                        TextField("0", value: $reps, formatter: formatter)
                            .keyboardType(.numberPad)
                            .frame(height: 36)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black.opacity(0.2), lineWidth: 1)
                            )
                            .foregroundStyle(.black)

                        HStack(spacing: 0) {
                            Button {
                                if reps > 0 { reps -= 1 }
                            } label: {
                                Image(systemName: "minus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                    .frame(width: 36, height: 36)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.black.opacity(0.05))
                                    )
                            }
                            
                            Button {
                                reps += 1
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 36, height: 36)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.black)
                                    )
                            }
                        }
                    }
                    
                    // Sets field
                    HStack(spacing: 12) {
                        Text("Sets:")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(width: 70, alignment: .leading)
                        
                        TextField("0", value: $sets, formatter: formatter)
                            .keyboardType(.numberPad)
                            .frame(height: 36)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black.opacity(0.2), lineWidth: 1)
                            )
                            .foregroundStyle(.black)
                        
                        HStack(spacing: 0) {
                            Button {
                                if sets > 0 { sets -= 1 }
                            } label: {
                                Image(systemName: "minus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                    .frame(width: 36, height: 36)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.black.opacity(0.05))
                                    )
                            }
                            
                            Button {
                                sets += 1
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 36, height: 36)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.black)
                                    )
                            }
                        }
                    }
                }
                
                // Cancel button
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.black.opacity(0.7))
                }
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
        }
        .presentationDetents([.height(400)])
    }
    private func generateNewWorkout() -> Workout {
        let workouts: [WorkoutSet] = (0...sets - 1).map { workout in
            WorkoutSet(
                reps: isCardio ? 0: reps,
                setNumber: isCardio ? 0 : workout,
                weight: 50,
                duration: isCardio ? duration ?? 10 : nil
            )
        }
        return Workout(name: name, workoutSet: workouts, completed: false)
    }
}

#Preview {
    NewWorkoutInputView { workout in
                // Mock implementation of the `onSave` closure
                print("Workout saved: \(workout.name)")
            }
    .preferredColorScheme(.dark)
}
