//
//  web-1.swift
//  web-1
//
//  Created by Maria Fernanda Monarca Lopez  on 19/08/21.
//

import Foundation
import SpriteKit

class fead3: feed{
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        level=3
        ritmo=4
        actividad="feed"
        selectSpider2()
        selecWalking()
        selecCons()
        selecCuerpo()
        selecComiendo()
        startFile()
        startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
}


