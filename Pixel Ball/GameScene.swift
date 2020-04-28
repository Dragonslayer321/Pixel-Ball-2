//
//  GameScene.swift
//  Pixel Ball
//
//  Created by Adeel Din on 2019-09-03.
//  Copyright © 2019 Adeel Din. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVKit
import GameKit
import AVFoundation


var totalGems =  UserDefaults.standard.string(forKey: "gemSelectKey") ?? "0"
var totalRetry =  UserDefaults.standard.string(forKey: "retrySelectKey") ?? "0"
struct physicsCategory {
    static let player1 : UInt32 = 0x1 << 1
    static let ground1 : UInt32 = 0x1 << 2
    static let wall1 : UInt32 = 0x1 << 3
    static let missle1 : UInt32 = 0x1 << 4
    static let star1 : UInt32 = 0x1 << 5
    static let level : UInt32 = 0x1 << 6
    static let hat : UInt32 = 0x1 << 7
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    var player          = SKSpriteNode()
    var redButton       = SKSpriteNode()
    var blueButton      = SKSpriteNode()
    var greenButton     = SKSpriteNode()
    var yellowButton    = SKSpriteNode()
    var purpleButton    = SKSpriteNode()
    var ground          = SKSpriteNode()
    var wall1           = SKSpriteNode()
    var wall2           = SKSpriteNode()
    var misslePair      = SKNode()
    var levelPair       = SKNode()
    var wallPair        = SKNode()
    var starPair        = SKNode()
    var backPair        = SKNode()
    var backGroundNode  = SKSpriteNode()
    var ass1size : CGFloat = 0
    var ass2size : CGFloat = 0
    var miss1size : CGFloat = 0
    var miss2size : CGFloat = 0
    var star1size : CGFloat = 0
    var startLabel = SKLabelNode()
    var instructionLabel = SKLabelNode()
    var instructionLabel2 = SKLabelNode()
    var instructionLabel3 = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var levelLabel = SKLabelNode()
    var level2Label = SKLabelNode()
    var level3Label = SKLabelNode()
    var gemLabel = SKLabelNode()
    var costumeLabel = SKLabelNode()
    let atlas = SKTextureAtlas(named: "Background.atlas")
    
    var lives = 3
    var score = 0
    var level = 0
    var retry = 0
    
    
    var moveAndRemove = SKAction()
    var moveAndRemove2 = SKAction()
    var moveAndRemove3 = SKAction()
    var moveAndRemove4 = SKAction()

    
    var gameStarter = "false"
    
    var chosenColor = 0
    var currentPresses = 0
    let retryButton = SKLabelNode()
    let menuButton = SKLabelNode()
    let leaderBoardButton = SKLabelNode()
    let off = SKLabelNode()
    let on = SKLabelNode()
    
    let jump1 = SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false)
    let missileSound = SKAction.playSoundFileNamed("rocket.mp3", waitForCompletion: false)
    let deathSound = SKAction.playSoundFileNamed("death.mp3", waitForCompletion: false)
    let levelSound = SKAction.playSoundFileNamed("beep.mp3", waitForCompletion: false)
    
    var endCounter = 0
    
    var hat = SKSpriteNode()
    
    override func sceneDidLoad() {
        scaleMode = .resizeFill
        scaleMode = .fill
    }
    
    override func didMove(to view: SKView) {
//        GameViewController().button.isHidden = true
        createBackground()
        gameStarter = "false"
        self.physicsWorld.contactDelegate = self
        
        
        print("starting life", lives)
        createPlayer()
        createNodes()
        playerColor()
        costume()
        gemLabels()
        currentScore()
        gameScore()
        currentLevel()
        
        
        createLabel()

        
        ground = childNode(withName: "ground") as! SKSpriteNode
        
//        ground.alpha = 0.0
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = physicsCategory.ground1
        ground.physicsBody?.collisionBitMask = physicsCategory.player1
        ground.physicsBody?.contactTestBitMask = physicsCategory.player1
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        
    
        wall1.physicsBody = SKPhysicsBody(rectangleOf: wall1.size)
        wall1.physicsBody?.categoryBitMask = physicsCategory.ground1
        wall1.physicsBody?.collisionBitMask = physicsCategory.player1
        wall1.physicsBody?.contactTestBitMask = physicsCategory.player1
        wall1.physicsBody?.affectedByGravity = false
        wall1.physicsBody?.isDynamic = false
        
        wall2.physicsBody = SKPhysicsBody(rectangleOf: wall2.size)
        wall2.physicsBody?.categoryBitMask = physicsCategory.ground1
        wall2.physicsBody?.collisionBitMask = physicsCategory.player1
        wall2.physicsBody?.contactTestBitMask = physicsCategory.player1
        wall2.physicsBody?.affectedByGravity = false
        wall2.physicsBody?.isDynamic = false
        
        
      
        
    }
    func totalGem() {
        submit()
        var score1 = 0
        score1 = (Int(totalGems) ?? 0) + score
        UserDefaults.standard.set(score1, forKey: "gemSelectKey");
        
        totalGems = UserDefaults.standard.string(forKey: "gemSelectKey") ?? "0"
        
        gemLabels()
        
    }

    func gameScore(){
        level2Label = self.childNode(withName: "level2Label") as! SKLabelNode
        level3Label = self.childNode(withName: "level3Label") as! SKLabelNode
        updateScore()
    }
    func updateScore(){
        level2Label.text = (String(level))
        level3Label.text = (String(level))
    }
    func currentScore() {
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.color = UIColor.white
        scoreLabel.text = ("Score: \(score)")
        scoreLabel.fontSize = 22
        
        scoreLabel.fontName = "CourierNewPS-BoldMT"
        
        

    }
    func currentLevel() {
        levelLabel = self.childNode(withName: "levelLabel") as! SKLabelNode
        levelLabel.color = UIColor.white
        levelLabel.text = ("Level: \(level)")
        
        levelLabel.fontSize = 22
        levelLabel.fontName = "CourierNewPS-BoldMT"

    }
    func gemLabels() {
        gemLabel = self.childNode(withName: "gemLabel") as! SKLabelNode
        gemLabel.color = UIColor.white
        gemLabel.text = ("Star: \(totalGems)")
        
        gemLabel.fontSize = 22
        gemLabel.fontName = "CourierNewPS-BoldMT"

    }
    func delayedStart() {
        gameStarter = "trueNow"
    }
    
    func asteroid1() {
        var num1 = 0
        num1 = Int.random(in: 0 ... 600)
        ass1size = CGFloat(num1)
    }
    
    func asteroid2() {
        var num1 = 0
        num1 = Int.random(in: -360 ... 0)
        ass2size = CGFloat(num1)

    }
    func missleLocatoin() {
        var num1 = 0
        var num2 = 0
        num1 = Int.random(in: 0 ... 600)
        num2 = Int.random(in: -360 ... 0)
        miss1size = CGFloat(num1)
        miss2size = CGFloat(num2)
    }
    func starLocatoin() {
        var num1 = 0

        num1 = Int.random(in: 0 ... 600)

        star1size = CGFloat(num1)
       
    }

    func costume()  {
        if costumeSelect == "player1" {
                let size = CGSize(width: 50, height: 50)
                hat.size = size
                hat.texture = SKTexture(imageNamed: "player1")
                hat.position = CGPoint(x: player.position.x, y: player.position.y + 35)
                hat.physicsBody = SKPhysicsBody(circleOfRadius: hat.frame.height / 2)
                hat.physicsBody?.categoryBitMask = physicsCategory.hat
                hat.physicsBody?.affectedByGravity = true
                hat.physicsBody?.mass = 0.000000001

                let pinJoint = SKPhysicsJointPin.joint(withBodyA: player.physicsBody!,
                                                        bodyB: hat.physicsBody!,
                                                        anchor: CGPoint(x: 0.0, y: 0.0))
                self.scene?.addChild(hat)
                scene!.physicsWorld.add(pinJoint)
        } else if costumeSelect == "player2" {
                let size = CGSize(width: 40, height: 40)
                hat.size = size
                hat.texture = SKTexture(imageNamed: "player2")
                hat.position = CGPoint(x: player.position.x, y: player.position.y + 40)
                hat.physicsBody = SKPhysicsBody(circleOfRadius: hat.frame.height / 2)
                hat.physicsBody?.categoryBitMask = physicsCategory.hat
                hat.physicsBody?.affectedByGravity = true
                hat.physicsBody?.mass = 0.000000001

                let pinJoint = SKPhysicsJointPin.joint(withBodyA: player.physicsBody!,
                                                        bodyB: hat.physicsBody!,
                                                        anchor: CGPoint(x: 0.0, y: 0.0))
                self.scene?.addChild(hat)
                scene!.physicsWorld.add(pinJoint)
        } else if costumeSelect == "player3" {
                let size = CGSize(width: 50, height: 50)
                hat.size = size
                hat.texture = SKTexture(imageNamed: "player3")
                hat.position = CGPoint(x: player.position.x + 10, y: player.position.y + 33)
                hat.physicsBody = SKPhysicsBody(circleOfRadius: hat.frame.height / 2)
                hat.physicsBody?.categoryBitMask = physicsCategory.hat
                hat.physicsBody?.affectedByGravity = true
                hat.physicsBody?.mass = 0.000000001

                let pinJoint = SKPhysicsJointPin.joint(withBodyA: player.physicsBody!,
                                                        bodyB: hat.physicsBody!,
                                                        anchor: CGPoint(x: 0.0, y: 0.0))
                self.scene?.addChild(hat)
                scene!.physicsWorld.add(pinJoint)
        } else if costumeSelect == "player4" {
                let size = CGSize(width: 60, height: 60)
                hat.size = size
                hat.texture = SKTexture(imageNamed: "player4")
                hat.position = CGPoint(x: player.position.x - 60, y: player.position.y - 5)
                hat.physicsBody = SKPhysicsBody(circleOfRadius: hat.frame.height / 2)
                hat.physicsBody?.categoryBitMask = physicsCategory.hat
                hat.physicsBody?.affectedByGravity = true
                hat.physicsBody?.mass = 0.000000001

                let pinJoint = SKPhysicsJointPin.joint(withBodyA: player.physicsBody!,
                                                        bodyB: hat.physicsBody!,
                                                        anchor: CGPoint(x: 0.0, y: 0.0))
                self.scene?.addChild(hat)
                scene!.physicsWorld.add(pinJoint)
        } else if costumeSelect == "player5" {
                let size = CGSize(width: 60, height: 60)
                hat.size = size
                hat.texture = SKTexture(imageNamed: "player5")
                hat.position = CGPoint(x: player.position.x - 60, y: player.position.y - 5)
                hat.physicsBody = SKPhysicsBody(circleOfRadius: hat.frame.height / 2)
                hat.physicsBody?.categoryBitMask = physicsCategory.hat
                hat.physicsBody?.affectedByGravity = true
                hat.physicsBody?.mass = 0.000000001

                let pinJoint = SKPhysicsJointPin.joint(withBodyA: player.physicsBody!,
                                                        bodyB: hat.physicsBody!,
                                                        anchor: CGPoint(x: 0.0, y: 0.0))
                self.scene?.addChild(hat)
                scene!.physicsWorld.add(pinJoint)
        }
//        let nodeSize = CGSize(width: 10, height: 10)
//        let node = SKSpriteNode(color: .red, size: nodeSize)
//        node.physicsBody = SKPhysicsBody(rectangleOf: nodeSize)
//        node.physicsBody?.isDynamic = false
//        self.addChild(node)
//
//        let node2Size = CGSize(width: 60, height: 8)
//        let node2 = SKSpriteNode(color: .green, size: node2Size)
//        node2.position = CGPoint(x: 60, y: 0)
//        node2.physicsBody = SKPhysicsBody(rectangleOf: node2Size)
//        node2.physicsBody?.mass = 1.0
//        self.addChild(node2)
//
//
//        let a = SKPhysicsJointPin.joint(withBodyA: node.physicsBody! , bodyB: node2.physicsBody!, anchor: CGPoint(x: 0.0, y: 200.0))
//        self.physicsWorld.add(a)
    }

    
    func createNodes() {
        
        player = childNode(withName: "player") as? SKSpriteNode ?? player
        wall1 = childNode(withName: "wall1") as? SKSpriteNode ?? wall1
        wall2 = childNode(withName: "wall2") as? SKSpriteNode ?? wall2
       
        playerPhsyics()
        redButton = childNode(withName: "redButton") as? SKSpriteNode ?? redButton
        blueButton = childNode(withName: "blueButton") as? SKSpriteNode ?? blueButton
        greenButton = childNode(withName: "greenButton") as? SKSpriteNode ?? greenButton
        yellowButton = childNode(withName: "yellowButton") as? SKSpriteNode ?? yellowButton
        purpleButton = childNode(withName: "purpleButton") as? SKSpriteNode ?? purpleButton
        
    }
    func playerPhsyics(){
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.frame.height / 2)
               player.physicsBody?.allowsRotation = false
               player.physicsBody?.affectedByGravity = false

               player.physicsBody?.categoryBitMask = physicsCategory.player1
               player.physicsBody?.collisionBitMask = physicsCategory.ground1 | physicsCategory.wall1 | physicsCategory.missle1 | physicsCategory.wall1
               player.physicsBody?.contactTestBitMask = physicsCategory.ground1 | physicsCategory.wall1 | physicsCategory.missle1 | physicsCategory.wall1
               
    }
    func createStar() {
        starPair = SKNode()
        let topWall = SKSpriteNode()
        
        topWall.size = CGSize(width: 50, height: 50)
        topWall.texture = SKTexture(imageNamed: "star")
        topWall.position = CGPoint(x: self.frame.width / 2, y: star1size)
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = physicsCategory.star1
        topWall.physicsBody?.collisionBitMask = physicsCategory.player1
        topWall.physicsBody?.contactTestBitMask = physicsCategory.player1
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        topWall.setScale(0.5)
         
        starPair.addChild(topWall)
        starPair.run(moveAndRemove3)
        self.addChild(starPair)
        
    }
    override func update(_ currentTime: TimeInterval) {
        scrollBackground()
    }
    
    func createBackground() {
   
            let sky = childNode(withName: "backgroundNode") as! SKSpriteNode
            sky.texture = SKTexture.init(imageNamed: "longBackground")
            sky.name = "clouds"
            sky.size = CGSize(width: (7500), height: (1334))
            sky.position = CGPoint(x: 3370 , y: (0))
            

        
    }
    
    func scrollBackground(){
        self.enumerateChildNodes(withName: "clouds", using: ({
            (node, error) in

            node.position.x -= 2
//            print("node position x = \(node.position.x)")

            if node.position.x < -(3370) {
                node.position.x = (3370)
            }
         }))
    }
    func createPlayer() {
//        if player.isHidden == true {
//
//            player.size = CGSize(width: 80, height: 80)
//            player.texture = SKTexture(imageNamed: "blue")
//            player.position = CGPoint(x: -4.274, y: 113.943)
//            player.zPosition = 1
//            self.addChild(player)
//            playerColor()
//        }
        
    }
    func endCountDown(){
        if endCounter >= 3 {
            endProcedures()
        }
    }
    
    func createWall() {
        asteroid1()
        asteroid2()
        wallPair = SKNode()
        
        let topWall = SKSpriteNode()
        let btmWall = SKSpriteNode()
        
        topWall.size = CGSize(width: 450, height: 500)
        btmWall.size = CGSize(width: 450, height: 500)
        
        topWall.texture = SKTexture(imageNamed: "asteroid")
        btmWall.texture = SKTexture(imageNamed: "asteroid")
        
        topWall.position = CGPoint(x: self.frame.width / 2, y: ass1size)
        btmWall.position = CGPoint(x: self.frame.width / 2, y: ass2size)
       
       
        topWall.physicsBody = SKPhysicsBody(circleOfRadius: topWall.frame.height / 2.5)
        topWall.physicsBody?.categoryBitMask = physicsCategory.wall1
        topWall.physicsBody?.collisionBitMask = physicsCategory.player1
        topWall.physicsBody?.contactTestBitMask = physicsCategory.player1
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        btmWall.physicsBody = SKPhysicsBody(circleOfRadius: btmWall.frame.height / 2.5)
        btmWall.physicsBody?.categoryBitMask = physicsCategory.wall1
        btmWall.physicsBody?.collisionBitMask = physicsCategory.player1
        btmWall.physicsBody?.contactTestBitMask = physicsCategory.player1
        btmWall.physicsBody?.isDynamic = false
        btmWall.physicsBody?.affectedByGravity = false
       
        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        wallPair.addChild(topWall)
        wallPair.addChild(btmWall)
        wallPair.run(moveAndRemove)
        self.addChild(wallPair)
        
        
        
    }
    
    func createMissle() {

        misslePair = SKNode()
        
        
        
        let topWall2 = SKSpriteNode()
        let btmWall2 = SKSpriteNode()
        
        var gifTextures: [SKTexture] = [];
        
        for i in 1...7 {
            autoreleasepool{
            gifTextures.append(SKTexture(imageNamed: "missile\(i)"));
            }
        }
        
        topWall2.run(SKAction.repeatForever(SKAction.animate(with: gifTextures, timePerFrame: 0.125)));
        btmWall2.run(SKAction.repeatForever(SKAction.animate(with: gifTextures, timePerFrame: 0.125)));
        
        
        topWall2.size = CGSize(width: 100, height: 100)
        btmWall2.size = CGSize(width: 100, height: 100)
        
//        topWall2.color = UIColor.red
//        btmWall2.color = UIColor.red
//        topWall2.texture = SKTexture(imageNamed: "missile")
//        btmWall2.texture = SKTexture(imageNamed: "missile")
        
        topWall2.position = CGPoint(x: self.frame.width / 2, y: miss1size)
        btmWall2.position = CGPoint(x: self.frame.width / 2, y: miss2size)
        
        topWall2.physicsBody = SKPhysicsBody(circleOfRadius: topWall2.frame.height / 2)
        topWall2.physicsBody?.categoryBitMask = physicsCategory.missle1
        topWall2.physicsBody?.collisionBitMask = physicsCategory.player1
        topWall2.physicsBody?.contactTestBitMask = physicsCategory.player1
        topWall2.physicsBody?.isDynamic = false
        topWall2.physicsBody?.affectedByGravity = false
        
        btmWall2.physicsBody = SKPhysicsBody(circleOfRadius: btmWall2.frame.height / 2)
        btmWall2.physicsBody?.categoryBitMask = physicsCategory.missle1
        btmWall2.physicsBody?.collisionBitMask = physicsCategory.player1
        btmWall2.physicsBody?.contactTestBitMask = physicsCategory.player1
        btmWall2.physicsBody?.isDynamic = false
        btmWall2.physicsBody?.affectedByGravity = false
        
        topWall2.setScale(0.5)
        btmWall2.setScale(0.5)
        
        misslePair.addChild(topWall2)
        misslePair.addChild(btmWall2)
        misslePair.run(moveAndRemove2)
        self.addChild(misslePair)
        if sfxSound == "true" {
            run(missileSound)
        }
        
        
    }
    func createLevel() {

        levelPair = SKNode()
        let topWall2 = SKSpriteNode()
        let size = CGSize(width: 50, height: 2500)
        topWall2.size = size
        topWall2.texture = SKTexture.init(imageNamed: "level")
        topWall2.alpha = 0.25
        topWall2.position = CGPoint(x: self.frame.width / 2, y: 185)
        
        topWall2.physicsBody = SKPhysicsBody(rectangleOf: size)
        topWall2.physicsBody?.categoryBitMask = physicsCategory.level
        topWall2.physicsBody?.collisionBitMask = physicsCategory.player1
        topWall2.physicsBody?.contactTestBitMask = physicsCategory.player1
        topWall2.physicsBody?.isDynamic = false
        topWall2.physicsBody?.affectedByGravity = false
        
        
        topWall2.setScale(0.5)

        
        levelPair.addChild(topWall2)
        levelPair.run(moveAndRemove4)
        self.addChild(levelPair)
        
        
        
    }
    
    func startStars() {
        let spawn3 = SKAction.run({
            ()in
            self.starLocatoin()
            self.createStar()
            
        })
        let delay3 = SKAction.wait(forDuration: 3.5)
        
        let spawnDelay3 = SKAction.sequence([spawn3, delay3])
        
        let spawnDelayForever3 = SKAction.repeatForever(spawnDelay3)
        
        self.run(spawnDelayForever3)
        
        let distance3 = CGFloat(frame.width + starPair.frame.width)
        
        let movePipes3 = SKAction.moveBy(x: -distance3, y: 0, duration:  TimeInterval( 0.005 * distance3))
        let removePipes3 = SKAction.removeFromParent()
        
        
        moveAndRemove3 = SKAction.sequence([movePipes3, removePipes3])
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarter == "false" {
            backGround()
            gameStarter = "true"
            player.physicsBody?.affectedByGravity = true
            let spawn = SKAction.run({
                ()in
//                self.asteroid1()
//                self.asteroid2()
                self.createWall()
                self.startGameProcedures()
                
            })
            let delay = SKAction.wait(forDuration: 1.5)
            let spawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)

            let distance = CGFloat(frame.width + wallPair.frame.width)
            let movePipes = SKAction.moveBy(x: -distance, y: 0, duration:  TimeInterval(CGFloat(gameSpeed) * distance))
            let removePipes = SKAction.removeFromParent()

            moveAndRemove = SKAction.sequence([movePipes, removePipes])
            
            let spawn3 = SKAction.run({
                ()in
                self.delayedStart()
                print("delayedStart done")
            })
            let delay3 = SKAction.wait(forDuration: 10)
            
            let spawnDelay3 = SKAction.sequence([delay3, spawn3])
            
            self.run(spawnDelay3)
            startStars()
            
            let spawn2 = SKAction.run({
                ()in
                self.missleLocatoin()
                self.createMissle()
            })
            let delay2 = SKAction.wait(forDuration: 10.0)
            
            let spawnDelay2 = SKAction.sequence([delay2, spawn2])
            
            let spawnDelayForever2 = SKAction.repeatForever(spawnDelay2)
            
            self.run(spawnDelayForever2)
            
            let distance2 = CGFloat(frame.width + misslePair.frame.width)
            let movePipes2 = SKAction.moveBy(x: -distance2, y: 0, duration:  TimeInterval( 0.002 * distance2))
            let removePipes2 = SKAction.removeFromParent()
            
            moveAndRemove2 = SKAction.sequence([movePipes2, removePipes2])
            
            let spawn4 = SKAction.run({
                ()in
                self.createLevel()
            })
            let delay4 = SKAction.wait(forDuration: 5.0)
            
            let spawnDelay4 = SKAction.sequence([delay4, spawn4])
            
            let spawnDelayForever4 = SKAction.repeatForever(spawnDelay4)
            
            self.run(spawnDelayForever4)
            
            let distance4 = CGFloat(frame.width + misslePair.frame.width)
            let movePipes4 = SKAction.moveBy(x: -distance4, y: 0, duration:  TimeInterval( 0.003 * distance4))
            let removePipes4 = SKAction.removeFromParent()
            
            moveAndRemove4 = SKAction.sequence([movePipes4, removePipes4])
            
            
        }

        
        let jump = CGVector.init(dx: 0, dy: 150)
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            
            
            if touchedNode.name == "redButton" && chosenColor == 2 {

                if sfxSound == "true" {
                    run(jump1)
                }
                
                player.physicsBody?.applyImpulse(jump)
                
                print("red button touched")
                endCountDown()
                currentPresses = currentPresses + 1
                if currentPresses >= 10 {
                    playerColor()
                    currentPresses = 0
                }
        
                
            } else if touchedNode.name == "greenButton" && chosenColor == 3 {
                if sfxSound == "true" {
                    run(jump1)
                }
                player.physicsBody?.applyImpulse(jump)
                
                print("green button touched")
                endCountDown()
                currentPresses = currentPresses + 1
                if currentPresses >= 10 {
                    playerColor()
                    currentPresses = 0
                }
           
                
            } else if touchedNode.name == "blueButton" && chosenColor == 1 {
                if sfxSound == "true" {
                    run(jump1)
                }
                player.physicsBody?.applyImpulse(jump)
                
                print("blue button touched")
                endCountDown()
                currentPresses = currentPresses + 1
                if currentPresses >= 10 {
                    playerColor()
                    currentPresses = 0
                }
                
                
                
            } else if touchedNode.name == "purpleButton" && chosenColor == 4 {
                if sfxSound == "true" {
                    run(jump1)
                }
                player.physicsBody?.applyImpulse(jump)
                
                print("purple button touched")
                endCountDown()
                currentPresses = currentPresses + 1
                if currentPresses >= 10 {
                    playerColor()
                    currentPresses = 0
                }
        
                
            } else if touchedNode.name == "yellowButton" && chosenColor == 5 {
                if sfxSound == "true" {
                    run(jump1)
                }
                player.physicsBody?.applyImpulse(jump)
                
                print("yellow button touched")
                endCountDown()
                currentPresses = currentPresses + 1
                if currentPresses >= 10 {
                    playerColor()
                    currentPresses = 0
                }
                
                
            } else if touchedNode == retryButton {
                retry = (Int(totalRetry) ?? 0) + 1
                UserDefaults.standard.set(retry, forKey: "retrySelectKey");
                
                totalRetry = UserDefaults.standard.string(forKey: "retrySelectKey") ?? "0"
                if retry >= 5 {
                    retry = 0
                    UserDefaults.standard.set(retry, forKey: "retrySelectKey");
                    
                    totalRetry = UserDefaults.standard.string(forKey: "retrySelectKey") ?? "0"
   
                    NotificationCenter.default.post(name: Notification.Name("FIRENOTIFICATION"), object: nil, userInfo: nil)
                }
                self.removeAllChildren()
                let gameScene = SKScene(fileNamed: "GameScene")
                self.view?.presentScene(gameScene)
                
            } else if touchedNode == menuButton {
                self.removeAllChildren()
                self.removeAllActions()
                let newScene = SKScene(fileNamed: "menu")
                newScene!.scaleMode = self.scaleMode
                let animation = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(newScene!, transition: animation)
                
            } else if touchedNode == leaderBoardButton {
                

                
            }
            else if touchedNode == on {
                
                let color1 = SKAction.run {
                    self.on.fontColor = .blue
                }
                let color2 = SKAction.run{
                    self.on.fontColor = .white
                }
                let delay = SKAction.wait(forDuration: 0.15)
                let colorSequence = SKAction.sequence([color1, delay, color2])
                run(colorSequence)

                UserDefaults.standard.set("true", forKey: "sfxSoundKey");
                sfxSound = UserDefaults.standard.string(forKey: "sfxSoundKey") ?? "true"
                
                
            }
            else if touchedNode == off {
                let color1 = SKAction.run {
                    self.off.fontColor = .blue
                }
                let color2 = SKAction.run{
                    self.off.fontColor = .white
                }
                let delay = SKAction.wait(forDuration: 0.15)
                let colorSequence = SKAction.sequence([color1, delay, color2])
                run(colorSequence)
                
                UserDefaults.standard.set("false", forKey: "sfxSoundKey");
                sfxSound = UserDefaults.standard.string(forKey: "sfxSoundKey") ?? "true"
 
                
            }
        }
    }
    func setRetryToOne(){
        retry = 1
        UserDefaults.standard.set(retry, forKey: "retrySelectKey");
        
        totalRetry = UserDefaults.standard.string(forKey: "retrySelectKey") ?? "0"
    }
    
    func createLabel() {
        startLabel.text = "TAP TO START"
        startLabel.fontSize = 82
        startLabel.color = UIColor.white
        startLabel.fontName = "CourierNewPS-BoldMT"
        startLabel.position = CGPoint(x: 0, y: 0)
        self.scene?.addChild(startLabel)
        

        instructionLabel.text = "TAP SAME COLOR TO FLY"
        instructionLabel.fontSize = 25
        instructionLabel.color = UIColor.white
        instructionLabel.fontName = "CourierNewPS-BoldMT"
        instructionLabel.position = CGPoint(x: 0, y: -50)
        self.scene?.addChild(instructionLabel)
        

        instructionLabel2.text = "COLLECT STARS TO UNLOCK ACCESSORIES"
        instructionLabel2.fontSize = 25
        instructionLabel2.color = UIColor.white
        instructionLabel2.fontName = "CourierNewPS-BoldMT"
        instructionLabel2.position = CGPoint(x: 0, y: -100)
        self.scene?.addChild(instructionLabel2)
        
        
        instructionLabel3.text = "SHARE YOUR HIGHSCORE!"
        instructionLabel3.lineBreakMode = NSLineBreakMode.byWordWrapping
        instructionLabel3.preferredMaxLayoutWidth = 600
        instructionLabel3.numberOfLines = 3
        instructionLabel3.fontSize = 25
        instructionLabel3.color = UIColor.white
        instructionLabel3.fontName = "CourierNewPS-BoldMT"
        instructionLabel3.position = CGPoint(x: 0, y: -180)
        self.scene?.addChild(instructionLabel3)
        
        
    }

    
    func startGameProcedures() {
        startLabel.removeFromParent()
        instructionLabel3.removeFromParent()
        instructionLabel2.removeFromParent()
        instructionLabel.removeFromParent()
    }
    func endProcedures() {
        submit()
        totalGem()
        player.removeFromParent()
        redButton.removeFromParent()
        blueButton.removeFromParent()
        greenButton.removeFromParent()
        yellowButton.removeFromParent()
        purpleButton.removeFromParent()
        removeAllActions()
        endCounter = 0
        noLives()
    }
    
    func playerColor() {
        let number = Int.random(in: 1 ... 5)
        print(number)
        
        if number == 1 {
            player.texture = SKTexture(imageNamed: "blue")
            chosenColor = 1
            
        } else if number == 2 {
            player.texture = SKTexture(imageNamed: "red")
            chosenColor = 2
            
        } else if number == 3 {
            player.texture = SKTexture(imageNamed: "green")
            chosenColor = 3
            
        } else if number == 4 {
            player.texture = SKTexture(imageNamed: "purple")
            chosenColor = 4
            
        } else if number == 5 {
            player.texture = SKTexture(imageNamed: "yellow")
            chosenColor = 5
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
  
                //VARIABLES AND SHIT
                var firstBody: SKPhysicsBody
                var secondBody: SKPhysicsBody
        
                //SETTING UP THE CHECKING SHIT
                if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                    firstBody = contact.bodyA
                    secondBody = contact.bodyB
                } else {
                    firstBody = contact.bodyB
                    secondBody = contact.bodyA
                }
    
        
                if firstBody.categoryBitMask == physicsCategory.player1 &&
                    secondBody.categoryBitMask == physicsCategory.missle1 || firstBody.categoryBitMask == physicsCategory.missle1 && secondBody.categoryBitMask == physicsCategory.player1 {
                    removeAllActions()
                    endProcedures()
                    print("contact made")
                }
        if firstBody.categoryBitMask == physicsCategory.player1 &&
            secondBody.categoryBitMask == physicsCategory.ground1 || firstBody.categoryBitMask == physicsCategory.ground1 && secondBody.categoryBitMask == physicsCategory.player1 {
            print("death made")
            endProcedures()
            if sfxSound == "true" {
                run(deathSound)
            }
        }
        if firstBody.categoryBitMask == physicsCategory.player1 &&
            secondBody.categoryBitMask == physicsCategory.star1 || firstBody.categoryBitMask == physicsCategory.star1 && secondBody.categoryBitMask == physicsCategory.player1 {
            print("1 point made")
            starPair.removeFromParent()
            score = score + 1
            currentScore()
        }
        if firstBody.categoryBitMask == physicsCategory.player1 &&
            secondBody.categoryBitMask == physicsCategory.level || firstBody.categoryBitMask == physicsCategory.level && secondBody.categoryBitMask == physicsCategory.player1 {
            print("1 level completed")
            if sfxSound == "true" {
                run(levelSound)
            }
            level = level + 1
            currentLevel()
            updateScore()
        }
        if firstBody.categoryBitMask == physicsCategory.player1 &&
            secondBody.categoryBitMask == physicsCategory.wall1 || firstBody.categoryBitMask == physicsCategory.wall1 && secondBody.categoryBitMask == physicsCategory.player1 {
            endCounter = endCounter + 1
            lives = lives - 1
            removeHearts()
            colorChange()
            if endCounter == 3 {
                endProcedures()
                if sfxSound == "true" {
                    run(deathSound)
                }
            }
            
            
        }
   
    }
    func noLives(){
        if lives == 0 {
            
            
            let noLives = SKLabelNode()
            noLives.text = "No Lives"
            noLives.fontSize = 82
            noLives.fontName = "CourierNewPS-BoldMT"
            noLives.position = CGPoint(x: 0, y: 300)
            self.scene?.addChild(noLives)
            
            retryButton.text = "Retry"
            retryButton.fontSize = 82
            retryButton.fontName = "CourierNewPS-BoldMT"
            retryButton.position = CGPoint(x: 0, y: -20)
            self.scene?.addChild(retryButton)
            
            menuButton.text = "Menu"
            menuButton.fontSize = 82
            menuButton.fontName = "CourierNewPS-BoldMT"
            menuButton.position = CGPoint(x: 0, y: -120)
            self.scene?.addChild(menuButton)
            
            leaderBoardButton.text = "LeaderBoard"
            leaderBoardButton.fontSize = 52
            leaderBoardButton.fontName = "CourierNewPS-BoldMT"
            leaderBoardButton.position = CGPoint(x: 0, y: +550)
            self.scene?.addChild(leaderBoardButton)
            
            level2Label.position = CGPoint(x: 0, y: 395)
            level3Label.position = CGPoint(x: 0, y: 400)
            
            let totalScore = SKLabelNode()
            totalScore.text = "Stars: \(score)"
            totalScore.fontSize = 82
            totalScore.fontName = "CourierNewPS-BoldMT"
            totalScore.position = CGPoint(x: 0, y: 100)
            self.scene?.addChild(totalScore)
            
            
             on.text = "SFX ON"
             on.fontSize = 52
             on.fontName = "CourierNewPS-BoldMT"
             on.position = CGPoint(x: 0, y: -220)
             self.scene?.addChild(on)
             
             
             off.text = "SFX OFF"
             off.fontSize = 52
             off.fontName = "CourierNewPS-BoldMT"
             off.position = CGPoint(x: 0, y: -320)
             self.scene?.addChild(off)
            
            let zapsplat = SKLabelNode()
            zapsplat.text = "Sound effects obtained"
            zapsplat.fontSize = 32
            zapsplat.fontName = "CourierNewPS-BoldMT"
            zapsplat.position = CGPoint(x: 0, y: -550)
            self.scene?.addChild(zapsplat)
            
            let zapsplat2 = SKLabelNode()
            zapsplat2.text = "from https://www.zapsplat.com"
            zapsplat2.fontSize = 32
            zapsplat2.fontName = "CourierNewPS-BoldMT"
            zapsplat2.position = CGPoint(x: 0, y: -600)
            self.scene?.addChild(zapsplat2)
            
        } else {
            
            
            let noLives = SKLabelNode()
            noLives.text = "You Died"
            noLives.fontSize = 82
            noLives.fontName = "CourierNewPS-BoldMT"
            noLives.position = CGPoint(x: 0, y: 300)
            self.scene?.addChild(noLives)
            
            retryButton.text = "Retry"
            retryButton.fontSize = 82
            retryButton.fontName = "CourierNewPS-BoldMT"
            retryButton.position = CGPoint(x: 0, y: -20)
            self.scene?.addChild(retryButton)
            
            menuButton.text = "Menu"
            menuButton.fontSize = 82
            menuButton.fontName = "CourierNewPS-BoldMT"
            menuButton.position = CGPoint(x: 0, y: -120)
            self.scene?.addChild(menuButton)
            
            level2Label.position = CGPoint(x: 0, y: 395)
            level3Label.position = CGPoint(x: 0, y: 400)
            
            leaderBoardButton.text = "LeaderBoard"
            leaderBoardButton.fontSize = 52
            leaderBoardButton.fontName = "CourierNewPS-BoldMT"
            leaderBoardButton.position = CGPoint(x: 0, y: +550)
            self.scene?.addChild(leaderBoardButton)
            
            let totalScore = SKLabelNode()
            totalScore.text = "Stars: \(score)"
            totalScore.fontSize = 82
            totalScore.fontName = "CourierNewPS-BoldMT"
            totalScore.position = CGPoint(x: 0, y: 150)

            self.scene?.addChild(totalScore)

            on.text = "SFX ON"
            on.fontSize = 52
            on.fontName = "CourierNewPS-BoldMT"
            on.position = CGPoint(x: 0, y: -220)
            self.scene?.addChild(on)
            
            
            off.text = "SFX OFF"
            off.fontSize = 52
            off.fontName = "CourierNewPS-BoldMT"
            off.position = CGPoint(x: 0, y: -320)
            self.scene?.addChild(off)
            
            let zapsplat = SKLabelNode()
            zapsplat.text = "Sound effects obtained"
            zapsplat.fontSize = 32
            zapsplat.fontName = "CourierNewPS-BoldMT"
            zapsplat.position = CGPoint(x: 0, y: -550)
            self.scene?.addChild(zapsplat)
            
            let zapsplat2 = SKLabelNode()
            zapsplat2.text = "from https://www.zapsplat.com"
            zapsplat2.fontSize = 32
            zapsplat2.fontName = "CourierNewPS-BoldMT"
            zapsplat2.position = CGPoint(x: 0, y: -600)
            self.scene?.addChild(zapsplat2)
            
            
            
        }
        
            
        
    }
    func submit(){
        let highscore = GKScore(leaderboardIdentifier: "com.adeeldin.Pixel-Ball.Scores")
        highscore.value = Int64(level)
        GKScore.report([highscore]) { error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("done")
        }
    }
    func removeHearts() {
        
        if lives == 2 {
            let heart3 = childNode(withName: "heart3") as! SKSpriteNode
            heart3.removeFromParent()
        } else if lives == 1 {
            let heart2 = childNode(withName: "heart2") as! SKSpriteNode
            heart2.removeFromParent()
        } else if lives == 0 {
            let heart1 = childNode(withName: "heart1") as! SKSpriteNode
            heart1.removeFromParent()
        }
    }
//    func loopVideo(videoPlayer: AVPlayer) {
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
//            videoPlayer.seek(to: CMTime.zero)
//            videoPlayer.play()
//        }
//    }

    func backGround(){
//        let background = childNode(withName: "backgroundNode")
//        background?.removeFromParent()
//        var player1 = AVPlayer()
//        var videoNode = SKVideoNode()
//        if let urlStr = Bundle.main.path(forResource: "Untitled", ofType: ".mp4")
//        {
//            let url = NSURL(fileURLWithPath: urlStr)
//            print(url)
//            player1 = AVPlayer(url: url as URL)
//
//            videoNode = SKVideoNode(avPlayer: player1)
//            videoNode.position = CGPoint(x: 1, y: 1)
//            videoNode.size = CGSize(width: self.size.width, height: self.size.height)
//            videoNode.zPosition = -2
//            addChild(videoNode)
//
//            videoNode.play()
////            loopVideo(videoPlayer: player1)
//        }
      

//        backGroundNode = childNode(withName: "backgroundNode") as! SKSpriteNode
//        var gifTextures: [SKTexture] = [];
//
//
//
//        for i in 1...1817 {
//            autoreleasepool{
//                gifTextures.append(SKTexture(imageNamed: "back\(i)"))
//                }
//
//        }
////        for i in 100...200 {
////            autoreleasepool{
////                gifTextures2.append(SKTexture(imageNamed: "back\(i)"));
////
////            }
////
////            }
////
//        backGroundNode.run(SKAction.repeatForever(SKAction.animate(with: gifTextures, timePerFrame: 0.09)))
        //let sample = Bundle.main.path(forResource: "Untitled.mp4", ofType: "mp4") != nil
//        let sample = SKVideoNode(fileNamed: "Untitled.mp4")
//        sample.position = CGPoint(x: -4,
//                                  y: 113)
//        sample.size = CGSize(width: 1, height: 1)
//        sample.zPosition = 1
//        self.scene?.addChild(sample)
//
//        sample.play()
      

        

          //  backGroundNode.run(SKAction.animate(with: gifTextures, timePerFrame: 0.09));

//        let sample = SKVideoNode(fileNamed: "AppPreview.mov")
//        sample.position = CGPoint(x: frame.midX,
//                                  y: frame.midY)
//        sample.zPosition = 10
//        addChild(sample)
//        sample.play()
    }
//    func swipedSound() {
//        if sfxSound == "true" {
//            let sound2 = Bundle.main.path(forResource: "jump", ofType: "wav")
//            do {
//                swipeSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
//                swipeSound.play()
//            } catch {
//                print(error)
//            }
//            
//            
//        }
//    }
//    func rocketSound() {
//        if sfxSound == "true" {
//            let sound3 = Bundle.main.path(forResource: "rocket", ofType: "mp3")
//            do {
//                missileSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound3!))
//                
//            } catch {
//                print(error)
//            }
//            missileSound.play()
//            
//        }
//    }
//    func deathSounds() {
//        if sfxSound == "true" {
//            let sound3 = Bundle.main.path(forResource: "death", ofType: "mp3")
//            do {
//                deathSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound3!))
//                
//            } catch {
//                print(error)
//            }
//            deathSound.play()
//            
//        }
//    }
    
    func colorChange(){
        player.physicsBody?.isDynamic = false
        player.physicsBody = nil
        
    
        
        
        let action2 = SKAction.wait(forDuration: 1.5)
        let action7 = SKAction.wait(forDuration: 0.3)
        let action5 = SKAction.run {
            self.player.texture = SKTexture(imageNamed: "red")

        }
        let action6 = SKAction.run {
            self.player.texture = SKTexture(imageNamed: "blue")

        }
        let sequence2 = SKAction.sequence([action5, action7, action6, action7, action5, action7, action6, action7])

        let group = SKAction.group([sequence2, action2])
        
        let action3 = SKAction.run {
            
        }
        let action4 = SKAction.run {
            print("current life left", self.lives)
            self.playerColor()
            self.playerPhsyics()
            self.player.physicsBody?.affectedByGravity = true
            self.player.physicsBody?.isDynamic = true
        }
        

        let sequence = SKAction.sequence([ group, action3, action4 ])
                   
        run(sequence)
    
    }
    
    


    
}
