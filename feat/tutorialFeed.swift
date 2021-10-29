//
//  tutorialFeed.swift
//  tutorialFeed
//
//  Created by Maria Fernanda Monarca Lopez  on 29/09/21.
//

import Foundation
import SpriteKit

class tutorialFeed:feed{
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        level=0
        ritmo=4
        startFile()
        startTutorial()
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
