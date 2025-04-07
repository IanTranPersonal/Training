//
//  EmptyWorkoutView.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI

struct EmptyWorkoutView: View {
    @EnvironmentObject var base: Base
    var body: some View {
        
        VStack(spacing: 40) {
            Spacer()
            Text("Start adding a workout")
                .font(.headline)
                .foregroundStyle(.gray.opacity(0.8))
            Circle()
                .frame(width: 80, height: 80)
                .foregroundStyle(.gray.opacity(0.5))
                .overlay {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(.all, 20)
                        .foregroundStyle(.gray)
                }
                .onTapGesture {
                    Task {
                        await base.addData()
                    }
                }
            Spacer()
        }
    }
}

#Preview {
    EmptyWorkoutView().environmentObject(Base.init(workoutDay: []))
}
