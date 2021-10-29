//
//  tutorial.swift
//  tutorial
//
//  Created by Maria Fernanda Monarca Lopez  on 21/09/21.
//

import Foundation
import SpriteKit

class tutorial:BuildWeb{
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        print("tutorial")
        
        level=0
        ritmo=1.5
        tutorial=true
        startFile()
        startTutorial()
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
}
