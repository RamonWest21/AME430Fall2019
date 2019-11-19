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
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        physicsWorld.contactDelegate = self
        createSceneContent()
    }
    
    func createSceneContent() {
        let textNode = SKLabelNode(fontNamed: "Futura")
        textNode.text = "This is the Game Scene"
        textNode.fontSize = 30
        textNode.position = CGPoint(x: size.width / 2.0, y: size.height - 48.0)
        textNode.name = "Game Label"
        addChild(textNode)
        
        let pointsNode = SKLabelNode(fontNamed: "Courier")
        pointsNode.text = "\(points)"
        pointsNode.horizontalAlignmentMode = .right
        pointsNode.verticalAlignmentMode = .top
        pointsNode.fontSize = 30
        pointsNode.position = CGPoint(x: frame.width - 5.0, y: frame.height - 5.0)
        pointsNode.name = "Points"
        addChild(pointsNode)
        
        
        
        //SKSpriteNode(color: SKColor.red, size: CGSize(width: 64, height: 64))
        let heroTexture = SKTexture(imageNamed: "SpongeGar.png")
        let hero = SKSpriteNode(texture: heroTexture)
        hero.position = CGPoint(x: frame.midX, y: frame.midY)
        hero.zRotation = .pi / 6.0
        hero.name = "Hero"
        let body = SKPhysicsBody(rectangleOf: hero.size)
        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.collisionBitMask = 0x00000003
        hero.physicsBody = body
        
        let xRange = SKRange(lowerLimit: 0.0, upperLimit: frame.width)
        let xConstraint = SKConstraint.positionX(xRange)
        hero.constraints = [xConstraint]
        
        addChild(hero)
        
        
        
        let ground = SKSpriteNode(color: SKColor.green, size: CGSize(width: frame.width, height: 20.0))
        ground.position = CGPoint(x: frame.midX, y: 10.0)
        ground.name = "Ground"
        let groundBody = SKPhysicsBody(rectangleOf: ground.size)
        groundBody.isDynamic = false
        groundBody.categoryBitMask = 0x00000002
        ground.physicsBody = groundBody
        addChild(ground)
        
        
    }
    
    func updatePoints() {
        if let pointsNode = childNode(withName: "Points") as? SKLabelNode {
            pointsNode.text = "\(points)"
        }
    }

}
