//
//  GameDynamic.swift
//  GameDynamic
//
//  Created by Maria Fernanda Monarca Lopez  on 27/09/21.
//

import Foundation
import SpriteKit

class GameDynamic: SKScene{
    
    var level:Int=0
    var idParticipant:String="1"
    var actividad:String="web"
    let limit:Int = 10
    
    var cont:Int=0
    var timeAudio:String=""
    var end:Bool=false
    var ritmo:Double = 2.5
    let methodStart = NSDate()
    var id:Int=1
    let sv = saveData()
    var haptic:Bool=true
    var finisHaptic:Bool=false
    var hapticManager: HapticManager?
    var motion = MotionManager()
    var instruction:Int=0
    var timeLastTouch:Int=0
    var typeGesture:String=""
    var fiishAction:Bool=true
    var puntos:[CGPoint] = []
    var hasTouch:Bool=false
    var lineas: [SKShapeNode] = []
    var instruction1:Bool=false
    var instruction2:Bool=false
    var spiderWalkingFrames: [SKTexture] = []
    var spiderSpeakingFrames: [SKTexture] = []
    var timeInicio:Int=0
   
   
    func startFile(){
        print("se abrio archivo")
        iniGame=true
        archivoFead=saveData()
        archivoFead.generatedCSVFile(for: "p"+idParticipant+"-"+actividad+"-"+String(level)+".csv")
       
     }
    
    
    func buildAnimation(named:String,TextureName:String)-> [SKTexture]{
        let spiderAnimatedAtlas = SKTextureAtlas(named: named)
        var textures: [SKTexture] = []
        let numImages = spiderAnimatedAtlas.textureNames.count
      
        for i in 1...numImages {
           
          let spiderTextureName = TextureName+"\(i)"
            print(spiderTextureName)
            textures.append(spiderAnimatedAtlas.textureNamed(spiderTextureName))
        }
        
        return textures
    }
    
    func animatedSprite(for sprite:[SKTexture], key:String, time:CGFloat)->SKAction{
        return SKAction.animate(with: sprite,
                         timePerFrame: time,
                         resize: false,
                         restore: true)
    }
    
    func getTime()->String{
        let methodFinish = NSDate()
        let executionTime = methodFinish.timeIntervalSince(methodStart as Date)
        return "\(executionTime)"
    }
    
    func getTimeInt()->Int{
        let methodFinish = NSDate()
        let executionTime = methodFinish.timeIntervalSince(methodStart as Date)
       // print("Execution time: \(executionTime)")
        return Int(executionTime)
    }
    
    func generateRandomColor() -> UIColor{
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        
        let randomColor = UIColor (red:redValue, green:greenValue,blue: blueValue, alpha: 1.0)
        return randomColor
        
    }
    
    func getForceNorma(touch: UITouch)->String{
        let maximumPossibleForce: CGFloat = touch.maximumPossibleForce;
        let force: CGFloat = touch.force
        let norForce: CGFloat = force/maximumPossibleForce
        return "\(norForce)"
        
        
    }
    
    func getForce(touch: UITouch)->String{
        let force: CGFloat = touch.force
        return "\(force)"
    }
    
    func iniPuntos(){
        puntos.append(CGPoint(x:320, y: 640))
        puntos.append(CGPoint(x:-320, y: 640))
        puntos.append(CGPoint(x:-320, y: -640))
        puntos.append(CGPoint(x:320, y: -640))
        puntos.append(CGPoint(x:300, y: 0))
        puntos.append(CGPoint(x:-300, y: 0))
        puntos.append(CGPoint(x:0, y: 640))
        puntos.append(CGPoint(x:0, y: -640))
    }
    
    func writeData(touch: UITouch){
 
      archivoFead.writeData(for: [[String(id),
                          "\(getTime())",
                      "\(touch.location(in: self).x)",
                      "\(touch.location(in: self).y)",
                      "\(timeAudio)",
                      "\(touch.type)",
                      "\(typeGesture)",
                      getForceNorma(touch: touch),
                      "\(motion.x)",
                      "\(motion.y)",
                      "\(motion.z)",
                      "\(motion.gx)",
                      "\(motion.gy)",
                      "\(motion.gz)",
                      "\(touch.majorRadius)",
                      "\(motion.acx)",
                      "\(motion.acy)",
                      "\(motion.acz)",
                      "\(getForce(touch: touch))"
                      ]])
        
    }
    
    func writeDataI(instruccion: String){
 
      archivoFead.writeData(for: [["-1",
                         "\(getTime())","","",
                        "\(timeAudio)","",
                       "\(instruccion)","",
                      "","","","","","","","","","",""
                      ]])
        
    }
    
    
    func drawLine(from: CGPoint, to:CGPoint)-> SKShapeNode{
        let line = SKShapeNode()
        let path = CGMutablePath()
        path.addLines(between: [from, to])
        line.path = path
        line.strokeColor = SKColor.white
        line.lineWidth = 10
        line.name="linea"
        return line
        //addChild(line)
        //lineas.append(line)
   
    }
    
    func addLinesWeb(){
        
        let startPoint=CGPoint(x: 0, y: 0)
        for punto in puntos{
            let linea = drawLine(from: startPoint, to: punto)
            addChild(linea)
            lineas.append(linea)
        }
        
  
        
    }
    
    func addCircle(position:CGPoint,radius:CGFloat,tutorial:Bool){

        let Circle = SKShapeNode(circleOfRadius: radius ) // Size of Circle
        Circle.position = position
        if(tutorial){
            Circle.fillColor = generateRandomColor()
        }else {
            Circle.strokeColor = SKColor.white
            Circle.lineWidth = 10
        }
        Circle.name="circulo"
        self.addChild(Circle)
        lineas.append(Circle)
       
        if(tutorial){
            self.ScaleNodes(node: Circle)
        }
    }
    
    func startVideoFree(){
     /*
            let nameVideo = idParticipant+actividad+""+String(level)+".mov"
            videoCapture=videoController()
            videoCapture.checkCameraPermissions()
            videoCapture.didTapTakePhoto(nameVideo: nameVideo)
        */
    }
    
    
    func startGame(){
     
        timeInicio=getTimeInt()
        /*
        if(level>0){
            let nameVideo = idParticipant+actividad+""+String(level)+".mov"
            videoCapture=videoController()
            videoCapture.checkCameraPermissions()
            videoCapture.didTapTakePhoto(nameVideo: nameVideo)
        }*/
        print("feed level",level)
        if(haptic){
            self.startHaptic()
        }else{
            self.startAudio()
        }
    }
    
    
    func startTutorial(){
        print("feed level",level)
 
        if(haptic){
            self.startHapticT()
        }else{
            self.startAudioT()
        }
    }
    
    func startHaptic(){
        
    }
    
    func startHapticT(){
        
    }
    
    func startAudioT(){
        
    }
    func startAudio(){
        
    }
    
    
    func shakeNodes(_ nodes: [SKShapeNode], dur:Float){
        for (index, node) in nodes.enumerated() {
            self.shake(layer: node, duration: dur)
        }
    }
    
    func shake(layer:SKNode, duration:Float) {

       let amplitudeX:Float = 10;
       let amplitudeY:Float = 6;
       let numberOfShakes = duration / 0.04;
       var actionsArray:[SKAction] = [];
       for index in 1...Int(numberOfShakes) {
           let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
           let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
           let shakeActionX = SKAction.moveTo(x: CGFloat(moveX), duration: 0.02)
           
           let shakeActionY = SKAction.moveTo(y: CGFloat(moveY), duration: 0.02)
           
           shakeActionX.timingMode = SKActionTimingMode.easeOut;
           shakeActionY.timingMode = SKActionTimingMode.easeOut;
           actionsArray.append(SKAction.group([shakeActionX,shakeActionY]))
           actionsArray.append(SKAction.group([shakeActionX.reversed(),
               shakeActionY.reversed()]))
        
       }

      
        let actionSeq = SKAction.sequence(actionsArray)
        layer.run(actionSeq )
   }
    
    func ScaleNodes(node:SKNode) {
       
        let delayAction = SKAction.wait(forDuration: TimeInterval(1) * 0.2)

                // Scale up and then back down
                let scaleUpAction = SKAction.scale(to: 0.5, duration: 0.2)
                let scaleDownAction = SKAction.scale(to: 1, duration: 0.2)

                
        // Wait for 2 seconds before repeating the action
        let waitAction = SKAction.wait(forDuration: 0.2)

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
