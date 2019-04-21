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
    var category = Category(title: <#T##String#>, frameworks: <#T##[Frameworks]#>)
    fileprivate var frameworks = ["Core NFC", "Ehimwenma", "Oshioke", "Tester"]
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpButton.addItems(withTitles: frameworks)
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

