//
//  recompensa.swift
//  recompensa
//
//  Created by Maria Fernanda Monarca Lopez  on 14/09/21.
//

import Foundation
import SpriteKit

class recompensa:SKScene {
    
    var cofre: [SKSpriteNode] = []
    var touch: CGPoint? = nil
    var idParticipant:String="p1"
    var haptic:Bool=true
    var level:Int=1
    var actividad:String="recompensa"
    var inicio:Int=0
    var contR:Int=1
    var finish:Bool=false
    private var abrirFrames: [SKTexture] = []
    private var spiderFrames: [SKTexture] = []
    var spider: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        self.spider = self.childNode(withName: "spider") as? SKSpriteNode
        abrirFrames = buildAnimation(named: "cofre", TextureName: "cofre")
        spider?.isHidden=true
        for child in self.children {
            if child.name == "re" {
            if let child = child as? SKSpriteNode {
              cofre.append(child)
            }
          }
        }
        
        let audio1 =  SKAction.playSoundFileNamed("abirCofre.m4a", waitForCompletion: true)
        self.run(audio1, completion:{
            self.finish=true
        } )
        
        animateNodes(cofre)
    }
    
    func buildAnimation(named:String,TextureName:String)-> [SKTexture]{
        let spiderAnimatedAtlas = SKTextureAtlas(named: named)
        var textures: [SKTexture] = []
        let numImages = spiderAnimatedAtlas.textureNames.count
      
        for i in 1...numImages {
          let spiderTextureName = TextureName+"\(i)"
            textures.append(spiderAnimatedAtlas.textureNamed(spiderTextureName))
        }
        
        return textures
    }
    
    
    func getFrames(){
        if(actividad=="Build"){
            if(level==1){
                contR=2
            }else if(level==2){
               contR=3
            }
        }else{
            if(level==1){
                contR=4
            }else if(level==2){
                contR=2
            }
        }
    }
    func selecSpider2(){
        print("selecSpider")
        let folder="spider"+String(contR)
        let textureName="spider"+String(contR)+"-"
        spiderFrames = buildAnimation(named: folder, TextureName: textureName)
    }
    
  
    
    func removeActiones(_ nodes: [SKNode]){
        for (index, node) in nodes.enumerated() {
            node.isHidden=true
            node.removeAllActions()
    }
    }
    
    func animateNodes(_ nodes: [SKNode]) {
            for (index, node) in nodes.enumerated() {
                // Offset each node with a slight delay depending on the index
                let delayAction = SKAction.wait(forDuration: TimeInterval(index) * 0.2)

                // Scale up and then back down
                let scaleUpAction = SKAction.scale(to: 0.010, duration: 0.3)
                let scaleDownAction = SKAction.scale(to: 0.007, duration: 0.3)

                // Wait for 2 seconds before repeating the action
                let waitAction = SKAction.wait(forDuration: 2)

                // Form a sequence with the scale actions, as well as the wait action
                let scaleActionSequence = SKAction.sequence([scaleUpAction, scaleDownAction, waitAction])

                // Form a repeat action with the sequence
                let repeatAction = SKAction.repeatForever(scaleActionSequence)

                // Combine the delay and the repeat actions into another sequence
                let actionSequence = SKAction.sequence([delayAction, repeatAction])

                // Run the action
                node.run(actionSequence)
            }
        }
    
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            let location = touch.location(in: self)
            
            let nodess = nodes(at: location)
        
        
        for node in nodess{
        
            if node.name=="re" && finish{
                getFrames()
                selecSpider2()
                let abrir = SKAction.animate(with: abrirFrames,timePerFrame: 0.3,
                    resize: false,
                    restore: true)
                self.removeActiones(cofre)
                
               // node.position = CGPoint(x: 0, y: 0)
                node.isHidden=false
                node.run(
                    abrir,completion:{
                    self.selectSpider2()
                })
               
           
            }
        }
        }
      
   
    }
    
    func selectSpider2(){
        let newSpider = SKAction.animate(with: spiderFrames,timePerFrame: 0.3,
            resize: false,
            restore: true)
        spider?.texture=spiderFrames[0]
        spider?.isHidden=false
        spider?.run(SKAction.sequence([newSpider,SKAction.wait(forDuration: 0.5)])
            , completion:{
            self.selectActividad()
        })
    }
    
    func selectActividad(){
        if(self.actividad=="Build"){
            nextBuild()
        }else{
            nextFeed()
        }
        
    }
    
    func nextBuild(){
        if(level==1){
            let feed = web2(fileNamed:"BuildWeb")
            feed?.idParticipant=idParticipant
            feed?.haptic=haptic
            actividad="Build"
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            feed?.scaleMode = .aspectFit
            scene?.view?.presentScene(feed!, transition: transition)
        }
        if(level==2){
            let feed = web3(fileNamed:"BuildWeb")
            feed?.idParticipant=idParticipant
            feed?.haptic=haptic
            actividad="Build"
            
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            feed?.scaleMode = .aspectFit
            scene?.view?.presentScene(feed!, transition: transition)
        }
        if(level==3){
                let feed = tutorialFeed(fileNamed:"feed")
            feed?.idParticipant=idParticipant
                feed?.haptic=haptic
                actividad="feed"
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
            
            
        }
        
        
        
    }
    
    func nextFeed(){
        
        if(level==0){
            
            let feed = fead1(fileNamed:"feed")
            feed?.idParticipant=idParticipant
            feed?.haptic=haptic
            actividad="feed"
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            feed?.scaleMode = .aspectFit
            scene?.view?.presentScene(feed!, transition: transition)
            
        }
        if(level==1){
            let feed = fead2(fileNamed:"feed")
            feed?.idParticipant=idParticipant
            feed?.haptic=haptic
            actividad="feed"
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            feed?.scaleMode = .aspectFit
            scene?.view?.presentScene(feed!, transition: transition)
        }
        if(level==2){
            let feed = fead3(fileNamed:"feed")
            feed?.idParticipant=idParticipant
            feed?.haptic=haptic
            actividad="feed"
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            feed?.scaleMode = .aspectFit
            scene?.view?.presentScene(feed!, transition: transition)
        }
        if(level==3){
                let feed = selectSpider(fileNamed:"selectSpider")
            feed?.idParticipant=idParticipant
            feed?.haptic=haptic
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                feed?.scaleMode = .aspectFit
                scene?.view?.presentScene(feed!, transition: transition)
                
                
            
            
        }
        
    }
    
    
  
}
