//
//  selectSpider.swift
//  selectSpider
//
//  Created by Maria Fernanda Monarca Lopez  on 13/10/21.
//

import Foundation
import SpriteKit

class selectSpider:GameDynamic{
    var spider1: SKSpriteNode?
    var spider2: SKSpriteNode?
    var spider3: SKSpriteNode?
    var spider4: SKSpriteNode?
    var spider1Frames: [SKTexture] = []
    var spiderFrames: [SKTexture] = []
    var spider2Frames: [SKTexture] = []
    var spider3Frames: [SKTexture] = []
    var spider4Frames: [SKTexture] = []
    var spider:Int=1
    var endSpeaking:Bool=false
    override func didMove(to view: SKView) {
        print("seleccionar spider")
        spider1 = self.childNode(withName: "spider1") as? SKSpriteNode
        spider2 = self.childNode(withName: "spider2") as? SKSpriteNode
        spider3 = self.childNode(withName: "spider3") as? SKSpriteNode
        spider4 = self.childNode(withName: "spider4") as? SKSpriteNode
        
        spider2?.isHidden=true
        spider3?.isHidden=true
        spider4?.isHidden=true
        
        spiderFrames=buildAnimation(named: "spider1-h", TextureName: "spider1-h-")
        let hablar=animatedSprite(for: spiderFrames, key: "hablar", time: 0.6)
        spider1?.run(SKAction.repeatForever(hablar))
        let audio2 = SKAction.playSoundFileNamed("seleccionaarana.m4a", waitForCompletion: true)
        let audio1 = SKAction.playSoundFileNamed("free.m4a", waitForCompletion: true)
        
        
        
        spider1Frames=buildAnimation(named: "spider1", TextureName: "spider1")
        spider2Frames=buildAnimation(named: "spider2", TextureName: "spider2-")
        spider3Frames=buildAnimation(named: "spider3", TextureName: "spider3-")
        spider4Frames=buildAnimation(named: "spider4", TextureName: "spider4-")
        let showSpiders = SKAction.run {
            self.spider2?.isHidden=false
            self.spider3?.isHidden=false
            self.spider4?.isHidden=false
        }
        self.run(SKAction.sequence([audio1,SKAction.group([audio2,showSpiders]),SKAction.wait(forDuration: 0.2)]),completion:{self.endSpeaking=true
            self.openSpider()
        })
    }
    
    func openSpider(){
        
      
        spider1?.removeAllActions()
       
       
        let ani2=animatedSprite(for: spider2Frames, key: "spider1", time: 0.8)
        let ani3=animatedSprite(for: spider3Frames, key: "spider2", time: 0.8)
        let ani4=animatedSprite(for: spider4Frames, key: "spider3", time: 0.8)
        
      
        spider2?.run(SKAction.repeatForever(ani2))
        spider3?.run(SKAction.repeatForever(ani3))
        spider4?.run(SKAction.repeatForever(ani4))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            
            let nodess = nodes(at: location)
        
        
        for node in nodess{
            
            if node.name=="spider1" && endSpeaking{
                let feed = free_1(fileNamed:"free")
                feed?.actividad="free"
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.startFile()
                feed?.spiderS=1
                print("spider1")
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
            }
        
            else if node.name=="spider2" && endSpeaking{
                print("spider2")
                let feed = free_1(fileNamed:"free")
                feed?.actividad="free"
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.spiderS=2
                feed?.selectSpider2()
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
            }
            else if node.name=="spider3" && endSpeaking{
                print("spider3")
                let feed = free_1(fileNamed:"free")
                feed?.actividad="free"
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.spiderS=3
                
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
            }
            else if node.name=="spider4" && endSpeaking{
                print("spider4")
                let feed = free_1(fileNamed:"free")
                feed?.actividad="free"
                feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                feed?.spiderS=4
                feed?.selectSpider2()
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
            }
        }
        }
    }
}
