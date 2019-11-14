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
    
    @IBOutlet weak var timeCode: NSTextField!
    @IBOutlet weak var playButtonLabel: NSButton!
    @IBOutlet weak var duration: NSTextField!
    
    var isPlaying = false
    var movieIsOpen = false
    var timecode = ""
    var videoTitle = "No Video Selected"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // change the window title
    //  accessed from https://stackoverflow.com/questions/24235815/cocoa-how-to-set-window-title-from-within-view-controller-in-swift
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = videoTitle
        playButtonLabel.title = "⏯"
        
    }

    override var acceptsFirstResponder: Bool { return true }
    
    // acccess the file->open 
    @IBAction func openDocument(_ sender: NSMenuItem) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false
        let response = openPanel.runModal()
        if response == .OK {
            print("User hit OK")
            if let url = openPanel.url {
                print("url path is \(url.path)")
                videoTitle = "\(url.lastPathComponent)"
                viewDidAppear()
                openMovie(url: url)
                movieIsOpen = true
            }
        }
        else {
            print("cancel")
        }
    }
    
    // instantiate player object
    func openMovie(url: URL){
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: item)
        
        playerView.player = player
        
        var rate: Float = 30.0
        if let track = asset.tracks(withMediaType: .video).first {
            rate = track.nominalFrameRate
            
        }
        let duration = Timecode(time: asset.duration, rate: rate)
        
    }
    
    // alternates between play and pause states
    @IBAction func playPause(_ sender: NSButton) {
        if isPlaying == false{
            playerView.player?.play()
            playButtonLabel.title = "⏸"
            isPlaying = true
        }
        
        else if isPlaying == true{
            playerView.player?.pause()
            playButtonLabel.title = "▶️"
            isPlaying = false
        }
        displayTime()
    }
    
    // stops video, sets isPlaying to false, starts from begining
    @IBAction func stop(_ sender: NSButton) {
        guard let player = playerView.player else{ return}
        let startTime = CMTime(seconds: 0.0, preferredTimescale: 600)
        playerView.player?.pause()
        player.seek(to: startTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        displayTime()
        isPlaying = false 
    }
    
    // skips forward 30 seconds
    @IBAction func fastForward(_ sender: NSButton) {
        guard let player = playerView.player, let item = player.currentItem else {
            return
        }
        
        let currentTime = item.currentTime()
        let newTime = currentTime + CMTime(seconds: 30.0, preferredTimescale: 600)
        
        player.seek(to: newTime)
    }
    
    // skips backwards 30 seconds
    @IBAction func rewind(_ sender: NSButton) {
        guard let player = playerView.player, let item = player.currentItem else {
            return
        }
        
        let currentTime = item.currentTime()
        let newTime = currentTime - CMTime(seconds: 30.0, preferredTimescale: 600)
        
        player.seek(to: newTime)
    }
    

    func displayTime() -> String {
        guard let player = playerView.player, let item = player.currentItem else {
            return " "
        }
        
        let currentTimeDouble = item.currentTime().value // converts current time to Double
        let currentTimeString = String(currentTimeDouble)
        
        // forever while loop is bad
//        while isPlaying == true{
//            print(currentTimeString)
//        }
        let timeLabel = playerView.accessibilityLabel()
        
        return currentTimeString
    }
    
   
    
}

