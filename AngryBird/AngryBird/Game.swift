//
//  Game.swift
//  AngryBird
//
//  Created by Ramon West on 11/19/19.
//  Copyright © 2019 Ramon West. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class Game: SKScene, SKPhysicsContactDelegate {
    
    var randomSource = GKLinearCongruentialRandomSource.sharedRandom()
    var selectedNode: SKNode?
    var donkeyKong: SKNode?
    var kritter: SKNode?
    var cannonBarrel: SKNode?
    var regularBarrels: [SKNode]?
    let gameSound = SKAction.playSoundFileNamed("DKThemeMidi.wav", waitForCompletion: false)
    var points = 0 {
        didSet {
            //updatePoints()
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        physicsWorld.contactDelegate = self
        createSceneContent()
    }
    
    func updatePoints() {
        
        if let pointsNode = childNode(withName: "Points") as? SKLabelNode {
            pointsNode.text = "\(points)"
        }
        print(points)
    }
    
    
    func createGameLabel() {
        let textNode = SKLabelNode(fontNamed: "Futura")
        textNode.text = "Knock over the Kritter!"
        textNode.fontSize = 30
        textNode.position = CGPoint(x: size.width / 2.0, y: size.height - 48.0)
        textNode.name = "Game Label"
        addChild(textNode)
    }
    
    func createPointsNode() {
        let pointsNode = SKLabelNode(fontNamed: "Courier")
        pointsNode.text = "\(points)"
        pointsNode.horizontalAlignmentMode = .right
        pointsNode.verticalAlignmentMode = .top
        pointsNode.fontSize = 30
        pointsNode.position = CGPoint(x: frame.width - 5.0, y: frame.height - 5.0)
        pointsNode.name = "Points"
        addChild(pointsNode)
    }
    
    func createDonkeyKong() {
        let heroTexture = SKTexture(imageNamed: "DonkeyKongLeft.png")
        let hero = SKSpriteNode(texture: heroTexture)
        let originalWidth = 37.0
        let originalHeight = 40.0
        let scale = 2.0
        hero.position = CGPoint(x: frame.midX - 200, y: frame.midY - 150)
        hero.size = CGSize(width: originalWidth * scale, height: originalHeight * scale)
        hero.zRotation = .pi / 6.0
        hero.name = "Donkey Kong"
        let body = SKPhysicsBody(rectangleOf: hero.size)
        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.collisionBitMask = 0x7fffffff
        hero.physicsBody = body
        
        let xRange = SKRange(lowerLimit: 0.0, upperLimit: frame.width)
        let xConstraint = SKConstraint.positionX(xRange)
        hero.constraints = [xConstraint]
        
        
        donkeyKong = hero
        addChild(donkeyKong!)
    }
    
    func createBarrelCannon() {
        let cannonTexture = SKTexture(imageNamed: "BarrelCannon.png")
        let cannon = SKSpriteNode(texture: cannonTexture)
        let originalWidth = 37.0
        let originalHeight = 50.0
        let scale = 2.0
        cannon.position = CGPoint(x: frame.midX - 300, y: frame.midY - 150)
        cannon.size = CGSize(width: originalWidth * scale, height: originalHeight * scale)
        cannon.zRotation = .pi / 6.0
        cannon.name = "Barrel Cannon"
        let body = SKPhysicsBody(rectangleOf: cannon.size)
        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.collisionBitMask = 0x00000001
        body.categoryBitMask = 0x80000000 // DK collison bit mask compared to barrel category mask
        cannon.physicsBody = body
        
        let xRange = SKRange(lowerLimit: 0.0, upperLimit: frame.width)
        let xConstraint = SKConstraint.positionX(xRange)
        cannon.constraints = [xConstraint]
        
        addChild(cannon)
    }
    
    func createRegularBarrel(regularBarrelPosition: CGPoint) {
        let regularBarrelTexture = SKTexture(imageNamed: "RegularBarrel.png")
        let regularBarrel = SKSpriteNode(texture: regularBarrelTexture)
        let originalWidth = 29.0
        let originalHeight = 39.0
        let scale = 2.0
        regularBarrel.position = regularBarrelPosition
        regularBarrel.size = CGSize(width: originalWidth * scale, height: originalHeight * scale)
        regularBarrel.zRotation = .pi / 6.0
        regularBarrel.name = "Regular Barrel"
        let body = SKPhysicsBody(rectangleOf: regularBarrel.size)
        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.collisionBitMask = 0x00000001
        regularBarrel.physicsBody = body
        
        let xRange = SKRange(lowerLimit: 0.0, upperLimit: frame.width)
        let xConstraint = SKConstraint.positionX(xRange)
        regularBarrel.constraints = [xConstraint]
        
        addChild(regularBarrel)
    }
    
    func createRegularBarrelStructure() {
        var y = CGFloat(frame.midY - 150)
        for _ in 1...2 { // column
            var x = CGFloat(frame.midX + 100)
            for _ in 1...3{ // row
                let barrelPosition = CGPoint(x: x, y: y)
                createRegularBarrel(regularBarrelPosition: barrelPosition)
                x += 60.0
            }
            y += 120.0
        }
    }
    
    func createKritter(kritterPosition: CGPoint) {
        let villainTexture = SKTexture(imageNamed: "Kritter.png")
        let villain = SKSpriteNode(texture: villainTexture)
        let originalWidth = 29.0
        let originalHeight = 39.0
        let scale = 2.0
        villain.position = kritterPosition
        villain.size = CGSize(width: originalWidth * scale, height: originalHeight * scale)
        villain.zRotation = .pi / 6.0
        villain.name = "Kritter"
        let body = SKPhysicsBody(rectangleOf: villain.size)
        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.collisionBitMask = 0x00000001
        villain.physicsBody = body
        
        let xRange = SKRange(lowerLimit: 0.0, upperLimit: frame.width)
        let xConstraint = SKConstraint.positionX(xRange)
        villain.constraints = [xConstraint]
        
        kritter = villain
        addChild(kritter!)
    }
    
    func createGround(){
        let floor = SKSpriteNode(color: NSColor.clear, size: CGSize(width: frame.width + 100, height: 260))
        floor.position = CGPoint(x: frame.midX, y: 96.0)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody?.isDynamic = false
        floor.name = "floor"
        addChild(floor)

        
    }
    
    func createBackdrop() {
    
        var w: CGFloat = 5376.0
        var x: CGFloat = w / 2.0
        
        let backTexture = SKTexture(imageNamed: "DonkeyKongCountryMap01JungleHijinxsBG.png")
        
        let originalWidth = 5376
        let originalHeight = 768
        let newHeight = frame.height + 384
        let ratio = CGFloat(newHeight) /  CGFloat(originalHeight)
        w = CGFloat(originalWidth) * ratio
        x = w / 2.0
        while (x - w / 2.0) < (frame.width + w) {
            let back = SKSpriteNode(texture: backTexture)
            back.size = CGSize(width: w, height: newHeight)
            back.position = CGPoint(x: x, y: CGFloat(newHeight) / 2.0 - 384)
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

    func createSceneContent() {
        
        createBackdrop()
        createGround()
        createGameLabel()
        createPointsNode()
        createDonkeyKong()
        createBarrelCannon()
        let k = CGPoint(x: frame.midX + 120, y: frame.midY + 90)
        createRegularBarrelStructure()
        createKritter(kritterPosition: k)
        self.run(self.gameSound)
        print("Gravity: ")
        print(self.physicsWorld.gravity)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -6.0)
    }
    
    override func mouseDown(with event: NSEvent) {
        
        
        let point = event.location(in: self)
        let nodesAtPoint = nodes(at: point)
        if nodesAtPoint.count > 0 {
            if nodesAtPoint.first?.name != "back" &&
                nodesAtPoint.first?.name != "Points" &&
                nodesAtPoint.first?.name != "Game Label" &&
                nodesAtPoint.first?.name != "floor"
                { // don't move backdrop, points label, or game label
                selectedNode = nodesAtPoint.first!
                nodesAtPoint[0].physicsBody?.isDynamic = false
            }
        }
    }
    
    
    override func mouseDragged(with event: NSEvent) {
        if let selected = selectedNode {
            let point = event.location(in: self)
            let move = SKAction.move(to: point, duration: 0)
            selected.run(move)
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        if let selected = selectedNode{
            selected.physicsBody?.isDynamic = true
        }
        selectedNode = nil
    }
    
    override func keyDown(with event: NSEvent) {
        guard let hero = childNode(withName: "Donkey Kong") else { return }
        
        if let characters = event.characters {
            print ("keyDown = \"\(characters)\", keycode = \(event.keyCode)")
            if characters == "a" {
                hero.run(SKAction.moveBy(x: -20.0, y: 10.0, duration: 0.1))
                hero.run(SKAction.scaleX(to: 1.0, duration: 0))
            }
            else if characters == "d" {
                hero.run(SKAction.moveBy(x: 20.0, y: 10.0, duration: 0.1))
                hero.run(SKAction.scaleX(to: -1.0, duration: 0))
            }
            else if characters == "w" {
                hero.run(SKAction.moveBy(x: 0.0, y: 160.0, duration: 0.2))
            }
            
        }
    }
    
    override func keyUp(with event: NSEvent) {
        if let characters = event.characters {
            print ("keyDown = \"\(characters)\", keycode = \(event.keyCode)")
            if characters == "a" ||
                characters == "w" ||
                characters == "d" {
                points += 1
                updatePoints()
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else {return}
        guard let nameA = nodeA.name, let nameB = nodeB.name else {return}
        
        if nameA == "floor" && nameB == "Kritter"  {
            
            if let view = view {
                let out = Outro(size: size)
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                view.presentScene(out, transition: transition)
            }
            
        }
    }
    
    
}
