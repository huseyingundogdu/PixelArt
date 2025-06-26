//
//  TimerView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 16/05/2025.
//

import SwiftUI
import FirebaseCore

struct TimerView: View {
    
    let scoringAt: Timestamp
    
    @State private var remainingTime: TimeInterval = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(formattedTime(from: remainingTime))
            .onAppear {
                updateRemainingTime()
            }
            .onReceive(timer) { _ in
                updateRemainingTime()
            }
            .frame(maxWidth: .infinity)
            .pixelBackground()
            .font(.custom("Micro5-Regular", size: 40))
            .foregroundColor(.black)
    }
    
    private func updateRemainingTime() {
        let now = Date()
        let scoringAtDate = scoringAt.dateValue()
        remainingTime = scoringAtDate.timeIntervalSince(now)
    }
    
    private func formattedTime(from interval: TimeInterval) -> String {
        if interval <= 0 {
            return "Süre doldu"
        }
        
        let days = Int(interval) / 86400
        let hours = (Int(interval) % 86400) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        
        return String(format: "%02dd %02dh %02dm %02ds", days, hours, minutes, seconds)
    }
}

//#Preview {
//    TimerView(scoringAt: Timestamp.init())
//}
