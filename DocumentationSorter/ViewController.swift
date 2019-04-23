//
//  ViewController.swift
//  DocumentationSorter
//
//  Created by David Ilenwabor on 17/04/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var popUpButton: NSPopUpButton!
    
    @IBOutlet weak var tableView: NSTableView!
    //var category = Category(title: <#T##String#>, frameworks: <#T##[Frameworks]#>)
    fileprivate var frameworks = ["Core Animation", "Ehimwenma", "Oshioke", "Tester"]
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpButton.addItems(withTitles: frameworks)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

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

