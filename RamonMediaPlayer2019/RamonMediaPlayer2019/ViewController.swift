//
//  ViewController.swift
//  RamonMediaPlayer2019
//
//  Created by student on 9/24/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa
import AVKit

var url: URL!

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func openMovie(){
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: item)
        
    }
}

