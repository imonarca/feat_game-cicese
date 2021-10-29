//
//  intro.swift
//  intro
//
//  Created by Maria Fernanda Monarca Lopez  on 17/08/21.
//
import SpriteKit

class intro:GameDynamic{
    
    
    //var spider: SKSpriteNode?
    var audio : SKAudioNode?
    var isPlaying: Bool?
    var contAudio: Int?
    var followLine : SKAction?
    var intro1 : SKAudioNode?
    var intro2 : SKAudioNode?
    var intro3 : SKAudioNode?
    var intro4 : SKAudioNode?
    var intro5 : SKAudioNode?
    var spider: SKSpriteNode?
    var spiderFrames: [SKTexture] = []
    override func didMove(to view: SKView) {
        print("intro")
        isPlaying=true
        contAudio=1
        self.spider = self.childNode(withName: "player") as? SKSpriteNode
        let web = self.childNode(withName: "web") as? SKSpriteNode
        web?.isHidden=true

        spiderFrames=buildAnimation(named: "spider1", TextureName: "spider")
        animateSpider()
        spiderSpeakingFrames=buildAnimation(named: "spider1-h", TextureName: "spider1-h-")
        let hablar = animatedSprite(for: spiderSpeakingFrames, key: "hablar", time: 0.6)
        
        
        
        let buildWeb = SKAction.run {
            self.addCirculos()
            self.iniPuntos()
            self.addLinesWeb()
        }
        
        let triste = SKAction.sequence([.group([buildWeb]),
                                        .wait(forDuration: 0.2),
                                        .run {self.hideWeb()
        }])
           
        
        spider?.run(SKAction.repeatForever(hablar))
        followPath(for: spider!, from: spider!.position ,to:CGPoint(x: 0, y: -500) , speed: 300)
        
        let audio1 =  SKAction.playSoundFileNamed("hola.m4a", waitForCompletion: true)
        
        spider?.run(SKAction.group([audio1,self.followLine!])
            ,completion: {self.spider?.zRotation=0})
        
        
        let audio2 =  SKAction.playSoundFileNamed("hambre.m4a", waitForCompletion: true)
        let audio3 =  SKAction.playSoundFileNamed("necesitodetuayuda.m4a", waitForCompletion: true)
 
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1), audio3,audio2,triste,SKAction.run {
            self.nextLevel()
        }]))
        
    }
   func addCirculos(){
        addCircle(position: CGPoint(x: 0, y: 0), radius: 100, tutorial: false)
        addCircle(position: CGPoint(x: 0, y: 0), radius: 200, tutorial: false)
        addCircle(position: CGPoint(x: 0, y: 0), radius: 300, tutorial: false)
        addCircle(position: CGPoint(x: 0, y: 0), radius: 400, tutorial: false)
        addCircle(position: CGPoint(x: 0, y: 0), radius: 600, tutorial: false)
    }
    func hideWeb(){
        for node in lineas{
            node.isHidden=true
        }
    }
    
    func animateSpider() {
        
        spider?.run(SKAction.repeatForever(
        SKAction.animate(with: spiderFrames,
                         timePerFrame: 0.8,
                         resize: false,
                         restore: true)),
        withKey:"idleSpider")
    }
    
    func nextLevel(){
        let BuildWeb = tutorial(fileNamed:"BuildWeb")
        BuildWeb?.idParticipant=idParticipant
        BuildWeb?.haptic=haptic
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        BuildWeb?.scaleMode = .aspectFit
        scene?.view?.presentScene(BuildWeb!, transition: transition)
    }
    
    func followPath(for sprite: SKSpriteNode, from startPosition:CGPoint,
                    to target: CGPoint,
                    speed: CGFloat){
        let path = CGMutablePath()
        path.move(to: startPosition)
        path.addLine(to: target)
        followLine = SKAction.follow(path, speed: speed)


        
    }
    

    
    func borraParedes(){
        for child in self.children {
          if child.name == "pared2" {
              child.isHidden=true
            }
          }
        }
    }
    

    

