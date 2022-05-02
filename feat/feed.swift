//
//  GameScene.swift
//  example_2 Shared
//
//  Created by Maria Fernanda Monarca Lopez  on 30/07/21.
//

import SpriteKit
import CoreMotion

class feed: GameDynamic {
    
    var selectNode = SKSpriteNode()
    var selectedNode: SKSpriteNode? = nil
    var selectedLinea: SKShapeNode? = nil
    var touch: CGPoint? = nil
    var spidy: [SKSpriteNode] = []
    var cuerpo: SKSpriteNode?
    var bug: SKSpriteNode?
    var OrigianlSize: CGSize?
    var OriginalPosition:CGPoint?
    var spider: SKSpriteNode?
    var moving: Bool = false
    var cam: SKCameraNode?
    var nodePosition = CGPoint()
    var bugPosition = CGPoint()
    var posBugs: [CGPoint] = []
    var comerFrames: [SKTexture] = []
    var circulos: [SKSpriteNode] = []
    var cuerpoFrames:[SKTexture] = []
    var circleFrames:[SKTexture] = []
    var consentradaFrames: [SKTexture] = []
    var pie1: [SKTexture] = []
    var pie2: [SKTexture] = []
    var pie3: [SKTexture] = []
    var pie4: [SKTexture] = []
    var pie5: [SKTexture] = []
    var pie6: [SKTexture] = []
    var tipoAudio:String="acendente.m4a"
    var time=0
    var folder:String="spider1"
    var textueN:String="spider"
    //SETUP  the scene
    override func didMove(to view: SKView) {
       
       spider = childNode(withName: "spider") as? SKSpriteNode
        cuerpo = childNode(withName: "cuerpo") as? SKSpriteNode
        bug = childNode(withName: "bug") as? SKSpriteNode
        cam = childNode(withName: "cam") as? SKCameraNode
        
        spider?.isHidden=true
        hapticManager = HapticManager()
        addChildrens()
   
        
        
        
        
          
          circleFrames = buildAnimation(named: "circulo", TextureName: "circulo")
          let firstFrameTexture = circleFrames[0]
          
          for child in circulos {
              child.texture=firstFrameTexture
            }
        
        
       // animateCara()
        iniPuntos()
        addLinesWeb()
        buildPies()

        spiderWalkingFrames=buildAnimation(named: "spider1-c", TextureName: "spider1-c-")
        spiderSpeakingFrames=buildAnimation(named: "spider1-h", TextureName: "spider1-h-")
        
       
    }
    
    func selecWalking(){
        if(level==2){
            folder="spider2-"
            textueN="spider2-"
            
        }
        else if(level==3){
           
            folder="spider3-"
            textueN="spider3-"
        }
        else{
            folder="spider1-"
            textueN="spider1-"
        }
        
        spiderWalkingFrames=buildAnimation(named: folder+"c", TextureName: textueN+"c-")
        spiderSpeakingFrames=buildAnimation(named: folder+"h", TextureName: textueN+"h-")
    }
    
    func selecComiendo(){
        if(level==2){
            folder="spider2-comiendo"
            textueN="spider2-comiendo"
            
        }
        else if(level==3){
           
            folder="spider3-comiendo"
            textueN="spider3-comiendo"
        }
        else{
            folder="comer"
            textueN="comiendo"
        }
        comerFrames = buildAnimation(named: folder, TextureName: textueN)
          let firstFrameTexture = comerFrames[0]
            spider?.texture=firstFrameTexture
    }
    
    
    func selecCons(){
        if(level==2){
            folder="spider2-cons"
            textueN="spider2-cons"
            
        }
        else if(level==3){
           
            folder="spider3-cons"
            textueN="spider3-cons"
        }
        else{
            folder="concentrada"
            textueN="cons"
        }
        consentradaFrames = buildAnimation(named: folder, TextureName: textueN)
    }
    
    func selecCuerpo(){
        
        if(level==2){
            folder="spider2-cara"
            textueN="spider2-cara"
            
        }
        else if(level==3){
           
            folder="spider3-cara"
            textueN="spider3-cara"
        }else{
            folder="cara"
            textueN="cara"
        }
        
      cuerpoFrames = buildAnimation(named: folder, TextureName: textueN)
    }
    
    func selectSpider2(){
        print("level", level)
        var nombre:String=""
        if(level<=1){
            folder="spider4-pies"
            textueN="spider4-pie-"
            nombre="cara3"
        }
        else if(level==2){
            folder="spider2-pies"
            textueN="spider2-pie-"
            nombre="spider2-cara"
        }
        else if(level==3){
           
            folder="spider3-pies"
            textueN="spider3-pie-"
            nombre="spider3-cara"
        }
        print("folder ",folder)
        print("textura ",textueN)
      
 
        let  piesFrames = buildAnimation(named: folder, TextureName: textueN)
          
        var i=0
        cuerpo?.texture=SKTexture(imageNamed: nombre)
        for node in spidy{
            if(node.name == "pie"){
                node.texture=piesFrames[i]
                i=i+1
            }
        }
        //spider?.texture=cuerpoFrames[0]
      
       
        //addChild(player!)
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
   

        guard let spider = spider,
              let cam = cam
          
        else { return }
        
        time = getTimeInt() - self.timeLastTouch
        if(!moving){
            print("time", time)
            if ((time > 6 && time < 9) && !hasTouch ){
                print("intruccion1")
                self.instruction=1
                self.instruction1=true
                self.instruction2=false
            }else if ((time > 12 && time < 14) && !hasTouch){
                self.instruction=2
                self.instruction2=true
                self.instruction1=false
            }
            else if ((time > 18) && !hasTouch){
                self.instruction=2
                self.instruction2=true
                self.instruction1=true
            }
        
        }
        
        
        
        
        
            
     
        if(moving){
            cam.position.y=spider.position.y
        }
          
        if ((finisHaptic && !end) ){
            animationFinish()
        }
      

    }
    
    func animationFinish(){
        end=true
        fiishAction=false
        
      
        
        var inst = SKAction.playSoundFileNamed("quericocomi.m4a", waitForCompletion: true)
        
        if(level==3){
             inst = SKAction.playSoundFileNamed("graciasComida.m4a", waitForCompletion: true)
        }
        
        
        self.run(SKAction.sequence([inst,SKAction.wait(forDuration: 0.5)]), completion: {self.finishgame()
            
        })
        
    }
    func addChildrens(){
        for child in self.children {
            if child.name == "pie" || child.name=="cuerpo"{
            if let child = child as? SKSpriteNode {
              spidy.append(child)
            }
          }
        }
        
        
        for child in self.children {
            if child.name == "circulo"{
            if let child = child as? SKSpriteNode {
              circulos.append(child)
            }
          }
        }
    }
    
  
    
   
    
    func removeAnimationPies(){
        for node in spidy{
            if(node.name=="pie"){
                node.removeAllActions()
        }
        }
    }
    func animatePies(){
        var contp=1
        var animacion: SKAction?
        for node in spidy{
            if(node.name=="pie"){
                print("pie ", contp)
                if contp == 1{
                    animacion =  SKAction.animate(with: pie1, timePerFrame: 0.8,
                        resize: false,
                        restore: true)
                }else if (contp==2){
                    animacion =  SKAction.animate(with: pie2, timePerFrame: 0.8,
                        resize: false,
                        restore: true)
                }else if (contp==3){
                    animacion =  SKAction.animate(with: pie3, timePerFrame: 0.8,
                        resize: false,
                        restore: true)
                }else if (contp==4){
                    animacion =  SKAction.animate(with: pie4, timePerFrame: 0.8,
                        resize: false,
                        restore: true)
                }else if (contp==5){
                    animacion =  SKAction.animate(with: pie5, timePerFrame: 0.8,
                        resize: false,
                        restore: true)
                }else if (contp==6){
                    animacion =  SKAction.animate(with: pie6, timePerFrame: 0.8,
                        resize: false,
                        restore: true)
                }
                node.run( SKAction.repeatForever(
                    animacion!))
                contp = contp+1
            }
            
            
                
                
        }
    }
    
    func buildPies(){
        var AnimatedAtlas = SKTextureAtlas(named: "pie1")
        pie1.append(AnimatedAtlas.textureNamed("pie1"))
        pie1.append(AnimatedAtlas.textureNamed("pie1-r"))
        
        AnimatedAtlas = SKTextureAtlas(named: "pie2")
        pie2.append(AnimatedAtlas.textureNamed("pie2"))
        pie2.append(AnimatedAtlas.textureNamed("pie2-r"))
        
        AnimatedAtlas = SKTextureAtlas(named: "pie3")
        pie3.append(AnimatedAtlas.textureNamed("pie3"))
        pie3.append(AnimatedAtlas.textureNamed("pie3-r"))
        
        AnimatedAtlas = SKTextureAtlas(named: "pie4")
        pie4.append(AnimatedAtlas.textureNamed("pie4"))
        pie4.append(AnimatedAtlas.textureNamed("pie4-r"))
        
        AnimatedAtlas = SKTextureAtlas(named: "pie5")
        pie5.append(AnimatedAtlas.textureNamed("pie5"))
        pie5.append(AnimatedAtlas.textureNamed("pie5-r"))
        
        AnimatedAtlas = SKTextureAtlas(named: "pie6")
        pie6.append(AnimatedAtlas.textureNamed("pie6"))
        pie6.append(AnimatedAtlas.textureNamed("pie6-r"))
        
    }

    
  

        
    func animateCircle(){
        for node in circulos{
            node.run(
                SKAction.animate(with: circleFrames, timePerFrame: 0.2,
                resize: false,
                restore: true))
                
                
        }
    }
    
    func animateCara() {
  
        cuerpo?.run(SKAction.repeatForever(
            animatedSprite(for: cuerpoFrames,key:"caraSpider",time:0.8)))
                    }
     
   

    
    func addInstruction(){
        
        print("instruccion",self.instruction)
        if(self.instruction1){
        //if(self.instruction==1){
          let inst = SKAction.playSoundFileNamed("jala.m4a", waitForCompletion: true)
            self.run(inst)
        }
    
        
    }
    
    
    override func startTutorial(){
        print("startTutorial",haptic)
        let nameVideo = idParticipant+actividad+""+String(level)+".mov"
        /*videoCapture=videoController()
        videoCapture.checkCameraPermissions()
        videoCapture.didTapTakePhoto(nameVideo: nameVideo)*/
        fiishAction=false
        let audio2 = SKAction.playSoundFileNamed("AtentosCaeInsecto.m4a", waitForCompletion: true)
        let audio3 = SKAction.playSoundFileNamed("JALAUnademisPatitas.m4a", waitForCompletion: true)
 
   
        hideSpider()
    let hablar = animatedSprite(for: spiderSpeakingFrames, key: "hablar", time: 0.6)
        spider?.isHidden=false
        spider?.run(SKAction.repeatForever(hablar))
        self.run(SKAction.sequence([audio2,audio3, SKAction.wait(forDuration: 0.2)]),
            completion: {
            self.spider?.removeAllActions()
            self.hideSpider()
            self.spider?.isHidden=true
            self.fiishAction=true
            if(self.haptic){
                self.startHapticT()
            }else{
                self.startAudioT()
            }
            
        })
        
        
    }
    
    override func startHaptic() {
        var audio1:SKAction
        if tipoAudio=="acendente"{
            audio1 = SKAction.run {
                self.hapticManager?.playSplash()
            }
        }
        else
        {
            audio1 = SKAction.run {
                self.hapticManager?.playSplash2()
        }
        }
        
        let recompensa = SKAction.playSoundFileNamed("casiLogramos.m4a", waitForCompletion: true)
        
        let audio2 = SKAction.playSoundFileNamed("jala.m4a", waitForCompletion: true)
        
        let audio = SKAction.playSoundFileNamed("piano2.wav", waitForCompletion: true)
        
        let timeTr = SKAction.run {
            self.timeAudio=self.getTime()
        }
        let checkInstruction = SKAction.run {
            print("checkinstruccion")
            self.addInstruction()
        }
        let addPunstos = SKAction.run {
            if(self.instruction2){
                
                self.animatePies()
            }
        }
        
        let ranimation = SKAction.run {
            self.removeAnimationPies()
        }
        
        let addSonido = SKAction.group([audio,timeTr,audio1,addPunstos])
        
        let pattern = SKAction.sequence([checkInstruction,addSonido,ranimation ,SKAction.wait(forDuration: ritmo)])
        
        
       
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1),audio2, SKAction.wait(forDuration: 1),
            pattern,pattern,pattern,pattern,pattern,
            pattern,pattern,pattern,pattern,SKAction.group([pattern,recompensa]),
            pattern,pattern,pattern,pattern,pattern,
            pattern,pattern,pattern,pattern,pattern,
            
            SKAction.wait(forDuration: 1)]),
            completion:{self.finisHaptic=true;})
    }
    
    
    override func startAudio(){
        print("tipoAudio")
        
        let audio1 = SKAction.playSoundFileNamed(tipoAudio, waitForCompletion: true)
        let audio2 = SKAction.playSoundFileNamed("jala.m4a", waitForCompletion: true)
        
        let timeTr = SKAction.run {
            self.timeAudio=self.getTime()
        }
        let checkInstruction = SKAction.run {
            print("checkinstruccion")
            self.addInstruction()
        }
        let addPunstos = SKAction.run {
            if(self.instruction2){
            //if(self.instruction==2){
                print("instruccion",self.instruction)
                self.animatePies()
            }
        }
        
        let ranimation = SKAction.run {
            self.removeAnimationPies()
        }
        
        let addSonido = SKAction.group([timeTr,audio1,addPunstos])
        
        let pattern = SKAction.sequence([addSonido,ranimation,checkInstruction ,SKAction.wait(forDuration: ritmo)])
        
        let recompensa = SKAction.playSoundFileNamed("casiLogramos.m4a", waitForCompletion: true)
        
        
       
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1),audio2, SKAction.wait(forDuration: 1),
            pattern,pattern,pattern,pattern,pattern,
            pattern,pattern,pattern,pattern,SKAction.group([pattern,recompensa]),
            pattern,pattern,pattern,pattern,pattern,
            pattern,pattern,pattern,pattern,pattern,
            
            SKAction.wait(forDuration: 1)]),
            completion:{self.finisHaptic=true;})
        
    }
    
    override func startAudioT(){
        print("startAudio")
        let audio1 = SKAction.playSoundFileNamed(tipoAudio, waitForCompletion: true)
            
        let audio2 = SKAction.playSoundFileNamed("jala.m4a", waitForCompletion: true)
        
        let timeTr = SKAction.run {
            self.timeAudio=self.getTime()
        }
        
        
        let iniTutorial = SKAction.run {
            self.animatePies()
        }
        
        let checkInstruction = SKAction.run {
            self.addInstruction()
        }
        
        let tutorial = SKAction.group([timeTr,audio1,iniTutorial])
        
        let addSonido = SKAction.group([timeTr,audio1,SKAction.run {self.removeAnimationPies()}])
        
        let pattern = SKAction.sequence([checkInstruction,addSonido,
             SKAction.wait(forDuration: ritmo)])
        
        let patterT = SKAction.sequence([
            tutorial,
            SKAction.wait(forDuration: ritmo)])
        
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1),
            audio2,
            SKAction.wait(forDuration: 1),
            patterT,patterT,patterT,patterT,patterT,
            pattern,pattern,pattern,pattern,pattern,
            SKAction.wait(forDuration: ritmo)]),
            completion:{self.finisHaptic=true;})
     
        
    }

    
    override func startHapticT(){
        print("startAudio")
        var audio1:SKAction
        if tipoAudio=="acendente"{
            audio1 = SKAction.run {
                self.hapticManager?.playSplash()
            }
        }
        else
        {
            audio1 = SKAction.run {
                self.hapticManager?.playSplash2()
        }
        }
            
        let audio2 = SKAction.playSoundFileNamed("jala.m4a", waitForCompletion: true)
        let audio = SKAction.playSoundFileNamed("piano2.wav", waitForCompletion: true)
        
        let timeTr = SKAction.run {
            self.timeAudio=self.getTime()
        }
        
        
        let iniTutorial = SKAction.run {
            self.animatePies()
        }
        
        let checkInstruction = SKAction.run {
            self.addInstruction()
        }
        
        let tutorial = SKAction.group([audio,timeTr,audio1,iniTutorial])
        
        let addSonido = SKAction.group([audio,timeTr,audio1,SKAction.run {self.removeAnimationPies()}])
        
        let pattern = SKAction.sequence([checkInstruction,addSonido,
             SKAction.wait(forDuration: ritmo)])
        
        let patterT = SKAction.sequence([
            tutorial,
            SKAction.wait(forDuration: ritmo)])
        
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1),
            audio2,
            SKAction.wait(forDuration: 1),
            patterT,patterT,patterT,patterT,pattern,
            pattern,pattern,pattern,pattern,pattern,
    
            SKAction.wait(forDuration: ritmo)]),
            completion:{self.finisHaptic=true;})
     
        
    }
 
    
    func finishgame(){
        
        archivoFead.closeFile()
        /*
        if(level>0){
            let nameVideo = idParticipant+actividad+""+String(level)+".mov"
            videoCapture.didTapTakePhoto(nameVideo: nameVideo)
        }*/
      
        if(level==0){
            let feed = fead1(fileNamed:"feed")
            feed?.idParticipant=idParticipant
            feed?.haptic=haptic
            feed?.actividad="build"
            actividad="feed"
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            feed?.scaleMode = .aspectFit
            scene?.view?.presentScene(feed!, transition: transition)
            
        }else if(level==3){
            let feed = selectSpider(fileNamed:"selectSpider")
            feed?.haptic=haptic
            feed?.idParticipant=idParticipant
            feed?.actividad="free"
           
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            feed?.scaleMode = .aspectFit
            scene?.view?.presentScene(feed!, transition: transition)
            
        }else{
            let BuildWeb = recompensa(fileNamed:"recompensa")
            BuildWeb?.haptic=haptic
            BuildWeb?.idParticipant=idParticipant
            BuildWeb?.level=level
            BuildWeb?.actividad="Feed"
            
            
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            BuildWeb?.scaleMode = .aspectFit
            scene?.view?.presentScene(BuildWeb!, transition: transition)
            
        }
        

    }
    
 
    

    fileprivate func handleTouches(_ touches: Set<UITouch> ){
        touch = touches.first?.location(in: self)
        writeData(touch: touches.first!)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
        instruction=0
        instruction1=false
        instruction2=false
        if(fiishAction) {
           let animacion =  SKAction.animate(with: consentradaFrames, timePerFrame: 0.8,
                resize: false,
                restore: true)
            cuerpo?.run(SKAction.repeatForever(animacion))
            hasTouch=true
            selectNodeForTouch()

        }
        
   
    }
    
    
    func selectNodeForTouch(){
        guard let position = touch
        else {return}
        let touchedNode = self.nodes(at: position)
        
        for node in touchedNode.reversed() {
                if node.name == "pie" {
                    selectNode = node as! SKSpriteNode
                }
            if node.name == "linea"{
                selectedLinea  = node as? SKShapeNode
                selectedLinea?.strokeColor = self.generateRandomColor()
                
            }
            }
       
            self.OrigianlSize = selectNode.size
            OriginalPosition = selectNode.position

        
        
    }
    
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
        updateScale(for: selectNode)
       
        
    }


    
    func followPath(for sprite: SKSpriteNode, from start: CGPoint,to target: CGPoint,speed: CGFloat){
        guard let spider = spider,
              let bug = bug
          else { return }
        print("to..", target)
        self.fiishAction=false
        let path = CGMutablePath()
        path.move(to: start)
        path.addLine(to: target)
        let followLine = SKAction.follow(path, speed: speed)
        let reversedLine = followLine.reversed()
        
        let removeBug = SKAction.run {
            bug.isHidden=true
        }
        
        let comer = SKAction.animate(with: comerFrames,timePerFrame: 0.2,
            resize: false,
            restore: true)
        
        sprite.removeAllActions()
        
        let pasos = SKAction.playSoundFileNamed("steps3.wav", waitForCompletion: true)
        
    
        sprite.run(SKAction.sequence(
            [SKAction.group([pasos,followLine]),
             removeBug,comer,
             SKAction.group([pasos,reversedLine]),
            ]),completion:{
            spider.isHidden=true;
            spider.position=CGPoint(x: 0, y: 0)
            self.moving=false;
            self.cam?.position=CGPoint(x:0,y:0);
            bug.isHidden=true;
            self.animateCara();
            self.hideSpider();
            self.hasTouch=false;
            self.timeLastTouch=self.getTimeInt();
            self.fiishAction=true
            
            
        })
        

    }
    
    func updateScale(for sprite: SKSpriteNode){
       
        if (sprite.name == "pie"){
        
            let size = sprite.size
            sprite.size = CGSize(width: size.width+1.8, height: size.height)
            
            sprite.position = OriginalPosition ?? CGPoint(x: 0, y: 0)
            }
        
        }
    
    func getPositionBug(){
        let point = self.touch
        self.cont+=1
        if(point!.y>0){
            let y1 = CGFloat.random(in: 0...640)
            let x1 =  CGFloat.random(in: -320...320)
            self.bugPosition = CGPoint(x: x1, y: y1)
        }else{
            let y1 = CGFloat.random(in: -640...0)
            let x1 =  CGFloat.random(in: -320...320)
            self.bugPosition = CGPoint(x: x1, y: y1)
        }
        

        
    }
    
    func hideSpider(){
        for node in spidy {
            if(node.isHidden){
                node.isHidden=false
            }else{
                node.isHidden=true
            }

            }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
        
        moving=true
        
        id+=1
        
        if (touch == touches.first?.location(in: self)){
            typeGesture="tap"
            print("tap")
        }else{
            print("drag")
            typeGesture="drag"
           
        }
        
        guard let spider = spider,
              let Osize = OrigianlSize,
              let Opos = OriginalPosition,
              let bug = bug,
              let linea = selectedLinea
          else { return }

        selectNode.size = Osize
        selectNode.position=Opos
        linea.strokeColor=SKColor.white
        
        if(fiishAction) {
            self.getPositionBug()
            let text = Int.random(in: 0...1)
            print("INSECTO"+"\(text)"+".png")
            bug.texture = SKTexture(imageNamed: "INSECTO"+"\(text)"+".png")
            bug.setScale(0.055)
            bug.position=bugPosition
            bug.isHidden=false
            self.hideSpider()
            self.animateCircle()
            self.shakeNodes(lineas,dur: 0.5)
           
            followPath(for: spider, from: spider.position, to:bug.position,speed: 1000)
      
            spider.isHidden=false

        }
        
        
       
       
   
    }
    

}
    


    
    

