//
//  web-1.swift
//  web-1
//
//  Created by Maria Fernanda Monarca Lopez  on 19/08/21.
//

import Foundation
import SpriteKit

class web2: BuildWeb{
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        level=2
        ritmo=1.2
        if(haptic){
            ritmo=2.5
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

