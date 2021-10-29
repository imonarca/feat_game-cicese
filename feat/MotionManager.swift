//
//  MotionManager.swift
//  MotionManager
//
//  Created by Maria Fernanda Monarca Lopez  on 27/09/21.
//

import Foundation
import Combine
import CoreMotion

class MotionManager: ObservableObject {

    private var motionManager: CMMotionManager

    @Published
    var x: Double = 0.0
    @Published
    var y: Double = 0.0
    @Published
    var z: Double = 0.0
    
    @Published
    var gx: Double = 0.0
    @Published
    var gy: Double = 0.0
    @Published
    var gz: Double = 0.0
  
    @Published
    var acx: Double = 0.0
    @Published
    var acy: Double = 0.0
    @Published
    var acz: Double = 0.0


    // Manages movement of the Circles
    init() {
        self.motionManager = CMMotionManager()
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 5.0 / 60.0
            self.motionManager.showsDeviceMovementDisplay = true
            self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: OperationQueue.current!, withHandler: {(data, error) in
                if let validData = data {
                    // Roll = y axis spin
                    let roll = validData.attitude.roll
                    
                    // Pitch = x axis spin
                    let pitch = validData.attitude.pitch
                    
                    // Yaw = z axis spin
                    let yaw = validData.attitude.yaw
                
                    self.x = pitch
                    self.y = roll
                    self.z = yaw
                    
                    self.acx=validData.userAcceleration.x
                    self.acy=validData.userAcceleration.x
                    self.acz=validData.userAcceleration.x
                    self.gx = validData.rotationRate.x
                    self.gx = validData.rotationRate.y
                    self.gx = validData.rotationRate.z
                }
            })

        }

    }
}
