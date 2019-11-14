//
//  ViewController.swift
//  SpriteDemo
//
//  Created by student on 10/29/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa
import SpriteKit



class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = CGSize(width: view.frame.width, height: view.frame.height)
        let hello = Hello(size: size)
        if let view = view as? SKView {
            view.presentScene(hello)
        }
        
    }
}

