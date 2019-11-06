import Foundation
import SpriteKit
import GameplayKit

class Game: SKScene, SKPhysicsContactDelegate {
    
    var randomSource = GKLinearCongruentialRandomSource.sharedRandom()
    var selectedNode: SKNode?
    var points = 0 {
        didSet {
            updatePoints()
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
        guard let hero = childNode(withName: "Hero") else { return }
        
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
    
    
    func addThing(point: CGPoint){
        //let thing = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 40.0, height: 40.0))
        let thingTexture = SKTexture(imageNamed: "rainrop.png")
        let thing = SKSpriteNode(texture: thingTexture, size: CGSize(width: 40, height: 40))
        thing.position = point
        thing.name = "Thing"
        let body = SKPhysicsBody(rectangleOf: thing.size)
        body.isDynamic = true
        //  body.collisionBitMask = 0x00000001
        //body.categoryBitMask = 0x0000001
        body.contactTestBitMask = 0xffffffff
        thing.physicsBody = body
        addChild(thing)
    }
    
    
    func addSmallThing(point: CGPoint) {
        let r = CGFloat(0.1 + randomSource.nextUniform() * 0.1)
        let g = CGFloat(0.1 + randomSource.nextUniform() * 0.1)
        let b = CGFloat(0.7 + randomSource.nextUniform() * 0.2)
        let thing = SKSpriteNode(color: SKColor(calibratedRed: r, green: g, blue: b, alpha: 1.0), size: CGSize(width: 10.0, height: 10.0))
        thing.position = point
        thing.name = "SmallThing"
        let body = SKPhysicsBody(rectangleOf: thing.size)
        body.isDynamic = true
        let dx = CGFloat(randomSource.nextUniform() * 0.5 - 0.25) * 1700.0
        let dy = CGFloat(randomSource.nextUniform() * 0.4 + 0.05) * 1700.0
        let dir = CGVector(dx: dx, dy: dy)
        body.velocity = dir
        //body.collisionBitMask = 0x00000001
        //body.categoryBitMask = 0x00000001
        body.contactTestBitMask = 0xffffffff
        thing.physicsBody = body
        addChild(thing)
        
        
        
        let action = SKAction.sequence([
            SKAction.wait(forDuration: 2.0, withRange: 2.0),
            SKAction.removeFromParent()
            ])
        
        thing.run(action)
    }
    
    override func update( _ currentTime: TimeInterval) {
        let choice = randomSource.nextUniform()
        if choice < 0.05 {
            let x = CGFloat(randomSource.nextUniform()) * frame.width
            let y = frame.height
            addThing(point: CGPoint(x: x, y: y))
        }
        
        if points >= 50 {
            gameOver()
        }
        
    }
    
    func gameOver(){
        let goodBye = GoodBye(size: size)
        goodBye.message = "You Won!"
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
        view?.presentScene(goodBye, transition: transition)
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }
        
        if nameA == "Ground" && nameB == "Thing"{
            
            nodeB.run(SKAction.removeFromParent())
            for _ in 1...10 {
                addSmallThing(point: contact.contactPoint)
            }
            points = points - 1
        }
        
       else if nameA == "Hero" && nameB == "Thing"{
        
            nodeB.run(SKAction.removeFromParent())
            for _ in 1...10 {
                addSmallThing(point: contact.contactPoint)
            }
            points = points + 10
        }
            
        else if nameA == "Thing" && nameB == "Ground"{
            
        }
        
    }
}

