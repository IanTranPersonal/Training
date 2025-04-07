//
//  Workout.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI
import FirebaseFirestore

public struct Workout: Hashable, Codable {
    public internal(set) var name: String
    public internal(set) var workoutSet: [WorkoutSet]
    public internal(set) var completed: Bool
    
    public init(name: String, workoutSet: [WorkoutSet], completed: Bool) {
        self.name = name
        self.workoutSet = workoutSet
        self.completed = completed
    }
    
    static var dummyWorkout = Workout(name: "Dummy", workoutSet: WorkoutSet.dummySet, completed: false)
}

public struct WorkoutSet: Hashable, Codable {
    public internal(set) var reps: Int
    public internal(set)var setNumber: Int
    public internal(set) var weight: Int
    public internal(set) var duration: Double?
    
    public init(reps: Int, setNumber: Int, weight: Int, duration: Double? = nil) {
        self.reps = reps
        self.setNumber = setNumber
        self.weight = weight
        self.duration = duration
    }
    
    static var dummySet: [WorkoutSet] = [.init(reps: 3, setNumber: 0, weight: 20), .init(reps: 3, setNumber: 1, weight: 30), .init(reps: 3, setNumber: 2, weight: 40)]
}

extension Workout {
    enum WorkoutTypes: String, CaseIterable {
        case legs
        case back
        case biceps
        case chest
        case triceps
        case cardio
    }
    
    static let legWorkouts = ["Barbell Squat", "Front Squat", "Romanian Deadlift", "Hamstring Curls", "Bulgarian Split Squat", "Calf raises", "Lunges"]
    static let backWorkouts = ["Deadlift", "Pull Ups", "Rows", "Seated Rows", "Lat pull downs"]
    static let bicepWorkouts = ["Preacher Curls", "Hammer Curls", "Cable Curls", "Concentration Curls"]
    static let tricepWorkouts = ["Dips", "Cable pull downs", "Skull Crushers", "Overhead Tricep Extensions"]
    static let chestWorkouts = ["Bench Press", "Incline Bench Press", "Decline Bench Press", "Cable flys", "Dumbbell flys"]
    static let cardioWorkouts = ["Treadmill", "Bike", "Elliptical", "Rowing", "Stair Climber", "Jump Rope"]
    
    func getSystemImage() -> String {
        let name = self.name.lowercased()
        
        if name.contains("treadmill") || name.contains("run") || name.contains("elliptical") {
            return "figure.walk"
        } else if name.contains("bike") || name.contains("cycling") {
            return "clock"
        } else if name.contains("chin") || name.contains("pull") {
            return "dumbbell.fill"
        } else if name.contains("plank") || name.contains("rowing") || name.contains("jump rope") {
            return "arrow.clockwise"
        } else if name.contains("curl") || name.contains("bicep") {
            return "square"
        } else if name.contains("squat") || name.contains("leg") || name.contains("deadlift") || name.contains("lunge") {
            return "figure.strengthtraining.traditional"
        } else {
            return "dumbbell.fill"  // Default
        }
    }
}
