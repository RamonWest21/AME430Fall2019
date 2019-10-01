//
//  ViewController.swift
//  Media Player 2019
//
//  Created by student on 10/1/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa
import AVKit

class ViewController: NSViewController {
    

    
    @IBOutlet weak var playerView: AVPlayerView!
    
    
    var isPlaying = 1
    var movieIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var acceptsFirstResponder: Bool { return true }
    
    @IBAction func openDocument(_ sender: NSMenuItem) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false
        let response = openPanel.runModal()
        if response == .OK {
            print("User hit OK")
            if let url = openPanel.url {
                print("url path is \(url.path)")
                openMovie(url: url)
                movieIsOpen = true
            }
        }
        else {
            print("cancel")
        }
    }

    func openMovie(url: URL){
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: item)
        
        playerView.player = player
    }

}

