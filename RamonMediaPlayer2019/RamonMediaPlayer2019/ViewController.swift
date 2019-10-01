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
    
    @IBOutlet var playerView: AVPlayerView!

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
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
//        timeObserverToken = player.addPeriodicTimeObserver(forInterval: time, queue: .main) {
//            [weak self] time in print("time: \(time.seconds)")
//            self?.playerView
//
//        }
        
        playerView.player = player
        
    }
    
    func forward(){
        guard let player = playerView.player, let item = player.currentItem else {
            return
        }
        
        let currentTime = item.currentTime()
        let newTime = currentTime + CMTime(seconds: 20.0, preferredTimescale: 600)
        
        player.seek(to: newTime)
    }
    
    @IBAction func goToDemo (_ sender: NSButton){
        guard let player = playerView.player else {return}
        
        let newTimeLocation = CMTime(seconds: 1.0, preferredTimescale: 600)
        
        print("\(newTimeLocation.seconds)")
        
        player.seek(to:newTimeLocation, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        
    }
}

