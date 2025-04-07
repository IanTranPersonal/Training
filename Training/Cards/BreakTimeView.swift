//
//  BreakTimeView.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI
import UserNotifications
import Combine

struct BreakTimerView: View {
    @State private var timeRemaining: TimeInterval
    @State private var isRunning = false
    @State private var timer: Timer? = nil
    @Binding var initialTime: TimeInterval
    
    
    // Initialize with seconds
    init(seconds: Binding<TimeInterval>) {
        self._initialTime = seconds
        self.timeRemaining = seconds.wrappedValue
    }
    
    
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                // Timer display
                Text(timeString(from: timeRemaining))
                    .font(.system(size: 64, weight: .semibold))
                    .foregroundStyle(.white)
                    .monospacedDigit()
                
                // Controls
                
                // Play/Pause button
                Button(action: toggleTimer) {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 64, height: 64)
                        .background(
                            Circle()
                                .fill(Color.white)
                        )
                }
                
                // Reset button
                Button(action: resetTimer) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 24, weight: .medium))
                        .frame(width: 56, height: 56)
                        .background(
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                        )
                }
            }
            Text("Break Time")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
                .offset(y: -10)
        }
        .padding()
        .onDisappear {
            stopTimer()
        }
        .onReceive(Just(initialTime)) { newValue in
            if !isRunning {
                timeRemaining = newValue
            }
        }
    }
    
    // Format time remaining as MM:SS
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Toggle play/pause
    private func toggleTimer() {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
        
        isRunning.toggle()
    }
    
    // Start timer
    private func startTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                isRunning = false
                sendNotification()
            }
        }
    }
    
    // Stop timer
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Reset timer
    private func resetTimer() {
        stopTimer()
        isRunning = false
        timeRemaining = initialTime
    }
    
    private func sendNotification() {
            let content = UNMutableNotificationContent()
            content.title = "Break Time Finished"
            content.body = "Your break time is up!"
            content.sound = UNNotificationSound.default
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                }
            }
        }
}

#Preview {
    struct BreakTimePreview: View {
        @State var time: TimeInterval = 45
        var body: some View {
            BreakTimerView(seconds: $time).preferredColorScheme(.dark)
        }
    }
    return BreakTimePreview()
}
