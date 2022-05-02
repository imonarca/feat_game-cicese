//
//  web-1.swift
//  web-1
//
//  Created by Maria Fernanda Monarca Lopez  on 19/08/21.
//

import Foundation
import SpriteKit

class free_1: free{
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        level=1
        
        selectSpider2()
        startVideoFree()
        startFile()
  
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
    
}

