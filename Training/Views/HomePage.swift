//
//  HomePage.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject var base: Base
    @State private var isSearchShown: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                if base.workoutDay.count > 0 {
                    let something = Array(base.filteredWorkouts.enumerated())
                    ScrollView {
                        ForEach(something, id: \.offset) { workout in
                            NavigationLink(destination: WorkoutDayView(workoutDay: workout.element )) {
                                WorkoutDayCard(item: workout.element)
                                    .onLongPressGesture {
                                        base.deleteWorkoutDay(workout.element, index: workout.offset)
                                    }
                            }
                            .frame(height: 110)
                        }
                    }
                    .searchable(text: $base.searchString, isPresented: $isSearchShown, prompt: "Search")
                }
                else {
                    EmptyWorkoutView()
                }
            }
            .refreshable {
                Task {
                    await base.retrieveData()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("Workout")
                        .font(.headline)
                }
                ToolbarItem {
                    Button {
                        isSearchShown.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem {
                    
                    Button {
                        print("Button")
                        Task {
                            await base.addData()
                        }
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear{
                Task {
                    await base.retrieveData()
                    isSearchShown = false
                }
            }
        }
        
        
    }
}

#Preview {
    HomePage().environmentObject(Base.init(workoutDay: []))
        .preferredColorScheme(.dark)
}
