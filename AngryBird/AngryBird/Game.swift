//
//  Game.swift
//  AngryBird
//
//  Created by student on 11/19/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Game: SKScene, SKPhysicsContactDelegate {
    
    var randomSource = GKLinearCongruentialRandomSource.sharedRandom()
    var selectedNode: SKNode?
    var points = 0 {
        didSet {
            //updatePoints()
        }
    }
    
    var heroPosition: CGPoint!
    var villanPosition: CGPoint!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        physicsWorld.contactDelegate = self
        createSceneContent()
    }
    
    func updatePoints() {
        if let pointsNode = childNode(withName: "Points") as? SKLabelNode {
            pointsNode.text = "\(points)"
        }
    }
    
    func createGameLabel() {
        let textNode = SKLabelNode(fontNamed: "Futura")
        textNode.text = "This is the Game Scene"
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
    
    func createHero() {
        let heroTexture = SKTexture(imageNamed: "DonkeyKongLeft.png")
        let hero = SKSpriteNode(texture: heroTexture)
        let originalWidth = 37.0
        let originalHeight = 40.0
        let scale = 2.0
        hero.position = CGPoint(x: frame.midX - 300, y: frame.midY - 150)
        hero.size = CGSize(width: originalWidth * scale, height: originalHeight * scale)
        hero.zRotation = .pi / 6.0
        hero.name = "Donkey Kong"
        let body = SKPhysicsBody(rectangleOf: hero.size)
        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.collisionBitMask = 0x00000003
        hero.physicsBody = body
        
        let xRange = SKRange(lowerLimit: 0.0, upperLimit: frame.width)
        let xConstraint = SKConstraint.positionX(xRange)
        hero.constraints = [xConstraint]
        
        addChild(hero)
        
        heroPosition = hero.position
    }
    
    func createBarrelCannon() {
        let cannonTexture = SKTexture(imageNamed: "BarrelCannon.png")
        let cannon = SKSpriteNode(texture: cannonTexture)
        let originalWidth = 37.0
        let originalHeight = 50.0
        let scale = 2.0
        cannon.position = CGPoint(x: frame.midX - 300, y: frame.midY)
        cannon.size = CGSize(width: originalWidth * scale, height: originalHeight * scale)
        cannon.zRotation = .pi / 6.0
        cannon.name = "Barrel Cannon"
        let body = SKPhysicsBody(rectangleOf: cannon.size)
        body.isDynamic = true
        body.usesPreciseCollisionDetection = false
        body.collisionBitMask = 0x00000003
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
        body.collisionBitMask = 0x00000003
        regularBarrel.physicsBody = body
        
        let xRange = SKRange(lowerLimit: 0.0, upperLimit: frame.width)
        let xConstraint = SKConstraint.positionX(xRange)
        regularBarrel.constraints = [xConstraint]
        
        addChild(regularBarrel)
    }
    
    func createRegularBarrelStructure() {
        
    }
    
    func createKritter(regularBarrelPosition: CGPoint) {
        let kritterTexture = SKTexture(imageNamed: "Kritter.png")
        let kritter = SKSpriteNode(texture: kritterTexture)
        let originalWidth = 29.0
        let originalHeight = 39.0
        let scale = 2.0
        kritter.position = regularBarrelPosition
        kritter.size = CGSize(width: originalWidth * scale, height: originalHeight * scale)
        kritter.zRotation = .pi / 6.0
        kritter.name = "Regular Barrel"
        let body = SKPhysicsBody(rectangleOf: kritter.size)
        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.collisionBitMask = 0x00000003
        kritter.physicsBody = body
        
        let xRange = SKRange(lowerLimit: 0.0, upperLimit: frame.width)
        let xConstraint = SKConstraint.positionX(xRange)
        kritter.constraints = [xConstraint]
        
        addChild(kritter)
    }
    
    func createGround(){
        let floor = SKSpriteNode(color: NSColor.clear, size: CGSize(width: frame.width, height: 260))
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
        createHero()
        createBarrelCannon()
        let p = CGPoint(x: frame.midX + 200, y: frame.midY - 150)
        let k = CGPoint(x: frame.midX + 250, y: frame.midY - 150)
        createKritter(regularBarrelPosition: k)
        createRegularBarrel(regularBarrelPosition: p)
        createRegularBarrel(regularBarrelPosition: p)
    }
    
    override func mouseDown(with event: NSEvent) {
        
        let point = event.location(in: self)
        let nodesAtPoint = nodes(at: point)
        if nodesAtPoint.count > 0 {
            selectedNode = nodesAtPoint.first!
            nodesAtPoint[0].physicsBody?.isDynamic = false
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
                
                let move = SKAction.moveBy(x: -50.0, y: 0.0, duration : 0.1)
                hero.run(move)
            }
            else if characters == "d" {
                
                let move = SKAction.moveBy(x: 50.0, y: 0.0, duration : 0.1)
                hero.run(move)
            }
            else if characters == "w" {
                
                let move = SKAction.moveBy(x: 0.0, y: 100.0, duration : 0.2)
                hero.run(move)
            }
        }
    }
}
