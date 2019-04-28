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
        return savedFrameworks.count > 0 ? savedFrameworks.count : 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var identifier : NSUserInterfaceItemIdentifier
        var text : String = ""
        let selectedFramework =  savedFrameworks[row]
        if tableColumn == tableView.tableColumns[0]{
            identifier = NSUserInterfaceItemIdentifier(rawValue: "frameworkCell")
            text = selectedFramework.frameworkTitle
        } else if tableColumn == tableView.tableColumns[1]{
            identifier = NSUserInterfaceItemIdentifier(rawValue: "categoryCell")
            text = selectedFramework.categoryTitle
        } else{
            identifier = NSUserInterfaceItemIdentifier(rawValue: "dateCell")
            text = selectedFramework.dateOfSelection
        }
        let cell = tableView.makeView(withIdentifier: identifier, owner: nil) as! NSTableCellView
        cell.textField?.stringValue = text
        return cell
    }
    
    func convertDateToString(date : Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: date)
    }
    
}
