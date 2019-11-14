//
//  ViewController.swift
//  SwansonDemo
//
//
//  Demo for using URLSession to get a JSON response from a web server.
//
//  Info about this data source. https://github.com/jamesseanwright/ron-swanson-quotes#ron-swanson-quotes-api

// General process!!
//1. request url from server.
//2. recieve response from server.
//3. decode response from server.
//4. convert response to swift object.


import Cocoa


// Quote struct is used for decoding the JSON response into a data structure
// that will be easy to work with in this app.

struct Quote: Codable {
    var text: String
    
    // This initializer is needed because the JSON data we get from this
    // server is "unkeyed".
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        text = try container.decode(String.self)
    }
}

class ViewController: NSViewController {

    // use this NSTextField to display the quote
    @IBOutlet var quoteLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    
    // Get one quote from the service.
    func loadData() {
        let session = URLSession.shared
        
        guard let url = URL(string:"https://ron-swanson-quotes.herokuapp.com/v2/quotes") else { return }
        
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
            guard let quote = try? decoder.decode(Quote.self, from: data) else { return }
            
            print("***** Decoded String *****")
            print(quote.text)
            
            DispatchQueue.main.async {
                // Update the UI on the main thread.
                self.quoteLabel.stringValue = quote.text
            }
            
        })
        
        task.resume()
        
    } // end of loadData function

   
    // Reload to get another quote.
    @IBAction func reload(_ sender: NSButton) {
        loadData()
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
    

}

