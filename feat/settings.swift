//
//  settings.swift
//  settings
//
//  Created by Maria Fernanda Monarca Lopez  on 13/09/21.
//

import Foundation
import SpriteKit
import GameplayKit

class settings: SKScene,UITextFieldDelegate{
    var userName = UITextField()
    var IDName   = UITextField()
    var ageName  = UITextField()
    var pbName   = UITextField()
    var varName  = UITextField()
    let sv = saveData()
    var idParticipant:String="p1"
    var haptic:Bool=true
 
    override func didMove(to view: SKView) {
        
        sv.generateTxt(for: "users.txt")
        print("setting haptic", haptic)
   
        IDName.frame = CGRect(x:130, y: 106,
                                width: 110,height: 20)
        userName.frame = CGRect(x:130, y: 148,
                                width: 110,height: 20)
        ageName.frame = CGRect(x:130, y: 195,
                                width: 110,height: 20)
        pbName.frame = CGRect(x:130, y: 240,
                                width: 110,height: 20)
        
    
  
    

    self.view!.addSubview(userName)
    self.view!.addSubview(ageName)
    self.view!.addSubview(pbName)
    self.view!.addSubview(IDName)
    userName.backgroundColor = SKColor.white
    IDName.backgroundColor = SKColor.white
    ageName.backgroundColor = SKColor.white
    pbName.backgroundColor = SKColor.white
    
    userName.textColor = SKColor.black
    ageName.textColor = SKColor.black
    pbName.textColor = SKColor.black
    IDName.textColor = SKColor.black
    
        ageName.keyboardType = .numberPad
        IDName.keyboardType =  .numberPad
        
        
   

        

       
     
    }
    
    func returnText(for texto:UITextField)->String{
        var txt:String="hola"
        if let idS:String = texto.text{
            txt = idS
        }
        
        return txt
    }
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        IDName.resignFirstResponder()
        userName.resignFirstResponder()
        ageName.resignFirstResponder()
        pbName.resignFirstResponder()
        if let touch = touches.first{
            let location = touch.location(in: self)
            let nodess = nodes(at: location)
        
        
        for node in nodess{
           
            if node.name=="inicio"{
                self.startGame(for: true)
           
            }
            else if (node.name=="select"){
                removetext()
                let intro = selectLevel(fileNamed:"selectNivel")
                intro?.idParticipant=returnText(for: IDName)
                intro?.haptic=haptic
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                intro?.scaleMode = .aspectFit
                scene?.view?.presentScene(intro!, transition: transition)
            }
        }
        }
    }
    

    
    
    func removetext(){
        userName.removeFromSuperview()
        IDName.removeFromSuperview()
        ageName.removeFromSuperview()
        pbName.removeFromSuperview()
    }
    
    func startGame(for activeHaptic:Bool){
    
        var dataUser=""
        let idUser = returnText(for: IDName)
        
        dataUser = returnText(for: IDName)+","
        dataUser = dataUser + returnText(for: userName).lowercased()+","
        dataUser = dataUser + returnText(for: ageName)+","
        dataUser = dataUser + returnText(for: pbName).lowercased()
        
        print(dataUser)
        removetext()
        sv.addTexto(for: dataUser+"\n")
        
        
        let intro = intro(fileNamed:"intro")
        intro?.idParticipant=idUser
        intro?.haptic=haptic
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        intro?.scaleMode = .aspectFit
        scene?.view?.presentScene(intro!, transition: transition)
        /*
        
        let BuildWeb = tutorial(fileNamed:"BuildWeb")
            BuildWeb?.idParticipant=idUser
            BuildWeb?.haptic=haptic
            
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            BuildWeb?.scaleMode = .aspectFit
            scene?.view?.presentScene(BuildWeb!, transition: transition)
            
       
            */
        
    }
 
    
}
