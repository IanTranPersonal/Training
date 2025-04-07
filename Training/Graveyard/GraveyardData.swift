////
////  GraveyardData.swift
////  Training
////
////  Created by Vinh Tran on 10/3/2025.
////
//
//import SwiftData
////import SwiftUI
//@Model
//public class BaseData {
//    @Relationship var workoutDays: [WorkoutDayData] = []
//    
//    public init(workoutDays: [WorkoutDayData]) {
//        self.workoutDays = workoutDays
//    }
//}
//
//
//@Model
//public class WorkoutData {
//    var name: String
//    var reps: Int
//    var sets: Int
//    var duration: Double?
//    
//    public init(name: String, reps: Int, sets: Int, duration: Double? = nil) {
//        self.name = name
//        self.reps = reps
//        self.sets = sets
//        self.duration = duration
//    }
//    
//    static var dummyWorkout = WorkoutData(name: "Dummy", reps: 6, sets: 3)
//}
//
//@Model
//public class WorkoutDayData {
//    
//    var label: String
//    var icon: String
//    var time: Date?
//    @Relationship var workout: [WorkoutData]
//    
//    public init(label: String, icon: String, workout: [WorkoutData]) {
//        self.label = label
//        self.icon = icon
//        self.workout = workout
//    }
//    
//    static var dummyWorkoutDay = WorkoutDayData(label: "Dummy", icon: "scalemass", workout: [.dummyWorkout])
//}
