//
//  EditTimerView.swift
//  Training
//
//  Created by Vinh Tran on 19/3/2025.
//
import SwiftUI

struct EditingTimerView: View {
    @Binding var timerValue: TimeInterval
    @Binding var isPresented: Bool
    var body: some View {
        VStack(spacing: 24) {
            Text(timeString(from: timerValue))
                .font(.system(size: 32, weight: .medium))
            HStack(spacing: 32) {
                Button {
                    timerValue -= 15
                } label: {
                    Text("- 15s")
                }
                .buttonBorderShape(.capsule)
                
                Button {
                    timerValue += 15
                } label: {
                    Text("+ 15s")
                }
                .buttonBorderShape(.capsule)
                Button {
                    timerValue -= 30
                } label: {
                    Text("- 30s")
                }
                .buttonBorderShape(.capsule)
                
                Button {
                    timerValue += 30
                } label: {
                    Text("+ 30s")
                }
                .buttonBorderShape(.capsule)
            }
            .frame(maxWidth: .infinity)
            .padding()
            Button("Done") {
                isPresented = false
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    EditingTimerView(timerValue: .constant(60), isPresented: .constant(true))
}

