//
//  ViewController.swift
//  FlappyBird
//
//  Created by Loren Olson on 11/8/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {
    
    // maintain the lifespan of hello and flappy scenes!
    var hello: Hello!
    var flappy: Flappy!

    override func viewDidAppear() {
        super.viewDidAppear()

        let spriteView = view as! SKView
        
        guard let window = view.window, let screen = window.screen else { return }
        
        window.title = "Flappy Clone"
        
        let visibleFrame = screen.visibleFrame
        let newFrame = NSRect(x: visibleFrame.origin.x, y: visibleFrame.origin.y + 200.0, width: visibleFrame.width, height: visibleFrame.height - 200.0)
        window.setFrame(newFrame, display: true)
        
        
        // Creating them in the ViewController ensures they are not terminated when not referenced.
        hello = Hello(size: CGSize(width: view.frame.width, height: view.frame.height))
        hello.controller = self
        flappy = Flappy(size: hello.size)
        flappy.controller = self
        
        spriteView.presentScene(hello)
    }




}

