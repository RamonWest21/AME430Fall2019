import Cocoa
import SpriteKit

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let size = CGSize(width: view.frame.width , height: view.frame.height)
        let hello = Hello(size: size)
        
        if let view = view as? SKView {
            view.presentScene(hello)
            
        }
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

