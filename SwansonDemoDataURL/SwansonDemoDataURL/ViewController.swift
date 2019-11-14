//
//  ViewController.swift
//  SwansonDemoDataURL
//
//  Created by student on 10/8/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa

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


    func loadData(){
        let session = URLSession.shared
        guard let url = URL (string: "https://ron-swanson-quotes.herokuapp.com/v2/quotes") else {return}
        session.dataTask(with: url) { (data, response, error) in
            if let error = error { //if there is an error, print error and return
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("unknown response")
                return
            }
            
        }
    }
}

