//
//  GameScene.swift
//  feat
//
//  Created by Maria Fernanda Monarca Lopez  on 16/08/21.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene,UITextFieldDelegate{
   
    override func didMove(to view: SKView) {
        
   
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          self.view!.endEditing(true);
          
          return false;
        }
    
 
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        
        if let touch = touches.first{
            let location = touch.location(in: self)
            let nodess = nodes(at: location)
        
        
        for node in nodess{
            if node.name=="start"{
                
                self.startGame(for: true)
           
            }
            else if(node.name=="noHaptic"){
                self.startGame(for: false)
            }
            
        }
        }
    }
    
    func startGame(for activeHaptic:Bool){
        
    
        print("activrHaptic ",activeHaptic)
            
        let intro = settings(fileNamed:"settings")
        intro?.haptic=activeHaptic
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        intro?.scaleMode = .aspectFit
        scene?.view?.presentScene(intro!, transition: transition)

        
        /*
        let intro = intro(fileNamed:"intro")
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        intro?.scaleMode = .aspectFit
        scene?.view?.presentScene(intro!, transition: transition)*/
        /*
        let BuildWeb = fead1(fileNamed:"feed")
        BuildWeb?.idParticipant=self.varName!
        BuildWeb?.haptic=activeHaptic
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        BuildWeb?.scaleMode = .aspectFit
        scene?.view?.presentScene(BuildWeb!, transition: transition)*/
    }
 
    
    
    
}
