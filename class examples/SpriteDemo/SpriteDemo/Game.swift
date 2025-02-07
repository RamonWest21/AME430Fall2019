//
//  Game.swift
//  SpriteDemo
//
//  Created by student on 10/29/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Game: SKScene, SKPhysicsContactDelegate {
    
    var randomSource = GKLinearCongruentialRandomSource.sharedRandom()
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        physicsWorld.contactDelegate = self
        createSceneContent()
    }
    
    func createSceneContent() {
        let textNode = SKLabelNode(fontNamed: "Futura")
        textNode.text = "This is the Game Scene"
        textNode.fontSize = 48
        textNode.position = CGPoint(x: size.width / 2, y: size.height - 30)
        textNode.name = "Amazing Lbel"
        addChild(textNode)
        
        let hero = SKSpriteNode(color: SKColor.red, size: CGSize(width: 64, height: 64))
        hero.position = CGPoint(x:frame.midX, y: frame.midY)
        hero.zRotation = .pi / 6.0
        hero.name = "Hero"
        let body = SKPhysicsBody(rectangleOf: hero.size)
        body.isDynamic = true
        body.collisionBitMask = 3 // "0x3" or "0x0000003" in hexadecimle
        // no category bit mask becuase we want the hero to collide with everything
        hero.physicsBody = body
        addChild(hero)
        
        let ground = SKSpriteNode(color:SKColor.green, size: CGSize(width: frame.width, height: 20.0))
        ground.position = CGPoint(x: frame.midX, y: 10.0)
        ground.name = "Ground"
        let groundBody = SKPhysicsBody(rectangleOf: ground.size)
        groundBody.isDynamic = false
        // no collision bit mask because ground is static.
        groundBody.categoryBitMask = 0x00000002 // different category than thing, no collisions with thing
        ground.physicsBody = groundBody
        addChild(ground)
        
        addThing(point: CGPoint(x: 20.0, y: 20.0))
    }
    
    override func mouseDown(with event: NSEvent) {
        guard let hero = childNode(withName: "Hero") else { return }
        
        let move = SKAction.moveBy(x: 200.0, y: 0.0, duration: 1.0)
        hero.run(move)
   }
    
    func addThing(point: CGPoint) {
        let thing = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 40.0, height: 40.0))
        thing.position = point
        thing.name = "Thing"
        let body = SKPhysicsBody(rectangleOf: thing.size)
        body.isDynamic = true
        body.collisionBitMask = 0x00000001
        body.categoryBitMask = 0x00000001 // different category than ground, no collisions with ground
        body.contactTestBitMask = 0xffffffff // if thing hits anything, send a message!
        thing.physicsBody = body
        addChild(thing)
    }
    
    func addSmallThing(point: CGPoint) {
        let r = CGFloat(0.7 + randomSource.nextUniform() * 0.2)
        let g = CGFloat(0.7 + randomSource.nextUniform() * 0.1)
        let b = CGFloat(0.7 + randomSource.nextUniform() * 0.1)
        let thing = SKSpriteNode(color: SKColor(calibratedRed: r, green: g, blue: b, alpha: 1.0), size: CGSize(width: 10.0, height: 10.0))
        thing.position = point
        thing.name = "SmallThing"
        let body = SKPhysicsBody(rectangleOf: thing.size)
        body.isDynamic = true
        body.collisionBitMask = 0x00000001
        body.categoryBitMask = 0x00000001 // different category than ground, no collisions with ground
        body.contactTestBitMask = 0xffffffff // if thing hits anything, send a message!
        let dx = CGFloat(randomSource.nextUniform() * 0.5 - 0.25) * 1700 // rand num [-0.25:0.25] * 1700
        let dy = CGFloat(randomSource.nextUniform() * 0.4 + 0.25) * 1700 // rand num [0:0.25] * 1700
        let dir = CGVector(dx: dx, dy: dy)
        body.velocity = dir
        thing.physicsBody = body
        addChild(thing)
        
        let action = SKAction.sequence([
            SKAction.wait(forDuration: 2.0, withRange: 2.0),
            SKAction.removeFromParent()
            ])
        thing.run(action)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let choice = randomSource.nextUniform() // number between 0 and 1
        if choice < 0.05 {
            let x = CGFloat(randomSource.nextUniform()) * frame.width
            let y = frame.height
            addThing(point: CGPoint(x: x, y: y))
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else {return}
        guard let nameA = nodeA.name, let nameB = nodeB.name else {return}
        
        if nameA == "Ground" && nameB == "Thing"  {
            nodeB.run(SKAction.removeFromParent())
            for _ in 1...10 {
                addSmallThing(point: contact.contactPoint)
            }
        }
        
        else if nameA == "Ground" && nameB == "Thing" {
            
            
        }
    }
    
}
