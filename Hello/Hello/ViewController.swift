//
//  ViewController.swift
//  Hello
//
//  Created by student on 8/27/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var label: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func buttonActionMethod(_ sender: NSButton) {
        label.stringValue = "Hello"
        
    }
    
    @IBAction func clearButton(_ sender: Any) {
        label.stringValue = ""
    }
    
}

