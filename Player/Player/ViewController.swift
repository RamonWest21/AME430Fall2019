//
//  ViewController.swift
//  Player
//
//  Created by Blaze on 9/19/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import Cocoa
import AVKit

class ViewController: NSViewController {

    var playing = 1
    
    @IBOutlet weak var AV: AVPlayerView!
    
    var movieOpen = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // This is required, so that the ViewController becomes the first responder,
    // and the File->Open menu item will be enabled.
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
                movieOpen = true
                
                
            }
        }
        else {
            print("User hit cancel")
        }
    }
    
    func openMovie(url: URL) {
        let asset = AVURLAsset(url: url)
        
        let item = AVPlayerItem(asset: asset)
        
        let player = AVPlayer(playerItem: item)
        
       // let timeScale = CMTimeScale(NSEC_PER_SEC)
       // let time = CMTime(seconds: 0.1, preferredTimescale: timeScale)
        
       // timeObservationToken = player.addPeriodicTimeObserver(forInterval: time, queue: .main) {
            //updates the UI////
            //[weak self] time in
           // print("time: \(time.seconds)")
       // }
        
        AV.player = player
    }
    
    func forward() {
        guard let player = AV.player, let item = player.currentItem else {
            return
        }
        
        let currentTime = item.currentTime()
        
        let newTime = currentTime + CMTime(seconds: 30.0, preferredTimescale: 600)
        
        player.seek(to: newTime)
    }
    
    
    func backward() {
        guard let player = AV.player, let item = player.currentItem else {
            return
        }
        
        let currentTime = item.currentTime()
        
        let newTime = currentTime + CMTime(seconds: -30.0, preferredTimescale: 600)
        
        player.seek(to: newTime)
    }
    
    
    @IBAction func startOver(_ sender: NSButton) {
        
        print("Hello?")
        guard let player = AV.player else {return}
        
        print("Got player")
        let newTimeLocation = CMTime(seconds: 1.0, preferredTimescale: 600)
        
        print(newTimeLocation)
        
        player.seek(to: newTimeLocation, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }
    
    
    
    
    
    
    
    
    @IBAction func playPause(_ sender: Any) {
       // if movieOpen == true {
            if playing == 1 {
                AV.player?.play()
                playing = 2
            }
            else {
                AV.player?.pause()
                playing = 1
            }
            
    }
        
    
    
    
    @IBAction func ff30(_ sender: NSButton) {
        forward()
    }
    
    
    @IBAction func rewind30(_ sender: NSButton) {
        backward()
    }
    
    
    @IBAction func title(_ sender: NSTextFieldCell) {
        
    }
    
    
    
    
}

