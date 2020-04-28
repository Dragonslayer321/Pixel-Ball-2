//
//  GameScene.swift
//  Pixel Ball
//
//  Created by Adeel Din on 2019-09-03.
//  Copyright © 2019 Adeel Din. All rights reserved.
//

import SpriteKit
import GameplayKit
import StoreKit
import AVFoundation

let scene1 = SKScene(fileNamed: "GameScene")
let scene2 = SKScene(fileNamed: "costumeScene")
let scene3 = SKScene(fileNamed: "menu")
var gameSpeed = 0.0
var musicSound = UserDefaults.standard.string(forKey: "musicSoundKey") ?? "true"
var sfxSound =  UserDefaults.standard.string(forKey: "sfxSoundKey") ?? "true"
var currentSound = UserDefaults.standard.string(forKey: "currentSoundKey") ?? "isPlaying"
var totalOpens =  UserDefaults.standard.string(forKey: "openSelectKey") ?? "0"




class menu: SKScene, SKPhysicsContactDelegate {
    var gemLabel = SKLabelNode()
//    var onButton = SKSpriteNode()
//    var offButton = SKSpriteNode()
    
    var audioPlayer : AVAudioPlayer? {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.audioPlayer
        }
        set {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.audioPlayer = newValue
        }
    }
    
    override func sceneDidLoad() {
        scaleMode = .resizeFill
        scaleMode = .fill
    }
    
    override func didMove(to view: SKView) {
       gemLabels()
        playOrStopPlayer()
        if Int(totalOpens) ?? 0 == 5 {
            if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
            }
        }
        

//        var gifTextures: [SKTexture] = [];
//        var costume = SKSpriteNode()
//        costume = childNode(withName: "costumeButton") as! SKSpriteNode
//        for i in 1...40 {
//            autoreleasepool{
//            gifTextures.append(SKTexture(imageNamed: "accessories\(i)"));
//            }
//        }
//        var gifTextures2: [SKTexture] = [];
//        var hard = SKSpriteNode()
//        hard = childNode(withName: "hardMode") as! SKSpriteNode
//        for i in 1...24 {
//            autoreleasepool{
//            gifTextures2.append(SKTexture(imageNamed: "hard\(i)"));
//            }
//        }
//        var gifTextures3: [SKTexture] = [];
//        var play = SKSpriteNode()
//        play = childNode(withName: "playButton") as! SKSpriteNode
//        for i in 1...18 {
//            autoreleasepool{
//            gifTextures3.append(SKTexture(imageNamed: "play\(i)"));
//            }
//        }
//        costume.run(SKAction.repeatForever(SKAction.animate(with: gifTextures, timePerFrame: 0.125)));
//        play.run(SKAction.repeatForever(SKAction.animate(with: gifTextures3, timePerFrame: 0.125)));
//        hard.run(SKAction.repeatForever(SKAction.animate(with: gifTextures2, timePerFrame: 0.125)));
    }
    func gemLabels() {
        gemLabel = self.childNode(withName: "gemLabel") as? SKLabelNode ?? gemLabel
        gemLabel.color = UIColor.white
        gemLabel.text = ("Stars: \(totalGems)")
        
        gemLabel.fontSize = 22
        gemLabel.fontName = "CourierNewPS-BoldMT"

    }
    
    func playOrStopPlayer() {
        
        
        let sound = Bundle.main.path(forResource: "slowmotion", ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        let jack = audioPlayer
        
        if musicSound == "true" {
           
            jack?.numberOfLoops = -1
            jack?.play()
            UserDefaults.standard.set("isPlaying", forKey: "currentSoundKey");
            currentSound = UserDefaults.standard.string(forKey: "currentSoundKey")!
            
            
        }
        if musicSound == "false" {
            if currentSound == "isPlaying" {
            jack?.stop()

            UserDefaults.standard.set("notPlaying", forKey: "currentSoundKey");
            print("this is working")
            currentSound = UserDefaults.standard.string(forKey: "currentSoundKey")!
                
            }
            
        }
            
        
        
        
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            if touchedNode.name == "playButton"  {
//                self.removeAllActions()
                gameSpeed = 0.003
                let newScene = SKScene(fileNamed: "GameScene")
                newScene!.scaleMode = self.scaleMode
                let animation = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(newScene!, transition: animation)
                
            } else if touchedNode.name == "costumeButton" {
//                self.removeAllActions()
                let newScene = SKScene(fileNamed: "costumeScene")
                newScene!.scaleMode = self.scaleMode
                let animation = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(newScene!, transition: animation)
            }   else if touchedNode.name == "hardMode" {
                    gameSpeed = 0.0015
        //                self.removeAllActions()
                    let newScene = SKScene(fileNamed: "GameScene")
                    newScene!.scaleMode = self.scaleMode
                    let animation = SKTransition.fade(withDuration: 1.0)
                    self.view?.presentScene(newScene!, transition: animation)
                
            }   else if touchedNode.name == "on" {
                         if currentSound == "notPlaying" {
                                   UserDefaults.standard.set("true", forKey: "musicSoundKey");
                                   musicSound = UserDefaults.standard.string(forKey: "musicSoundKey") ?? "true"
                                   print(musicSound, "this is musicSoundKey")
                                   UserDefaults.standard.set("isPlaying", forKey: "currentSoundKey");
                                   playOrStopPlayer()
                               }}
                else if touchedNode.name == "off" {
                
                                 UserDefaults.standard.set("false", forKey: "musicSoundKey");
                        musicSound = UserDefaults.standard.string(forKey: "musicSoundKey") ?? "true"
                        print(musicSound, "this is musicSoundKey")
                        UserDefaults.standard.set("notPlaying", forKey: "currentSoundKey");
                        playOrStopPlayer()
                
            }
            
    }
    }
    

    
 
 

    
   
    
    


    
}
