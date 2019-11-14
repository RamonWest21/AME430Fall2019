//
//  Flappy.swift
//  FlappyBird
//
//  Created by Loren Olson on 11/8/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation



var randomSource = GKLinearCongruentialRandomSource.sharedRandom()


class Flappy: SKScene, SKPhysicsContactDelegate {
    
    var controller: ViewController!
    var contentCreated = false
    var points = 0
    let scoreSound = SKAction.playSoundFileNamed("smw_coin.wav", waitForCompletion: false)
    var endAudioPlayer: AVAudioPlayer? = nil
    
    
    // we needed endAudioPlayer to be an AVAudioPlayer, instead of an SKAction
    // because we will pause the scene when flappy runs into anything. When the
    // scene is paused, actions are paused, so we can't run the action to play
    // audio. Instead, its easy to just use AVAudioPlayer to play the sound.
    func loadAudio() {
        let path = Bundle.main.path(forResource: "smw_lost_a_life", ofType: "wav")
        let audioURL = URL(fileURLWithPath: path!)
        do {
            endAudioPlayer = try AVAudioPlayer(contentsOf: audioURL)
        } catch {
            print("unable to load audio file")
        }
    }
    
    
    override func didMove(to view: SKView) {
        if contentCreated == false {
            createSceneContents()
            contentCreated = true
        }
        else {
            resetFlappy()
            clearPipes()
            points = 0
        }
    }
    
    
    func createSceneContents() {
        backgroundColor = SKColor.gray
        
        physicsWorld.contactDelegate = self
        createBackdrop()
        createFlappy()
        
        let scoreNode = SKLabelNode(fontNamed: "Bauhaus 93")
        scoreNode.text = "0"
        scoreNode.fontSize = 96.0
        scoreNode.position = CGPoint(x: 20.0, y: size.height - 120.0)
        scoreNode.zPosition = 20.0
        scoreNode.name = "Score"
        scoreNode.horizontalAlignmentMode = .left
        addChild(scoreNode)
        
        startMakingPipes()
        loadAudio()
    }
    
    
    func addPoints(value: Int) {
        points += value
        print("points = \(points)")
        if let scoreNode = childNode(withName: "Score") as! SKLabelNode? {
            scoreNode.text = "\(points)"
        }
    }
    
    
    func clearPipes() {
        removeAction(forKey: "MakePipe")
        enumerateChildNodes(withName: "pipe") { (node, stop) in
            node.run(SKAction.removeFromParent())
        }
        startMakingPipes()
    }
    
    func startMakingPipes() {
        let makePipe = SKAction.sequence([
            SKAction.run {
                self.addPipe()
            },
            SKAction.wait(forDuration: 2.0, withRange: 1.0)])
        run(SKAction.repeatForever(makePipe), withKey: "MakePipe")
    }
    
    
    func addPipe() {
        let node = Pipe(centerY: frame.midY)
        node.name = "pipe"
        node.position = CGPoint(x: frame.width + 65.0, y: 0.0)
        addChild(node)
    }
    
    
    func resetFlappy() {
        if let flappy = childNode(withName: "flappy"), let body = flappy.physicsBody {
            flappy.position = CGPoint(x: frame.midX, y: frame.midY)
            flappy.zPosition = 10.0
            body.velocity = CGVector(dx: 0, dy: 0)
            body.angularVelocity = 0.0
        }
    }
    
    
    func createFlappy() {
        let atlas = SKTextureAtlas(named: "Flappy")
        let t1 = atlas.textureNamed("player1.png")
        let t2 = atlas.textureNamed("player2.png")
        let t3 = atlas.textureNamed("player3.png")
        let t4 = atlas.textureNamed("player4.png")
        let flappyTextures = [t1, t2, t3, t4]
        
        let flappy = SKSpriteNode(texture: t1)
        flappy.position = CGPoint(x: frame.midX, y: frame.midY)
        flappy.zPosition = 10.0
        flappy.size = CGSize(width: 71, height: 61)
        flappy.name = "flappy"
        let body = SKPhysicsBody(texture: t1, size: CGSize(width: 71, height: 61))
        body.usesPreciseCollisionDetection = true
        body.contactTestBitMask = 1
        flappy.physicsBody = body
        
        let animateFlappy = SKAction.animate(with: flappyTextures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatForever(animateFlappy)
        flappy.run(repeatAction)
        
        addChild(flappy)
    }
    
    
    func createBackdrop() {
        let floor = SKSpriteNode(color: SKColor.green, size: CGSize(width: frame.width, height: 32))
        floor.position = CGPoint(x: frame.midX, y: 96.0)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody?.isDynamic = false
        floor.name = "floor"
        addChild(floor)
        
        let groundGroup = SKSpriteNode()
        groundGroup.name = "groundGroup"
        
        let groundTexture = SKTexture(imageNamed: "ground.png")
        var w: CGFloat = 336.0
        var x: CGFloat = w / 2.0
        while (x - w / 2.0) < (frame.width + w) {
            let ground = SKSpriteNode(texture: groundTexture)
            ground.position = CGPoint(x: x, y: 56.0)
            ground.name = "ground"
            ground.zPosition = 5.0
            groundGroup.addChild(ground)
            x = x + w
        }
        
        addChild(groundGroup)
        
        let backTexture = SKTexture(imageNamed: "bg.png")
        
        let originalWidth = 288
        let originalHeight = 384
        let newHeight = frame.height - 112
        let ratio = CGFloat(newHeight) /  CGFloat(originalHeight)
        w = CGFloat(originalWidth) * ratio
        x = w / 2.0
        while (x - w / 2.0) < (frame.width + w) {
            let back = SKSpriteNode(texture: backTexture)
            back.size = CGSize(width: w, height: newHeight)
            back.position = CGPoint(x: x, y: 112.0 + CGFloat(newHeight) / 2.0)
            back.name = "back"
            addChild(back)
            x = x + w
        }
        
        let ceiling = SKSpriteNode(color: SKColor.blue, size: CGSize(width: frame.width, height: 32))
        ceiling.position = CGPoint(x: frame.midX, y: frame.height + 16.0)
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: ceiling.size)
        ceiling.physicsBody?.isDynamic = false
        ceiling.name = "ceiling"
        addChild(ceiling)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        flappyRotate()
        
        // instead of a repeated forever action, I added this enumerate method
        // in order to move the pipes.
        enumerateChildNodes(withName: "pipe") { (node, stop) in
            let pipe = node as! Pipe
            pipe.process()
        }
    }
    
    
    func flappyRotate() {
        if let flappy = childNode(withName: "flappy"), let body = flappy.physicsBody {
            flappy.zRotation = body.velocity.dy * 0.001
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nameA = nodeA.name else { return }
        guard let nodeB = contact.bodyB.node, let nameB = nodeB.name else { return }
        if nameA == "flappy" || nameB == "flappy" {
            
            if let player = endAudioPlayer {
                player.play()
            }
            
            controller.hello.updateHighScore(value: points)
            isPaused = true // pauses SKScene
            
            let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
            if let view = view {
                view.presentScene(controller.hello, transition: doors)
            }
        }
    }
    
    
    override func keyDown(with event: NSEvent) {
        if event.characters == " " {
            if let node = childNode(withName: "flappy") {
                let up = CGVector(dx: 0.0, dy: 50.0)
                node.physicsBody?.applyImpulse(up)
            }
        }
        
        else if event.characters == "p" {
            isPaused = true
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.2)
            view?.presentScene(controller.flappy, transition: transition)
            
        }
    }
    
}
