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
        hero.physicsBody = body
        addChild(hero)
        
        let ground = SKSpriteNode(color:SKColor.green, size: CGSize(width: frame.width, height: 20.0))
        ground.position = CGPoint(x: frame.midX, y: 10.0)
        ground.name = "Ground"
        let groundBody = SKPhysicsBody(rectangleOf: ground.size)
        groundBody.isDynamic = false
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
        thing.physicsBody = body
        addChild(thing)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let choice = randomSource.nextUniform() // number between 0 and 1
        if choice < 0.05 {
            let x = CGFloat(randomSource.nextUniform()) * frame.width
            let y = frame.height
            addThing(point: CGPoint(x: x, y: y))
        }
        
    }
    
//    func didBegin(_ contact: SKPhysicsContact) {
//        <#code#>
//    }
    
}
