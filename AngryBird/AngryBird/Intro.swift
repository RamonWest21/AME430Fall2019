//
//  Intro.swift
//  AngryBird
//
//  Created by Ramon West on 11/19/19.
//  Copyright © 2019 Ramon West. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Intro: SKScene {
    var message = "Angry Bird"
    let gameSound = SKAction.playSoundFileNamed("DKThemeMidi.wav", waitForCompletion: false)
    
    override func didMove(to view: SKView){
        backgroundColor = SKColor.green
        createSceneContent()
    }
    
    func createSceneContent() {
        
        // introduction
        let textNode = SKLabelNode(fontNamed: "Futura")
        textNode.text = "Click Screen to Start!"
        textNode.fontSize = 48
        textNode.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        textNode.name = "Intro Label"
        addChild(textNode)
        
        // instructions
        let instructions = SKLabelNode(fontNamed: "Futura")
        instructions.text = "Move left and right with 'A' and 'D'"
        instructions.fontSize = 48
        instructions.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0 - 150)
        instructions.name = "Instructions Label"
        addChild(instructions)
        
        let instructions2 = SKLabelNode(fontNamed: "Futura")
        instructions2.text = "Jump with 'W'"
        instructions2.fontSize = 48
        instructions2.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0 - 200)
        instructions2.name = "Instructions Label2"
        addChild(instructions2)
        
        
        self.run(self.gameSound)
    
        
    }
    
    override func mouseDown(with event: NSEvent) {
        if let view = view {
            let game = Game(size: size)
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            view.presentScene(game, transition: transition)
        }
    }
}
