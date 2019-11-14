import Foundation
import SpriteKit

class Hello: SKScene {
    
    var message = "Amazing"
    
    override func didMove(to view: SKView){
        backgroundColor = SKColor.blue
        createSceneContent()
        
    }
    func createSceneContent() {
        let textNode = SKLabelNode(fontNamed: "Futura")
        textNode.text = "Click Screen to Start."
        textNode.fontSize = 48
        textNode.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        textNode.name = "Intro Label"
        addChild(textNode)
        let instructions = SKLabelNode(fontNamed: "Futura")
        instructions.text = "Move with 'A, W, D' or drag with mouse"
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
