//
//  selectLevel.swift
//  selectLevel
//
//  Created by Maria Fernanda Monarca Lopez  on 15/09/21.
//

import Foundation
import SpriteKit

class selectLevel:GameDynamic{
    

    
    override func didMove(to view: SKView) {
        
    }
    
  
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            let nodess = nodes(at: location)
        
        
        for node in nodess{
           
     
            
            if node.name=="build1"{
                let feed = web1(fileNamed:"BuildWeb")
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.actividad="build"
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
                
            }
            else if node.name=="build2"{
                let feed = web2(fileNamed:"BuildWeb")
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.actividad="build"
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
                
            }
            else if node.name=="build3"{
                let feed = web3(fileNamed:"BuildWeb")
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.actividad="build"
                
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
            }
            
            else if node.name=="feed1"{
                let feed = fead1(fileNamed:"feed")
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.actividad="feed"
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
                
            }
            else if node.name=="feed2"{
                let feed = fead2(fileNamed:"feed")
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.actividad="feed"
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
                
            }
            else if node.name=="feed3"{
                let feed = fead3(fileNamed:"feed")
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
                
            }
            else if node.name=="free"{
                let feed = selectSpider(fileNamed:"selectSpider")
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.actividad="free"
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
            }
            
            else if node.name=="re"{
                let feed = recompensa(fileNamed:"recompensa")
                feed?.idParticipant="00"
                feed?.haptic=true
                feed?.contR=1
                feed?.actividad="Build"
                feed?.level=1
              
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
            }
            else if node.name=="intro"{
                let feed = intro(fileNamed:"intro")
                feed?.idParticipant="00"
                feed?.haptic=true
                feed?.level=1
              
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
            }
        }
        }
    }
    
}
