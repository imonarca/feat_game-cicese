//
//  HapticManager.swift
//  HapticManager
//
//  Created by Maria Fernanda Monarca Lopez  on 05/08/21.
//

import CoreHaptics

class HapticManager {
  // 1
  let hapticEngine: CHHapticEngine

  // 2
  init?() {
    // 3
    let hapticCapability = CHHapticEngine.capabilitiesForHardware()
    guard hapticCapability.supportsHaptics else {
      return nil
    }

    // 4
    do {
      hapticEngine = try CHHapticEngine()
    } catch let error {
      print("Haptic engine Creation Error: \(error)")
      return nil
    }
  }
}

extension HapticManager {
    
    private func splashPattern() throws -> CHHapticPattern {
        let splash = CHHapticEvent(
          eventType: .hapticContinuous,
          parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1),
            CHHapticEventParameter(parameterID: .attackTime, value: 0.8),
            CHHapticEventParameter(parameterID: .releaseTime, value: 0.5),
            CHHapticEventParameter(parameterID: .decayTime, value: 0.5)
          ],
          relativeTime: 0.1,
          duration: 2)
      
      let events = [splash]

      
      return try CHHapticPattern(events: events, parameters: [])
    }
    
    
    private func splashPattern2() throws -> CHHapticPattern {
        let splash = CHHapticEvent(
          eventType: .hapticContinuous,
          parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1),
            CHHapticEventParameter(parameterID: .attackTime, value: -0.8),
            CHHapticEventParameter(parameterID: .releaseTime, value: 0.5),
            CHHapticEventParameter(parameterID: .decayTime, value: -0.5)
          ],
          relativeTime: 0.1,
          duration: 2)
      
      let events = [splash]

      
      return try CHHapticPattern(events: events, parameters: [])
    }
    
    func playSplash2() {
        
        do {
          // 1
          let pattern = try splashPattern2()
          // 2
          try hapticEngine.start()
          // 3
          let player = try hapticEngine.makePlayer(with: pattern)
          // 4
          try player.start(atTime: CHHapticTimeImmediate)
          // 5
          hapticEngine.notifyWhenPlayersFinished { _ in
            return .stopEngine
          }
        } catch {
          print("Failed to play slice: \(error)")
        }
    }
    
    
    
    
    

    func playSplash() {
        
        do {
          // 1
          let pattern = try splashPattern()
          // 2
          try hapticEngine.start()
          // 3
          let player = try hapticEngine.makePlayer(with: pattern)
          // 4
          try player.start(atTime: CHHapticTimeImmediate)
          // 5
          hapticEngine.notifyWhenPlayersFinished { _ in
            return .stopEngine
          }
        } catch {
          print("Failed to play slice: \(error)")
        }
    }
    
    
    
    
    
    
      private func slicePattern() throws -> CHHapticPattern {
        let slice = CHHapticEvent(
            eventType: .hapticContinuous,
          parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.70),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
          ],
            relativeTime: 0,
            duration: 1)


        return try CHHapticPattern(events: [slice], parameters: [])
      }
    
    func playSlice() {
      do {
        // 1
        let pattern = try slicePattern()
        // 2
        try hapticEngine.start()
        // 3
        let player = try hapticEngine.makePlayer(with: pattern)
        // 4
        try player.start(atTime: CHHapticTimeImmediate)
        // 5
        hapticEngine.notifyWhenPlayersFinished { _ in
          return .stopEngine
        }
      } catch {
        print("Failed to play slice: \(error)")
      }
    }
    
    private func tap() throws -> CHHapticPattern {
      let slice = CHHapticEvent(
          eventType: .hapticContinuous,
        parameters: [
          CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.50),
          CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        ],
          relativeTime: 0,
          duration: 1)


      return try CHHapticPattern(events: [slice], parameters: [])
    }
    func playTap() {
      do {
        // 1
        let pattern = try tap()
        // 2
        try hapticEngine.start()
        // 3
        let player = try hapticEngine.makePlayer(with: pattern)
        // 4
        try player.start(atTime: CHHapticTimeImmediate)
        // 5
        hapticEngine.notifyWhenPlayersFinished { _ in
          return .stopEngine
        }
      } catch {
        print("Failed to play slice: \(error)")
      }
    }
    
    }
    





