//
//  ViewController.swift
//  Computation Interface
//
//  Created by student on 9/5/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var particle1: Particle!

    // Text fields and Sliders for particle 1
    @IBOutlet weak var x1Field: NSTextField!
    @IBOutlet weak var x1Slider: NSSlider!
    @IBOutlet weak var y1Field: NSTextField!
    @IBOutlet weak var y1Slider: NSSlider!
    @IBOutlet weak var z1Field: NSTextField!
    @IBOutlet weak var z1Slider: NSSlider!
    
    // Text field for result
    @IBOutlet weak var resultField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        particle1 = Particle()
   
    }
    
    func updateFields() {
        x1Field.stringValue = particle1.xPositionFormatted()
        y1Field.stringValue = particle1.yPositionFormatted()
        z1Field.stringValue = particle1.zPositionFormatted()
       
        resultField.stringValue = particle1.distanceFormatted()
    }
    
    func updateSliders() {
        x1Slider.doubleValue = particle1.xPosition
        y1Slider.doubleValue = particle1.yPosition
        z1Slider.doubleValue = particle1.zPosition
        
    }

    @IBAction func fieldAction(_ sender: NSTextField) {
       
        if sender == x1Field{
            particle1.xPosition = x1Field.doubleValue
        }
        
        else if sender == y1Field{
            particle1.yPosition = y1Field.doubleValue
        }
        
        else if sender == z1Field{
            particle1.zPosition = z1Field.doubleValue
        }
        updateFields()
        updateSliders()
        
   }
    
    
    @IBAction func sliderAction(_ sender: NSSlider) {
        if sender == x1Slider{
            particle1.xPosition = x1Slider.doubleValue
        }
        
        else if sender == y1Slider{
            particle1.yPosition = y1Slider.doubleValue
        }
        
        else if sender == z1Slider{
            particle1.zPosition = z1Slider.doubleValue
        }
        
        updateFields()
        updateSliders()
    }
    

}

