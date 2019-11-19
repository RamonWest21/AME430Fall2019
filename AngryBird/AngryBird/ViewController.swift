//
//  ViewController.swift
//  AngryBird
//
//  Created by Ramon on 11/19/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let size = CGSize(width: view.frame.width, height: view.frame.height)
        let intro = Intro(size: size)
        
        if let view = view as? SKView {
            view.presentScene(intro)
        }
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

