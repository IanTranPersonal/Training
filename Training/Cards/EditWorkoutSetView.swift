//
//  EditWorkoutSetView.swift
//  Training
//
//  Created by Vinh Tran on 1/4/2025.
//

import SwiftUI

struct EditWorkoutSetView: View {
    @Binding var set: WorkoutSet
    @State private var tempWorkout: WorkoutSet
    @Environment(\.dismiss) private var dismiss
    
    init(set: Binding<WorkoutSet>) {
        self._set = set
        self.tempWorkout = set.wrappedValue
    }
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Set \(set.setNumber + 1)")
                .font(.headline)
                .padding(.top)
            
            HStack {
                Text("Reps: \(tempWorkout.reps)")
                    .frame(width: 80, alignment: .leading)
                Button("+") { tempWorkout.reps += 1 }
                    .buttonStyle(.bordered)
                
                Button("-") { tempWorkout.reps -= 1 }
                    .buttonStyle(.bordered)
            }
            .padding(.horizontal)
            
            VStack(spacing: 10) {
                Text("Weight \(tempWorkout.weight)(kg):")
                    .frame(width: 80, alignment: .leading)
                HStack(spacing: 10) {
                    Button("-10 kg") { tempWorkout.weight -= 10 }
                        .buttonStyle(.bordered)
                    Button("-5 kg") { tempWorkout.weight -= 5 }
                        .buttonStyle(.bordered)
                    
                    Button("+5 kg") { tempWorkout.weight += 5 }
                        .buttonStyle(.bordered)
                    Button("+10 kg") { tempWorkout.weight += 10 }
                        .buttonStyle(.bordered)
                }
            }
            .padding(.horizontal)
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Save") {
                    set = tempWorkout
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    struct EditWorkoutSetPreview: View {
        @State var set: WorkoutSet = .dummySet[0]
        var body: some View {
            EditWorkoutSetView(set: $set)
        }
    }
    return EditWorkoutSetPreview()
        .padding()
}

