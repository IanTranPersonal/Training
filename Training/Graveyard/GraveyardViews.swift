////
////  GraveyardViews.swift
////  Training
////
////  Created by Vinh Tran on 10/3/2025.
////
//
//
//import SwiftData
//import SwiftUI
//
//struct HomePageNew: View {
//    
//    @Query var workouts: [BaseData]
//    @Environment(\.modelContext) private var modelContext
//    @State private var showingAddSheet = false
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                if workouts.isEmpty || workouts[0].workoutDays.isEmpty {
//                    Text("No workout days yet")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    var workoutsArray = Array(workouts.flatMap{$0.workoutDays}.enumerated())
//                    ForEach(workoutsArray, id: \.offset) { workoutDay in
//                        NavigationLink(destination: WorkoutDayDataView(workoutDay: workoutDay.element)) {
//                            WorkoutDayDataCard(item: workoutDay.element)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Workouts")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        addWorkoutDay(label: "Something", icon: "dumbbell")
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//        }
//    }
//    
//    private func addWorkoutDay(label: String, icon: String, workouts: [WorkoutData] = []) {
//        // Create a new WorkoutDay
//        let newWorkoutDay = WorkoutDayData(label: label, icon: icon, workout: workouts)
//        
//        // If there's no BaseData yet, create one
//            let baseData = BaseData(workoutDays: [newWorkoutDay])
//            modelContext.insert(baseData)
//            
//        
//        
//        // Save changes
//        try? modelContext.save()
//    }
//}
//
//#Preview {
//    HomePageNew()
//        .modelContainer(for: BaseData.self, inMemory: true)
//}
//
//
//// TEST
//
//struct WorkoutDayDataCard: View {
//    
//    var item: WorkoutDayData
//    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color.white)
//                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
//                .frame(maxWidth: .infinity, maxHeight: 110)
//                .padding([.leading, .trailing])
//            
//            HStack(spacing: 20) {
//                // Icon in circle container
//                ZStack {
//                    Circle()
//                        .fill(Color.black.opacity(0.05))
//                        .frame(width: 70, height: 70)
//                    
//                    Image(systemName: item.icon)
//                        .font(.system(size: 32))
//                        .foregroundColor(.black)
//                }
//                
//                VStack(alignment: .leading, spacing: 8) {
//                    // Workout day name
//                    Text(item.label)
//                        .font(.headline)
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)
//                    
//                    // Workout count
//                    Text("\(item.workout.count) workout\(item.workout.count != 1 ? "s" : "")")
//                        .font(.subheadline)
//                        .foregroundColor(.black.opacity(0.6))
//                    
//                    // Display workout names
//                    if !item.workout.isEmpty {
//                        Text(item.workout.map { $0.name }.joined(separator: ", "))
//                            .font(.caption)
//                            .foregroundColor(.black.opacity(0.4))
//                            .lineLimit(1)
//                            .truncationMode(.tail)
//                    }
//                }
//                .padding(.leading, 5)
//                
//                Spacer()
//                
//                // Arrow indicator
//                Image(systemName: "chevron.right")
//                    .font(.system(size: 14, weight: .semibold))
//                    .foregroundColor(.black.opacity(0.3))
//                    .padding(.trailing, 20)
//            }
//            .padding(.horizontal, 25)
//            .frame(maxWidth: .infinity, alignment: .leading)
//        }
//    }
//}
