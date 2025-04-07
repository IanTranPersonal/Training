//
//  Base.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI
import FirebaseFirestore

@MainActor
public class Base: ObservableObject {
    @Published var workoutDay: [WorkoutDay] = []
    @Published var searchString: String = ""
    
    public init(workoutDay: [WorkoutDay]) {
        self.workoutDay = workoutDay
    }
    
    var filteredWorkouts: [WorkoutDay] {
        guard !searchString.isEmpty else {
            return workoutDay
        }
        
        return workoutDay.filter {
            $0.label.lowercased().contains(searchString.lowercased())
        }
    }
    
    lazy var db = Firestore.firestore()
    
    func retrieveData() async {
        do {
            let snapshot = try await db.collection("workoutDay").getDocuments()
            let documents = try snapshot.documents.map {try $0.data(as: WorkoutDay.self)}
            workoutDay.removeAll()
            workoutDay = documents
        }
        catch {
            print("Failed to retrieve data")
            print(error.localizedDescription)
        }
    }
    
    func addData() async {
        do {
            let newWorkoutDay: WorkoutDay = .newWorkoutDay
            let encoder = try Firestore.Encoder().encode(newWorkoutDay)
            let newWorkout = try await db.collection("workoutDay").addDocument(data: encoder)
            newWorkoutDay.id = newWorkout.documentID
            workoutDay.append(newWorkoutDay)
        }
        catch {
            print("Adding Data failed")
        }
    }
    
    func addHistoryData(_ with: WorkoutDay) async {
        do {
            let encoder = try Firestore.Encoder().encode(with)
            try await db.collection("workoutHistory").addDocument(data: encoder)
        }
        catch {
            print("Adding data to history failed")
        }
    }
    
    func updateWorkoutDay(_ newWorkout: WorkoutDay) async {
        print("Updating: This workout has the id: \(newWorkout.id ?? "None")")
        if let id = newWorkout.id {
            do {
                try db.collection("workoutDay").document(id).setData(from: newWorkout)
            } catch {
                print("Error updating document: \(error)")
            }
        }
    }
    
    func deleteWorkoutDay(_ newWorkout: WorkoutDay, index: Int) {
        print("Deleting This workout has the id: \(newWorkout.id ?? "None")")
        workoutDay.remove(at: index)
        if let id = newWorkout.id {
            db.collection("workoutDay").document(id).delete() { error in
                if let error = error {
                    print("Error removing document: \(error)")
                }
            }
        }
    }
}

import UserNotifications

class PermissionsService {
    static let shared = PermissionsService()
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }
}
