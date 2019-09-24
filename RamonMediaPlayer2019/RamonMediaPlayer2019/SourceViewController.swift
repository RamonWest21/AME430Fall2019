//
//  SourceViewController.swift
//  RamonMediaPlayer2019
//
//  Created by student on 9/24/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa

class SourceViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var names: [String] = ["AZ", "NV", "NM", "CA"]
    @IBOutlet var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do View setup here
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else {return nil}
        
            cell.textField?.stringValue = names[row]
        
            return cell
    }
}

