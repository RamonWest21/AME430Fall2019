//
//  Hello.swift
//  SpriteDemo
//
//  Created by student on 10/29/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation
import SpriteKit

class Hello: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.blue
        createSceneContent()
    }
    
    func createSceneContent() {
        let textNode = SKLabelNode(fontNamed: "Futura")
        textNode.text = "Amazing"
        textNode.fontSize = 48
        textNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        textNode.name = "Amazing Lbel"
        
        addChild(textNode)
    }
    
    // Switch to Game scene
    override func mouseDown(with event: NSEvent) {
        // unwrap the view property, create a local constant "view"
        if let view = view {
            let game = Game(size: size)
            let transition = SKTransition.flipHorizontal(withDuration: 1.0)
            //view.presentScene(game) doesn't use transition
            view.presentScene(game, transition: transition) // uses transition
        }
    }
    
}
