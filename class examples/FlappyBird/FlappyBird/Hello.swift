//
//  Hello.swift
//  FlappyBird
//
//  Created by Loren Olson on 11/8/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import SpriteKit


class Hello: SKScene {
    
    var contentsCreated = false
    var controller: ViewController!
    var scores: [Score] = []
    let docsFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    
    override func didMove(to view: SKView) {
        if contentsCreated == false {
            backgroundColor = SKColor.blue
            loadScores()
            makeTextNode()
            contentsCreated = true
        }
    }
    
    
    func loadScores() {
        let filePath = "\(docsFolder)/FlappyBirdScores.data"
        let fm = FileManager.default
        if fm.fileExists(atPath: filePath) {
            let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
            if data != nil {
                scores = data as! [Score]
            }
        }
    }
    
    
    func saveScores() {
        let filePath = "\(docsFolder)/FlappyBirdScores.data"
        if NSKeyedArchiver.archiveRootObject(scores, toFile: filePath) {
            print("Saved scores.")
        }
    }
    
    
    func makeTextNode() {
        let textNode = SKLabelNode(fontNamed: "Futura")
        textNode.text = "Flappy Bird Clone!"
        textNode.fontSize = 48
        textNode.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
        textNode.name = "HelloText"
        addChild(textNode)
        
        let highScoreNode = SKLabelNode(fontNamed: "Futura Medium")
        if scores.count > 0 {
            highScoreNode.text = "High score: \(scores[0].name): \(scores[0].points)"
        }
        highScoreNode.fontSize = 50.0
        highScoreNode.position = CGPoint(x: size.width/2.0, y: 100)
        highScoreNode.name = "HighScore"
        addChild(highScoreNode)
        
    }
    
    
    func updateHighScore(value: Int) {
        
        let alert = NSAlert()
        alert.messageText = "Add new score!"
        alert.informativeText = "Score: \(value)"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let input = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        input.placeholderString = "Name"
        alert.accessoryView = input
        let result = alert.runModal()
        
        if result == NSApplication.ModalResponse.alertFirstButtonReturn {
            print("update score...")
            var saveName = "-"
            if input.stringValue.isEmpty == false {
                saveName = input.stringValue
            }
            let score = Score(name: saveName, points: value)
            scores.append(score)
            scores.sort { (a, b) -> Bool in
                a.points > b.points
            }
            
            saveScores()
            
            if let node = childNode(withName: "HighScore") as! SKLabelNode? {
                node.text = "High score: \(scores[0].name): \(scores[0].points)"
            }
        }
        else {
            print("cancel update score")
        }
        
        
        

    
    }
    

    
    override func keyDown(with event: NSEvent) {
        let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
        self.view?.presentScene(controller.flappy, transition: doors)
        
    }
}
