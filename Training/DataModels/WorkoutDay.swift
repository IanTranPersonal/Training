//
//  WorkoutDay.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI
import FirebaseFirestore

public class WorkoutDay: ObservableObject, Identifiable, Codable {
    
    @DocumentID public var id: String?
    @Published var label: String
    @Published var icon: String
    @Published var completedOn: Date?
    @Published var workout: [Workout]
    
    public init(label: String, icon: String, workout: [Workout]) {
        self.label = label
        self.icon = icon
        self.workout = workout
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case label
        case icon
        case time
        case workout
    }
    
    required public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        label = try container.decode(String.self, forKey: .label)
        icon = try container.decode(String.self, forKey: .icon)
        completedOn = try container.decodeIfPresent(Date.self, forKey: .time)
        workout = try container.decode([Workout].self, forKey: .workout)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(label, forKey: .label)
        try container.encode(icon, forKey: .icon)
        try container.encodeIfPresent(completedOn, forKey: .time)
        try container.encode(workout, forKey: .workout)
    }
    
    static var dummyWorkoutDay = WorkoutDay(label: "Dummy", icon: "scalemass", workout: [.dummyWorkout])
    static var newWorkoutDay = WorkoutDay(label: "New Workout", icon: "scalemass", workout: [])
}

