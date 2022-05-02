//
//  web-1.swift
//  web-1
//
//  Created by Maria Fernanda Monarca Lopez  on 19/08/21.
//

import Foundation
import SpriteKit

class web3: BuildWeb{
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        level=3
        ritmo=0.320
        speed1=4000
        actividad="Build"
        if(haptic){
            ritmo=0.320
            speed1=4000
        }
        selectSpider2()
        startFile()
        startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
    
}

