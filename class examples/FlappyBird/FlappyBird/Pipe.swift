//
//  Pipe.swift
//  FlappyBird
//
//  Created by Loren Olson on 11/8/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import SpriteKit



class Pipe: SKNode {
    
    var didScore = false
    var halfPipeWidth: CGFloat = 65.0
    
    
    
    init(centerY: CGFloat) {
        super.init()
        
        let sizeOfOpening: CGFloat = 300.0 + CGFloat(randomSource.nextUniform() * 300.0)
        let topOfOpening = centerY + sizeOfOpening / 2.0
        let bottomOfOpening = centerY - sizeOfOpening / 2.0
        
        let bottomTexture = SKTexture(imageNamed: "bottomPipe.png")
        
        let pipe1 = SKSpriteNode(texture: bottomTexture)
        pipe1.position = CGPoint(x: 0.0, y: bottomOfOpening - 193.0)
        pipe1.name = "pipe-bottom"
        let body1 = SKPhysicsBody(texture: bottomTexture, size: CGSize(width: 129, height: 387))
        body1.usesPreciseCollisionDetection = true
        body1.contactTestBitMask = 1
        body1.isDynamic = false
        pipe1.physicsBody = body1
        addChild(pipe1)
        
        let topTexture = SKTexture(imageNamed: "topPipe.png")
        
        let pipe2 = SKSpriteNode(texture: topTexture)
        pipe2.position = CGPoint(x: 0.0, y: topOfOpening + 325.0)
        pipe2.name = "pipe-top"
        let body2 = SKPhysicsBody(texture: topTexture, size: CGSize(width: 129, height: 651))
        body2.usesPreciseCollisionDetection = true
        body2.contactTestBitMask = 1
        body2.isDynamic = false
        pipe2.physicsBody = body2
        addChild(pipe2)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func process() {
        
        let flappyScene = scene as! Flappy
        if didScore == false && position.x < ((flappyScene.size.width / 2.0) - halfPipeWidth) {
            flappyScene.addPoints(value: 1)
            flappyScene.run(flappyScene.scoreSound)
            didScore = true
        }
        
        if position.x < -halfPipeWidth {
            removeFromParent()
        }
        else {
            run(SKAction.moveBy(x: -8.0, y: 0, duration: 0))
        }
    }
}
