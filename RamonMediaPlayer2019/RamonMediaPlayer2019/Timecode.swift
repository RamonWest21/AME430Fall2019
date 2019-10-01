//
//  Timecode.swift
//  RamonMediaPlayer2019
//
//  Created by student on 9/24/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation
import AVFoundation


struct Timecode {
    var hours: Int
    var minutes: Int
    var seconds: Int
    var frames: Int
    
    
    var display: String {
        let formatter = NumberFormatter()
        formatter.maximumIntegerDigits = 2
        formatter.minimumIntegerDigits = 2
        formatter.maximumFractionDigits = 0
        
        guard let h = formatter.string(from: NSNumber(value: hours)) else { return "--:--:--:--" }
        guard let m = formatter.string(from: NSNumber(value: minutes)) else { return "--:--:--:--" }
        guard let s = formatter.string(from: NSNumber(value: seconds)) else { return "--:--:--:--" }
        guard let f = formatter.string(from: NSNumber(value: frames)) else { return "--:--:--:--" }
        
        return "\(h):\(m):\(s):\(f)"
    }
    
    // rate is required to compute the frame number.
    // The best way I've found to get rate is to find it from
    // a track (AVAssetTrack) that is part of an AVAsset. Tracks
    // have a property "nominalFrameRate".
    init(time: CMTime, rate: Float) {
        let fseconds = time.seconds
        let iseconds = Int(fseconds)
        hours = iseconds / 3600
        let remainingSeconds = iseconds % 3600
        minutes = remainingSeconds / 60
        seconds = remainingSeconds % 60
        let frac = Float(fseconds) - Float(iseconds)
        frames = Int((frac * rate).rounded())
    }
    
    
}
