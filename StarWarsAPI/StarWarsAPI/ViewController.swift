//
//  ViewController.swift
//  StarWarsAPI
//
//  Created by student on 10/22/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var nameLabel: NSTextField!
    @IBOutlet weak var heightLabel: NSTextField!
    @IBOutlet weak var birthYearLabel: NSTextField!
    @IBOutlet weak var genderLabel: NSTextField!
    @IBOutlet weak var iconImage: NSImageView!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var indexTextBox: NSTextField!
    @IBOutlet weak var homeWorldLabel: NSTextField!
    
    var id = Int.random(in: 0 ... 88)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    // Get one character from the service.
    func loadData() {
        let session = URLSession.shared
        guard let url = URL(string:"https://swapi.co/api/people/" + String(id))
            else { return }
//        guard let url = URL(string:"https://swapi.co/api/people/67")
//            else { return }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let error = error as NSError? {
                    // There was an error. Report it to the user, and done.
                    print("***** Error *****")
                    print(error)
                    self.reportError(error: error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    // Something has gone terribly wrong, there was no HTTP response.
                    print("unknown response")
                    return
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    // The HTTP status code is an error. Report it to the user, and done.
                    print("http response code \(httpResponse.statusCode)")
                    self.reportStatus(code: httpResponse.statusCode)
                    return
                }
            
                print("***** Here is the HttpResponse: ******")
                print(httpResponse)
            
                // Unwrap the data object.
                guard let data = data else { return }
            
                if let string = String(data: data, encoding: .utf8) {
                    print("***** Here is the data as a string *****")
                    print(string)
                }
            
                // Decode the JSON response.
            
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
    
                var person: people!
                do {
                    person = try decoder.decode(people.self, from: data)
                }
                catch {
                    print(error)
                    return
                }
            
                print("***** Decoded String *****")
                print("Name: " + person.name)
                print("Height: " + person.height)
                print("Birth Year: " + person.birthYear)
                print("Gender: " + person.gender)
            
            
               // loadHomeworld(person.homeworld)
            
                DispatchQueue.main.async {
                    // Update the UI on the main thread.
                    self.indexTextBox.stringValue = String(self.id)
                    self.nameLabel.stringValue = person.name
                    self.heightLabel.stringValue = person.height
                    self.birthYearLabel.stringValue = person.birthYear
                    self.genderLabel.stringValue = person.gender
                    self.iconImage.image = NSImage(named: person.name)
                    self.loadHomeWorld(worldURLString: person.homeworld)
                    
                }
        })
        
        task.resume()
    } // end of loadData function
    
    // Reload to get another quote.
    @IBAction func reload(_ sender: NSButton) {
        id = Int(indexTextBox.stringValue) ?? 1
        loadData()
    }
    
    @IBAction func incrementCount(_ sender: Any) {
        incrementID()
    }
    
    @IBAction func decrementCount(_ sender: Any) {
        decrementID()
    }
    
    
    func incrementID(){
        if id == 88{
            id = 88
        }
        else{
            id += 1
            loadData()
        }
    }
    func decrementID(){
        if id == 1{
            id = 1
        }
        else{
            id -= 1
            loadData()
        }
    }
    
    // Report the status code to the user.
    // In production, you should provide better info.
    func reportStatus(code: Int) {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = "HTTP Status Code \(code)"
            alert.informativeText = "The HTTP server returned an error status code."
            alert.alertStyle = .critical
            alert.addButton(withTitle: "Ok")
            alert.runModal()
        }
    }
    
    // Report the error directly to the user.
    func reportError(error: NSError) {
        DispatchQueue.main.async {
            let alert = NSAlert(error: error)
            alert.runModal()
            
        }
    }
    
    func loadHomeWorld(worldURLString: String) {
        let session = URLSession.shared
        guard let worldURL = URL(string:worldURLString)
            else { return }
        
        let task = session.dataTask(with: worldURL, completionHandler: { data, response, error in
            if let error = error as NSError? {
                // There was an error. Report it to the user, and done.
                print("***** Error *****")
                print(error)
                self.reportError(error: error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                // Something has gone terribly wrong, there was no HTTP response.
                print("unknown response")
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                // The HTTP status code is an error. Report it to the user, and done.
                print("http response code \(httpResponse.statusCode)")
                self.reportStatus(code: httpResponse.statusCode)
                return
            }
            
            print("***** Here is the HttpResponse: ******")
            print(httpResponse)
            
            // Unwrap the data object.
            guard let data = data else { return }
            
            if let string = String(data: data, encoding: .utf8) {
                print("***** Here is the data as a string *****")
                print(string)
            }
            
            // Decode the JSON response.
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            var planet: planets!
            do {
                planet = try decoder.decode(planets.self, from: data)
            }
            catch {
                print(error)
                return
            }
            
            print("***** Decoded String *****")
            print("HomeWorld: " + planet.name)
            
            
            // loadHomeworld(person.homeworld)
            
            DispatchQueue.main.async {
                // Update the UI on the main thread.
                
                self.homeWorldLabel.stringValue = planet.name
                
            }
        })
        
        task.resume()
    } // end of loadData function
    
}

