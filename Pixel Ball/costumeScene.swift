//
//  GameScene.swift
//  Word Rusher
//
//  Created by Adeel Din on 2019-07-15.
//  Copyright © 2019 Adeel Din. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

var costumeSelect =  UserDefaults.standard.string(forKey: "costumeSelectKey") ?? "none"

var purchaseCheck1 = UserDefaults.standard.string(forKey: "purchaseCheckKey1") ?? "False"
var purchaseCheck2 = UserDefaults.standard.string(forKey: "purchaseCheckKey2") ?? "False"
var purchaseCheck3 = UserDefaults.standard.string(forKey: "purchaseCheckKey3") ?? "False"
var purchaseCheck4 = UserDefaults.standard.string(forKey: "purchaseCheckKey4") ?? "False"
var purchaseCheck5 = UserDefaults.standard.string(forKey: "purchaseCheckKey5") ?? "False"
var purchaseCheck6 = UserDefaults.standard.string(forKey: "purchaseCheckKey6") ?? "False"
var purchaseCheck7 = UserDefaults.standard.string(forKey: "purchaseCheckKey7") ?? "False"
var purchaseCheck8 = UserDefaults.standard.string(forKey: "purchaseCheckKey8") ?? "False"
var purchaseCheck9 = UserDefaults.standard.string(forKey: "purchaseCheckKey9") ?? "False"
var purchaseCheck10 = UserDefaults.standard.string(forKey: "purchaseCheckKey10") ?? "False"





class costumeScene: SKScene, SKPhysicsContactDelegate {



    var label = SKLabelNode()

    var player1Back = SKSpriteNode()
    var player2Back = SKSpriteNode()
    var player3Back = SKSpriteNode()
    var player4Back = SKSpriteNode()
    var player5Back = SKSpriteNode()
//  var player6Back = SKSpriteNode()
//    var player7Back = SKSpriteNode()
//    var player8Back = SKSpriteNode()
//    var player9Back = SKSpriteNode()
//    var player10Back = SKSpriteNode()

    override func sceneDidLoad() {
        scaleMode = .resizeFill
        scaleMode = .fill
    }
    func changeCostume() {
         costumeSelect =  UserDefaults.standard.string(forKey: "costumeSelectKey") ?? "Moving Right Ninja"
    }

    override func didMove(to view: SKView) {

        
//        label.text = totalScore
//        scoreSystem().callMe()
        changeLabel()
        
        let player1Block = childNode(withName: "player1Block")
        let player2Block = childNode(withName: "player2Block")
        let player3Block = childNode(withName: "player3Block")
        let player4Block = childNode(withName: "player4Block")
        let player5Block = childNode(withName: "player5Block")
//        let player6Block = childNode(withName: "player6Block")
//        let player7Block = childNode(withName: "player7Block")
//        let player8Block = childNode(withName: "player8Block")
//        let player9Block = childNode(withName: "player9Block")
//        let player10Block = childNode(withName: "player10Block")

        let player1Back = childNode(withName: "player1Back") as! SKSpriteNode
        let player2Back = childNode(withName: "player2Back") as! SKSpriteNode
        let player3Back = childNode(withName: "player3Back") as! SKSpriteNode
        let player4Back = childNode(withName: "player4Back") as! SKSpriteNode
        let player5Back = childNode(withName: "player5Back") as! SKSpriteNode
//        let player6Back = childNode(withName: "player6Back") as! SKSpriteNode
//        let player7Back = childNode(withName: "player7Back") as! SKSpriteNode
//        let player8Back = childNode(withName: "player8Back") as! SKSpriteNode
//        let player9Back = childNode(withName: "player9Back") as! SKSpriteNode
//        let player10Back = childNode(withName: "player10Back") as! SKSpriteNode

        player1Back.color = .lightGray
        player2Back.color = .lightGray
        player3Back.color = .lightGray
        player4Back.color = .lightGray
        player5Back.color = .lightGray
//        player6Back.color = .lightGray
//        player7Back.color = .lightGray
//        player8Back.color = .lightGray
//        player9Back.color = .lightGray
//        player10Back.color = .lightGray

        if purchaseCheck1 == "true" {
            player1Block?.removeFromParent()
        }
        if purchaseCheck2 == "true" {
            player2Block?.removeFromParent()
        }
        if purchaseCheck3 == "true" {
            player3Block?.removeFromParent()
        }
        if purchaseCheck4 == "true" {
            player4Block?.removeFromParent()
        }
        if purchaseCheck5 == "true" {
            player5Block?.removeFromParent()
        }
//        if purchaseCheck6 == "true" {
//            player6Block?.removeFromParent()
//        }
//        if purchaseCheck7 == "true" {
//            player7Block?.removeFromParent()
//        }
//        if purchaseCheck8 == "true" {
//            player8Block?.removeFromParent()
//        }
//        if purchaseCheck9 == "true" {
//            player9Block?.removeFromParent()
//        }
//        if purchaseCheck10 == "true" {
//            player10Block?.removeFromParent()
//
//        }
    }
    func scoreSystem() {
        var newScore = Int(totalGems) ?? 0
        newScore = newScore - 200
        UserDefaults.standard.set(newScore, forKey: "gemSelectKey");
        
        totalGems = UserDefaults.standard.string(forKey: "gemSelectKey") ?? "0"
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            let player1Back = childNode(withName: "player1Back") as! SKSpriteNode
            let player2Back = childNode(withName: "player2Back") as! SKSpriteNode
            let player3Back = childNode(withName: "player3Back") as! SKSpriteNode
            let player4Back = childNode(withName: "player4Back") as! SKSpriteNode
            let player5Back = childNode(withName: "player5Back") as! SKSpriteNode
//            let player6Back = childNode(withName: "player6Back") as! SKSpriteNode
//            let player7Back = childNode(withName: "player7Back") as! SKSpriteNode
//            let player8Back = childNode(withName: "player8Back") as! SKSpriteNode
//            let player9Back = childNode(withName: "player9Back") as! SKSpriteNode
//            let player10Back = childNode(withName: "player10Back") as! SKSpriteNode
            let player1Block = childNode(withName: "player1Block")
            let player2Block = childNode(withName: "player2Block")
            let player3Block = childNode(withName: "player3Block")
            let player4Block = childNode(withName: "player4Block")
            let player5Block = childNode(withName: "player5Block")
//            let player6Block = childNode(withName: "player6Block")
//            let player7Block = childNode(withName: "player7Block")
//            let player8Block = childNode(withName: "player8Block")
//            let player9Block = childNode(withName: "player9Block")
//            let player10Block = childNode(withName: "player10Block")
            
            if touchedNode.name == "Back"  {
                let newScene = SKScene(fileNamed: "menu")
                newScene!.scaleMode = self.scaleMode
                let animation = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(newScene!, transition: animation)
                
            }

            if touchedNode.name == "player1Block" {
                if Int(totalGems) ?? 0 >= 200 {
                    scoreSystem()
                    changeLabel()
                    player1Block?.removeFromParent()
                    UserDefaults.standard.set("true", forKey: "purchaseCheckKey1");
                    purchaseCheck1 = UserDefaults.standard.string(forKey: "purchaseCheckKey1") ?? "False"
                }

            }
            if touchedNode.name == "player2Block" {
                if Int(totalGems) ?? 0 >= 200 {
                    scoreSystem()
                    changeLabel()
                    player2Block?.removeFromParent()
                    UserDefaults.standard.set("true", forKey: "purchaseCheckKey2");
                    purchaseCheck2 = UserDefaults.standard.string(forKey: "purchaseCheckKey2") ?? "False"
                }

            }

            if touchedNode.name == "player3Block" {
                if Int(totalGems) ?? 0 >= 200 {
                    scoreSystem()
                    changeLabel()
                UserDefaults.standard.set("true", forKey: "purchaseCheckKey3");
                purchaseCheck3 = UserDefaults.standard.string(forKey: "purchaseCheckKey3") ?? "False"
                player3Block?.removeFromParent()

                }
            }
            if touchedNode.name == "player4Block" {
                if Int(totalGems) ?? 0 >= 200 {
                    scoreSystem()
                    changeLabel()
                UserDefaults.standard.set("true", forKey: "purchaseCheckKey4");
                purchaseCheck4 = UserDefaults.standard.string(forKey: "purchaseCheckKey4") ?? "False"
                player4Block?.removeFromParent()
                }
            }
            if touchedNode.name == "player5Block" {
                if Int(totalGems) ?? 0 >= 200 {
                    scoreSystem()
                    changeLabel()
                UserDefaults.standard.set("true", forKey: "purchaseCheckKey5");
                purchaseCheck5 = UserDefaults.standard.string(forKey: "purchaseCheckKey5") ?? "False"
                player5Block?.removeFromParent()

                }
            }

//            if touchedNode.name == "player6Block" {
//                if totalScores >= 1000 {
//                     scoreSystem().removeScoreCostume()
//                    scoreSystem().callMe()
//                UserDefaults.standard.set("true", forKey: "purchaseCheckKey6");
//                purchaseCheck6 = UserDefaults.standard.string(forKey: "purchaseCheckKey6") ?? "False"
//                player6Block?.removeFromParent()
//                    changeLabel()
//                }
//            }
//            if touchedNode.name == "player7Block" {
//                if totalScores >= 1000 {
//                     scoreSystem().removeScoreCostume()
//                    scoreSystem().callMe()
//                    changeLabel()
//                UserDefaults.standard.set("true", forKey: "purchaseCheckKey7");
//                purchaseCheck7 = UserDefaults.standard.string(forKey: "purchaseCheckKey7") ?? "False"
//                player7Block?.removeFromParent()
//                }
//            }
//            if touchedNode.name == "player8Block" {
//                if totalScores >= 1000 {
//                     scoreSystem().removeScoreCostume()
//                    scoreSystem().callMe()
//                    changeLabel()
//                UserDefaults.standard.set("true", forKey: "purchaseCheckKey8");
//                purchaseCheck8 = UserDefaults.standard.string(forKey: "purchaseCheckKey8") ?? "False"
//                player8Block?.removeFromParent()
//                }
//            }
//
//            if touchedNode.name == "player9Block" {
//                if totalScores >= 1000 {
//                     scoreSystem().removeScoreCostume()
//                    scoreSystem().callMe()
//                    changeLabel()
//                UserDefaults.standard.set("true", forKey: "purchaseCheckKey9");
//                purchaseCheck9 = UserDefaults.standard.string(forKey: "purchaseCheckKey9") ?? "False"
//                player9Block?.removeFromParent()
//                }
//            }
//            if touchedNode.name == "player10Block" {
//                if totalScores >= 1000 {
//                     scoreSystem().removeScoreCostume()
//                    scoreSystem().callMe()
//                    changeLabel()
//                UserDefaults.standard.set("true", forKey: "purchaseCheckKey10");
//                purchaseCheck10 = UserDefaults.standard.string(forKey: "purchaseCheckKey10") ?? "False"
//                player10Block?.removeFromParent()
//                }
//            }


            if touchedNode.name == "player1" {
                UserDefaults.standard.set("player1", forKey: "costumeSelectKey");
                player1Back.color = .green

                player2Back.color = .lightGray
                player3Back.color = .lightGray
                player4Back.color = .lightGray
                player5Back.color = .lightGray
//                player6Back.color = .lightGray
//                player7Back.color = .lightGray
//                player8Back.color = .lightGray
//                player9Back.color = .lightGray
//                player10Back.color = .lightGray
                changeCostume()
            }

            if touchedNode.name == "player2" {
                UserDefaults.standard.set("player2", forKey: "costumeSelectKey");
                 player2Back.color = .green

                player1Back.color = .lightGray

                player3Back.color = .lightGray
                player4Back.color = .lightGray
                player5Back.color = .lightGray
//                player6Back.color = .lightGray
//                player7Back.color = .lightGray
//                player8Back.color = .lightGray
//                player9Back.color = .lightGray
//                player10Back.color = .lightGray
                changeCostume()
            }
            if touchedNode.name == "player3" {
                UserDefaults.standard.set("player3", forKey: "costumeSelectKey");
                player3Back.color = .green

                player1Back.color = .lightGray
                player2Back.color = .lightGray

                player4Back.color = .lightGray
                player5Back.color = .lightGray
//                player6Back.color = .lightGray
//                player7Back.color = .lightGray
//                player8Back.color = .lightGray
//                player9Back.color = .lightGray
//                player10Back.color = .lightGray
                changeCostume()
            }
            if touchedNode.name == "player4" {
                UserDefaults.standard.set("player4", forKey: "costumeSelectKey");
                player4Back.color = .green

                player1Back.color = .lightGray
                player2Back.color = .lightGray
                player3Back.color = .lightGray

                player5Back.color = .lightGray
//                player6Back.color = .lightGray
//                player7Back.color = .lightGray
//                player8Back.color = .lightGray
//                player9Back.color = .lightGray
//                player10Back.color = .lightGray
                changeCostume()
            }
            if touchedNode.name == "player5" {
                UserDefaults.standard.set("player5", forKey: "costumeSelectKey");
                
                player5Back.color = .green

                player1Back.color = .lightGray
                player2Back.color = .lightGray
                player3Back.color = .lightGray
                player4Back.color = .lightGray

//                player6Back.color = .lightGray
//                player7Back.color = .lightGray
//                player8Back.color = .lightGray
//                player9Back.color = .lightGray
//                player10Back.color = .lightGray
                changeCostume()
            }
//            if touchedNode.name == "player6" {
//                UserDefaults.standard.set("grimReaper", forKey: "costumeSelectKey");
//                player6Back.color = .green
//
//                player1Back.color = .lightGray
//                player2Back.color = .lightGray
//                player3Back.color = .lightGray
//                player4Back.color = .lightGray
//                player5Back.color = .lightGray
//
//                player7Back.color = .lightGray
//                player8Back.color = .lightGray
//                player9Back.color = .lightGray
//                player10Back.color = .lightGray
//                changeCostume()
//            }
//            if touchedNode.name == "player7" {
//                UserDefaults.standard.set("octopus", forKey: "costumeSelectKey");
//                player7Back.color = .green
//
//                player1Back.color = .lightGray
//                player2Back.color = .lightGray
//                player3Back.color = .lightGray
//                player4Back.color = .lightGray
//                player5Back.color = .lightGray
//                player6Back.color = .lightGray
//
//                player8Back.color = .lightGray
//                player9Back.color = .lightGray
//                player10Back.color = .lightGray
//                changeCostume()
//            }
//
//            if touchedNode.name == "player8" {
//                UserDefaults.standard.set("ninjaTurtle", forKey: "costumeSelectKey");
//                player8Back.color = .green
//
//                player1Back.color = .lightGray
//                player2Back.color = .lightGray
//                player3Back.color = .lightGray
//                player4Back.color = .lightGray
//                player5Back.color = .lightGray
//                player6Back.color = .lightGray
//                player7Back.color = .lightGray
//
//                player9Back.color = .lightGray
//                player10Back.color = .lightGray
//                changeCostume()
//            }
//            if touchedNode.name == "player9" {
//                UserDefaults.standard.set("skull", forKey: "costumeSelectKey");
//                player9Back.color = .green
//
//                player1Back.color = .lightGray
//                player2Back.color = .lightGray
//                player3Back.color = .lightGray
//                player4Back.color = .lightGray
//                player5Back.color = .lightGray
//                player6Back.color = .lightGray
//                player7Back.color = .lightGray
//                player8Back.color = .lightGray
//
//                player10Back.color = .lightGray
//                changeCostume()
//            }
//            if touchedNode.name == "player10" {
//                UserDefaults.standard.set("samuraiHelmet", forKey: "costumeSelectKey");
//                player10Back.color = .green
//
//                player1Back.color = .lightGray
//                player2Back.color = .lightGray
//                player3Back.color = .lightGray
//                player4Back.color = .lightGray
//                player5Back.color = .lightGray
//                player6Back.color = .lightGray
//                player7Back.color = .lightGray
//                player8Back.color = .lightGray
//                player9Back.color = .lightGray
//                changeCostume()
//
//            }
        }
    }
    func changeLabel() {
        label = childNode(withName: "scoreLabel") as! SKLabelNode
        label.text = String(totalGems)
    }



}
