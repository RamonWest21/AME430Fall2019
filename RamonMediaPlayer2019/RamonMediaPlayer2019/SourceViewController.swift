//
//  SourceViewController.swift
//  RamonMediaPlayer2019
//
//  Created by student on 9/24/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa

class SourceViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var mediaURLs: [URL] = []
    
    @IBOutlet var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do View setup here
        mediaURLs = unarchiveURLs()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return mediaURLs.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else {return nil}
        
            cell.textField?.stringValue = mediaURLs[row].lastPathComponent
        
            return cell
    }
    
    override var acceptsFirstResponder: Bool{ return true}
    
    @IBAction func openDocument(_ sender: NSMenuItem){
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false
        let response = openPanel.runModal()
        
        if response == .OK {
            print("ok")
            if let url = openPanel.url {
                mediaURLs.append(url)
                tableView.reloadData()
            }
        }
        else {
            print("User hit cancel")
        }
        
    }
    
    // Unarchive. Load from disc
    func unarchiveURLs() -> [URL] {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{ return [] }
        let archiveURL = documentsDirectory.appendingPathComponent("PlaylistForPlayer").appendingPathExtension("plist")
        let decoder = PropertyListDecoder()
        
        if let retrievedData = try? Data(contentsOf: archiveURL), let decodedURLs = try? decoder.decode(Array<URL>.self, from: retrievedData){
            print("Read \(decodedURLs.count) items from property list.")
            return decodedURLs
        }
        
        print("Did not find, could not read property list")
        return []
    }
    
    func archiveURLs(urls: [URL]){
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{ return }
        let archiveURL = documentsDirectory.appendingPathComponent("PlaylistForPlayer").appendingPathExtension("plist")
        
        let encoder = PropertyListEncoder()
        
        if let endodedURLs = try? encoder.encode(urls) {
            do {
                try endodedURLs.write(to: archiveURL)
                print("finished writing to property list")
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    // NSTableViewDataSource
    func tableViewSelectionDidChange(_ notification: Notification) {
        print("T")
        let url = mediaURLs[tableView.selectedRow]
        print("the selected url is \(url.lastPathComponent)")
        
        guard let splitVC = parent as? NSSplitViewController else {return}
        
       if let playerVC = splitVC.children[1] as? ViewController {
            playerVC.openMovie(url: urls)
       }
    }
}

