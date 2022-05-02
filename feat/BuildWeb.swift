//
//  GameScene.swift
//  example01 Shared
//
//  Created by Maria Fernanda Monarca Lopez  on 27/07/21.
//

import SpriteKit
import CoreMotion

class BuildWeb: GameDynamic {
    var player: SKSpriteNode?
    var startPosition: CGPoint = CGPoint(x:0,y:0)
    var currentPosition: CGPoint = CGPoint(x:2,y:19)
    var color: UIColor = .blue
    var lastTouch: CGPoint? = nil
    var idName:String?="pt1"
    var spiderFrames: [SKTexture] = []
    var index:Int=0
    var tutorial:Bool=false
    var folder:String="spider1"
    var textueN:String="spider"
    var OrigianlSize: CGSize?
    var speed1:CGFloat=1000

    override func didMove(to view: SKView) {
        print("buildweb haptic", haptic)
        /*
        self.player = self.childNode(withName: "player") as? SKSpriteNode
         spiderFrames=buildAnimation(named: "spider1", TextureName: "spider")
         */
        cont=0
        hapticManager = HapticManager()
        
       
        
        
       // animateSpider()
        iniPuntos()
       
        
  
        
    }
    
    
    func selectSpider2(){
        print("level", level)
        var nombre:String=""
        if(level==1 || level==0){
            folder="spider1"
            textueN="spider"
            nombre="spider1"
        }else if(level==2){
            folder="spider2"
            textueN="spider2-"
            nombre="spider2-1"
        }
        else if(level==3){
           
            folder="spider3"
            textueN="spider3-"
            nombre="spider3-1"
        }
        print("folder ",folder)
        print("textura ",textueN)
      
        player = SKSpriteNode(imageNamed: nombre)
        OrigianlSize=CGSize(width: 469.7, height: 445.342)
        player?.size=self.OrigianlSize!
        player?.position = CGPoint(x: 0, y: 0)
       
        spiderFrames = buildAnimation(named: folder, TextureName: textueN)
        if(level<=1){
            textueN="spider1-"
        }
        spiderWalkingFrames=buildAnimation(named: folder+"-c", TextureName: textueN+"c-")
        spiderSpeakingFrames=buildAnimation(named: folder+"-h", TextureName: textueN+"h-")
        
        //spider?.texture=cuerpoFrames[0]
        animateSpider()
        
       
        addChild(player!)
       
    }

    

    
    
    func animateSpider() {
        
        player?.run(SKAction.repeatForever(
        SKAction.animate(with: spiderFrames,
                         timePerFrame: 0.8,
                         resize: false,
                         restore: true)),
        withKey:"idleSpider")
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let player = player
          else { return }
        let aux = player.position
        
        if (currentPosition != self.lastTouch) && (!finisHaptic) {
            let linea =
            drawLine(from: currentPosition, to: aux)
            linea.strokeColor=color
            addChild(linea)
            currentPosition = aux
        }
        
    
        let time = getTimeInt() - self.timeLastTouch
         print("time", time)
        if(fiishAction){
            print("time", time)
            if ((time > 6 && time < 9) && !hasTouch ){
                print("intruccion1")
                self.instruction=1
                self.instruction1=true
                self.instruction2=false
               // self.writeDataI(instruccion: "1")
            }else if ((time > 12 && time < 14) && !hasTouch){
                print("intruccion2")
                self.instruction=2
                self.instruction2=true
                self.instruction1=false
                self.writeDataI(instruccion: "2")
            }
            else if ((time > 18) && !hasTouch){
                print("intruccion3")
                self.instruction=2
                self.instruction2=true
                self.instruction1=true
                self.writeDataI(instruccion: "3")
            }
        
        }
        
        
        if ((finisHaptic && !end) ){
            finishgame()
        }
    }
   
 
    
    
    func nextActivity(){
 
        
        if(level==0){
            let feed = web1(fileNamed:"BuildWeb")
            feed?.idParticipant=idParticipant
            feed?.actividad="Build"
            feed?.haptic=haptic
           
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            feed?.scaleMode = .aspectFit
            scene?.view?.presentScene(feed!, transition: transition)
        }else if level==3{
            let feed = tutorialFeed(fileNamed:"feed")
            feed?.idParticipant=idParticipant
            feed?.haptic=haptic
          
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            feed?.scaleMode = .aspectFit
            scene?.view?.presentScene(feed!, transition: transition)
           
            
        }else{
            let BuildWeb = recompensa(fileNamed:"recompensa")
            BuildWeb?.haptic=haptic
            BuildWeb?.idParticipant=idParticipant
            BuildWeb?.level=level
            BuildWeb?.actividad="Build"
            
            
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            BuildWeb?.scaleMode = .aspectFit
            scene?.view?.presentScene(BuildWeb!, transition: transition)
        }
        
       
        
    
           
           
          
           
       }
       

    
    
    
    func removeCircle(){
        for child in self.children {
            if child.name == "circulo"{
                print("circulo")
                child.removeFromParent()
          }
        }
    }
    
    
    override func startTutorial(){
        print("startTutorial",haptic)
        
        let position = puntos[index]
        index = index+1
        let nameVideo = idParticipant+actividad+""+String(level)+".mov"
       /* videoCapture=videoController()
        videoCapture.checkCameraPermissions()
        videoCapture.didTapTakePhoto(nameVideo: nameVideo)*/
        let audio2 = SKAction.playSoundFileNamed("podemossentir.m4a", waitForCompletion: true)
        let audio3 = SKAction.playSoundFileNamed("atentos.m4a", waitForCompletion: true)
        let audio4 = SKAction.playSoundFileNamed("tocapantalla.m4a", waitForCompletion: true)
   
        
    let hablar = animatedSprite(for: spiderSpeakingFrames, key: "hablar", time: 0.6)
    
        player?.run(SKAction.repeatForever(hablar))
        self.run(SKAction.sequence([audio2,audio3,audio4, SKAction.wait(forDuration: 0.5)]),
            completion: {
            self.player?.removeAllActions()
            self.animateSpider()
            if(self.haptic){
                self.startHapticT()
            }else{
                self.startAudioT()
            }
            
        })
        
        
    }
    func addPunto(){
        if(index>7){
            index=0
        }
        print("punto")
        let position = self.puntos[self.index]
        self.index = self.index+1
        self.addCircle(position: position, radius: 50,tutorial: true)
        
    }
    
    func addInstruction(){
        var instruction=SKAction.run {}
        if(self.instruction1){
       // if(self.instruction==1){
            print("instruccion",self.instruction)
           instruction = SKAction.playSoundFileNamed("tocaVibracion.m4a", waitForCompletion: true)
        }
        self.run(instruction)
    }
    
   
    
    override func startAudio(){
        print("startAudio")
        let audio1 = SKAction.playSoundFileNamed("piano_1.m4a", waitForCompletion: true)
            
        let audio2 = SKAction.playSoundFileNamed("tocaVibracion.m4a", waitForCompletion: true)
        
        let recompensa = SKAction.playSoundFileNamed("casiLogramos.m4a", waitForCompletion: true)
        
        let timeTr = SKAction.run {
            self.timeAudio=self.getTime()
        }
        
        let checkInstruction = SKAction.run {
            self.addInstruction()
            
        }
        
        let addPunstos = SKAction.run {
            if(self.instruction2){
            //if(self.instruction==2){
                self.addPunto()
            }
        }
        
        let addSonido = SKAction.group([timeTr,audio1,addPunstos])
        
        let pattern = SKAction.sequence([addSonido,
            SKAction.run {self.removeCircle()},checkInstruction,
            SKAction.wait(forDuration: ritmo)])
    
        
       
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1),
            audio2,
            SKAction.wait(forDuration: 1),
            pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern, SKAction.group([pattern,recompensa]),pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,
            SKAction.wait(forDuration: 0.5)]),
            completion:{self.finisHaptic=true;})
     
        
    }
    
    
    
    
    
    
    
    override func startAudioT(){
        print("startAudio")
        let audio1 = SKAction.playSoundFileNamed("piano_1.m4a", waitForCompletion: true)
            
        let audio2 = SKAction.playSoundFileNamed("tocaquita.m4a", waitForCompletion: true)
        
        
        let timeTr = SKAction.run {
            self.timeAudio=self.getTime()
        }
        
        
        let iniTutorial = SKAction.run {
            self.addPunto()
        }
        
        let checkInstruction = SKAction.run {
            self.addInstruction()
        }
        
        let tutorial = SKAction.group([timeTr,audio1,iniTutorial])
        
        let addSonido = SKAction.group([timeTr,audio1,SKAction.run {self.removeCircle()}])
        
        let pattern = SKAction.sequence([addSonido,checkInstruction,
             SKAction.wait(forDuration: ritmo)])
        
        let patterT = SKAction.sequence([
            tutorial,
            SKAction.run {self.removeCircle()},
            checkInstruction,
            SKAction.wait(forDuration: ritmo)])
        
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1),
            audio2,
            SKAction.wait(forDuration: 1),
            patterT,patterT,patterT,patterT,
            pattern,pattern,pattern,pattern,
            pattern,pattern,
            
            SKAction.wait(forDuration: ritmo)]),
            completion:{self.finisHaptic=true;})
     
        
    }
  
    
    override func startHapticT(){
        print("startAudio")
        
        let audio1 = SKAction.run {
            self.hapticManager?.playSlice()
        }
        let audio = SKAction.playSoundFileNamed("piano2.wav", waitForCompletion: true)
            
        
        
        let timeTr = SKAction.run {
            self.timeAudio=self.getTime()
        }
        
        
        let iniTutorial = SKAction.run {
            self.addPunto()
        }
        
        let checkInstruction = SKAction.run {
            self.addInstruction()
        }
        
        let tutorial = SKAction.group([audio,timeTr,audio1,iniTutorial])
        
        let addSonido = SKAction.group([audio,timeTr,audio1,SKAction.run {self.removeCircle()}])
        
        let pattern = SKAction.sequence([addSonido,checkInstruction,
             SKAction.wait(forDuration: ritmo)])
        
        let patterT = SKAction.sequence([
            tutorial,
            SKAction.run {self.removeCircle()},
            SKAction.wait(forDuration: ritmo)])
        
        
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            patterT,patterT,patterT,patterT,
            pattern,pattern,pattern,pattern,
            pattern,pattern,
            SKAction.wait(forDuration: ritmo)]),
            completion:{self.finisHaptic=true;})
     
        
    }

    
    override func startHaptic(){
        let audio2 = SKAction.playSoundFileNamed("tocaVibracion.m4a", waitForCompletion: true)
        let audio = SKAction.playSoundFileNamed("piano2.wav", waitForCompletion: true)
        let flat = SKAction.run {
            self.hapticManager?.playSlice()
        }
        
        let recompensa = SKAction.playSoundFileNamed("casiLogramos.m4a", waitForCompletion: true)
        
        let timeTr = SKAction.run {
            self.timeAudio=self.getTime()
        }
        
        let checkInstruction = SKAction.run {
            self.addInstruction()
        }
        
        let addPunstos = SKAction.run {
            if(self.instruction2){
            //if(self.instruction==2){
                self.addPunto()
            }
        }
        
        let addSonido = SKAction.group([timeTr,audio,flat,addPunstos])
        
        let pattern = SKAction.sequence([addSonido,
            SKAction.run {self.removeCircle()},checkInstruction,
            SKAction.wait(forDuration: ritmo)])
    
        
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1),
            audio2,
            SKAction.wait(forDuration: 1),
            pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,SKAction.group([pattern,recompensa]),pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,pattern,
            SKAction.wait(forDuration: 0.5)]),
            completion:{self.finisHaptic=true;})
    }
        
  func finishgame(){
      guard let player = player
      else {return}
      self.end=true
      archivoFead.closeFile()
      print("finis level",level)
      /*
      if(level>0){
          let nameVideo = idParticipant+actividad+""+String(level)+".mov"
          videoCapture.didTapTakePhoto(nameVideo: nameVideo)
      }*/
      
    
      
      var audioFin=SKAction.playSoundFileNamed("piano2.wav", waitForCompletion: true)
      
      
      if(level>0 && level<3){
          audioFin=SKAction.playSoundFileNamed("finLevelBuild.m4a", waitForCompletion: true)
      }else if (level==3)
      {
          print("AUDIO3")
          audioFin=SKAction.playSoundFileNamed("finBuild.m4a", waitForCompletion: true)
      }
      
      let hablar = animatedSprite(for: spiderSpeakingFrames, key: "hablar", time: 0.6)
      
   
      let position = CGPoint(x:0, y:0)
      var circle = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 200, height: 200), cornerRadius: 200)
      let followCircle1 = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: true, duration: 1.0)
            
     circle = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 400, height: 400), cornerRadius: 400)
     let followCircle2 = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: true, duration: 1.0)
            
     circle = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 600, height: 600), cornerRadius: 600)
     let followCircle3 = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: true, duration: 1.0)
            
    circle = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 800, height: 800), cornerRadius: 800)
    let followCircle4 = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: true, duration: 1.0)
    
      let cirlce1 = SKAction.run {self.addCircle(position: position, radius: 200,tutorial: false)}
      let cirlce2 = SKAction.run {self.addCircle(position: position, radius: 400,tutorial: false)}
      let cirlce3 = SKAction.run {self.addCircle(position: position, radius: 600,tutorial: false)}
      let cirlce4 = SKAction.run {self.addCircle(position: position, radius: 800,tutorial: false)}
            
      let restar = SKAction.run {
        player.zRotation=0;
        player.position=position}
      let listo = SKAction.playSoundFileNamed("listo.m4a", waitForCompletion: true)
      
      let mm = SKAction.playSoundFileNamed("muchomejor.m4a", waitForCompletion: true)
      
      
      player.run(SKAction.repeatForever(hablar))
      player.run(SKAction.sequence([restar,listo,followCircle1,cirlce1,followCircle2,cirlce2,followCircle3,cirlce3,followCircle4,cirlce4,restar,mm,audioFin,SKAction.wait(forDuration: 0.5),]),completion: {self.nextActivity()})
        
           
        
           
            
            }
                             
            
        
               

 
    
    fileprivate func updatePlayer() {
      guard let player = player,
      let touch = lastTouch
        else { return }
        self.fiishAction=false
        followPath(for: player, to: touch, speed: speed1)
       
    
    }
    
    func followPath(for sprite: SKSpriteNode,
                    to target: CGPoint,
                    speed: CGFloat){
        let path = CGMutablePath()
        path.move(to: startPosition)
        path.addLine(to: target)
        let followLine = SKAction.follow(path, speed: speed)
        let reversedLine = followLine.reversed()
        
        let pasos = SKAction.playSoundFileNamed("steps3.wav", waitForCompletion: true)
        
        let caminar = animatedSprite(for: spiderWalkingFrames, key: "caminar", time:0.3)
        //sprite.removeAllActions()
        sprite.run(SKAction.sequence([SKAction.group([pasos,followLine]), SKAction.group([pasos,reversedLine]),
            ]),
            completion:{
            sprite.position=self.startPosition;
            self.cont+=1;
            self.fiishAction=true;
            self.hasTouch=false
            self.timeLastTouch=self.getTimeInt();
            self.animateSpider()
        })
        
    }
    
    


    
    fileprivate func handleTouchs (_ touches: Set<UITouch>){
        lastTouch = touches.first?.location(in: self)
        writeData(touch: touches.first!)
               

    }
    
    

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  handleTouchs(touches)
  hasTouch=true
    instruction=0
    instruction1=false
    instruction2=false
  color=generateRandomColor()
  self.instruction=0
  if(finisHaptic==false) && (fiishAction) {
      currentPosition=startPosition
      color = generateRandomColor()
      updatePlayer()

  }
  


}
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
          handleTouchs(touches)
      }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         handleTouchs(touches)
         id+=1
        
        if (lastTouch == touches.first?.location(in: self)){
            typeGesture="tap"
            print("tap")
        }else{
            print("drag")
            typeGesture="drag"
           
        }
     }

  }

  


  

    
    

