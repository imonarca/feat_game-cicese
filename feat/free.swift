//
//  free.swift
//  free
//
//  Created by Maria Fernanda Monarca Lopez  on 15/09/21.
//

import Foundation
import SpriteKit
import CoreMotion

class free:GameDynamic{
    var spider: SKSpriteNode?
    var OrigianlSize: CGSize?
    var touch: CGPoint? = nil
    var audio1:SKAction?
    var audio2:SKAction?
    var audio3:SKAction?
    var spiderS:Int=1
    var folder:String="spider1"
    var textueN:String="spider"
    var selectedLinea: [SKShapeNode] = []
    var color: UIColor = .blue
    private var cuerpoFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
       
        audio1 = SKAction.playSoundFileNamed("acendente.m4a", waitForCompletion: true)
        audio3 = SKAction.playSoundFileNamed("des.wav", waitForCompletion: true)
        audio2 = SKAction.playSoundFileNamed("piano_1.m4a", waitForCompletion: true)
        nameLevel="free"
    
       
        hapticManager = HapticManager()
       
        
        
      
        
       
        

        addCircle(position: CGPoint(x: 0, y: 0), radius: 100, tutorial: false)
        addCircle(position: CGPoint(x: 0, y: 0), radius: 200, tutorial: false)
        addCircle(position: CGPoint(x: 0, y: 0), radius: 300, tutorial: false)
        addCircle(position: CGPoint(x: 0, y: 0), radius: 400, tutorial: false)
        addCircle(position: CGPoint(x: 0, y: 0), radius: 600, tutorial: false)
        
        iniPuntos()
        addLinesWeb()
        

       
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
   
    func selectSpider2(){
        print("seleccionar la araña ", spiderS)
        var nombre:String=""
        if(spiderS==1){
            folder="spider1"
            textueN="spider"
            nombre="spider1"
        }else if(spiderS==2){
            folder="spider2"
            textueN="spider2-"
            nombre="spider2-1"
        }
        else if(spiderS==3){
            print("spider ", spiderS)
            folder="spider3"
            textueN="spider3-"
            nombre="spider3-1"
        }else if(spiderS==4){
            folder="spider4"
            textueN="spider4-"
            nombre="spider4-1"
        }
        print("folder ",folder)
        print("textura ",textueN)
      
       
        cuerpoFrames = buildAnimation(named: folder, TextureName: textueN)
        //spider?.texture=cuerpoFrames[0]
        
        spider = SKSpriteNode(imageNamed: nombre)
        spider?.position = CGPoint(x: 0, y: 0)
        OrigianlSize=CGSize(width: 469.7, height: 445.342)
        spider?.size=self.OrigianlSize!
        addChild(spider!)
        print(cuerpoFrames[0])
        
        animateCara()
    }
    
    func animateCara() {
        
        print("animates cara")
        spider?.run(SKAction.repeatForever(
        SKAction.animate(with: cuerpoFrames,
                         timePerFrame: 0.8,
                         resize: false,
                         restore: true)),
        withKey:"caraSpider")
    }
        
    
 
    
    
  

    
    fileprivate func handleTouches(_ touches: Set<UITouch> ){
        touch = touches.first?.location(in: self)
        self.writeData(touch: touches.first!
        )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        color=self.generateRandomColor()
        selectNodeForTouch()
        handleTouches(touches)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        shakeNodes(lineas,dur: 0.5)
        selectNodeForTouch()
        handleTouches(touches)
        
    }
    
    
    func maketap(){
        self.animateNodes()
        typeGesture="tap"
        if(!haptic){
            self.run(audio2!)
        }else{
            self.hapticManager?.playTap()
        }

        
    }
    
    func makedrag(m:Int){
        self.animateNodes2()
        typeGesture="drag"
        
        if(!haptic){
            if(m<0){
                
                self.run(audio1!)
            }else{
               
                self.run(audio3!)
                
            }
        }else{
            if(m<0){
                print("acendente")
                
                self.hapticManager?.playSplash()
            }else{
                print("des")
                
                self.hapticManager?.playSplash2()
            }
        }
        
        
    }
    
    func selectNodeForTouch(){
        guard let position = touch
        else {return}
        let touchedNode = self.nodes(at: position)
        
        for node in touchedNode.reversed() {
 
            if node.name == "linea" || node.name == "circulo" {
                let linea = node as? SKShapeNode
               
                selectedLinea.append(linea!)
                
            }
            }
    }
    
    func limpiaLineas(){
        for node in selectedLinea{
            node.strokeColor=SKColor.white
        }
        
        selectedLinea.removeAll()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        shakeNodes(lineas, dur: 0.5)
        id+=1
        if (touch == touches.first?.location(in: self)){
            maketap()
          
        }else{
            shakeNodes(lineas, dur: 1.5)
            let m = pendiente(from: touch!, to: (touches.first?.location(in: self))!)
            makedrag(m:m)
        }
        
     
    }
    
    func pendiente(from:CGPoint, to: CGPoint)->Int{
        var m=(to.y-from.y)/(to.x-from.x)
        if(m.isNaN || m.isInfinite){
            m=0
        }
        return Int(m)
    }
    
    func animateNodes() {
        spider?.removeAllActions()
            

                // Scale up and then back down
                let scaleUpAction = SKAction.scale(to: 0.10, duration: 0.3)
                let scaleDownAction = SKAction.scale(to: 0.07, duration: 0.3)

                
                let scaleActionSequence = SKAction.sequence([scaleUpAction, scaleDownAction])


                

                // Run the action
        spider?.run(scaleActionSequence, completion:{self.spider?.size=self.OrigianlSize!;self.animateCara();self.limpiaLineas()})
            
        }
    
    
    func animateNodes2() {
        spider?.removeAllActions()
        
        let escalar = SKAction.sequence([
            .scale(to: 0.7, duration: 0.3),
            .scale(to: 0.5, duration: 0.3)
            ])
        
        let rotar = SKAction.rotate(byAngle: .pi * 2, duration: 1.5)
        
        let animacion = SKAction.group([rotar,escalar, .wait(forDuration: 1)])
        
        spider?.run(.sequence([
            .wait(forDuration: TimeInterval(1) * 0.2),
            animacion]),completion:{
                self.spider?.size=self.OrigianlSize!;
                self.spider?.zRotation=0
                self.animateCara();
                self.limpiaLineas()
            })
               
   }
    
   
}
