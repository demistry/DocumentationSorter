//
//  ExtensionUtil.swift
//  DocumentationSorter
//
//  Created by David Ilenwabor on 23/04/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import Foundation
import Cocoa

extension ViewController : NSTableViewDelegate, NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 30
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var identifier : NSUserInterfaceItemIdentifier
        var text : String = ""
        
        if tableColumn == tableView.tableColumns[0]{
            identifier = NSUserInterfaceItemIdentifier(rawValue: "frameworkCell")
            text = "Core Animation"
        } else{
            identifier = NSUserInterfaceItemIdentifier(rawValue: "dateCell")
            text = "21/04/2019"
        }
        let cell = tableView.makeView(withIdentifier: identifier, owner: nil) as! NSTableCellView
        cell.textField?.stringValue = text
        return cell
    }
    
}
