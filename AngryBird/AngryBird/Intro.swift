//
//  Intro.swift
//  AngryBird
//
//  Created by Ramon on 11/19/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation
import SpriteKit

class Intro: SKScene {
    var message = "Angry Bird"
    
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
        
    }
    
    override func mouseDown(with event: NSEvent) {
        if let view = view {
            let game = Game(size: size)
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            view.presentScene(game, transition: transition)
        }
    }
}
