//
//  ViewController.swift
//  DocumentationSorter
//
//  Created by David Ilenwabor on 17/04/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var frameworkPopUpButton: NSPopUpButton!
    @IBOutlet weak var categoryPopUpButton: NSPopUpButton!
    @IBOutlet weak var tableView: NSTableView!
    
    fileprivate var categoryShuffler : Int!
    fileprivate var frameworkShuffler : Int!
    fileprivate var categories : [Category] = []{
        didSet{
            var categoryStringArray : [String] = []
            var frameworkStringArray : [String] = []
            for category in categories{
                categoryStringArray.append(category.title)
            }
            for framework in categories[0].frameworks{
                frameworkStringArray.append(framework.title)
            }
            categoryPopUpButton.addItems(withTitles: categoryStringArray)
            frameworkPopUpButton.addItems(withTitles: frameworkStringArray)
        }
    }
    //fileprivate var frameworks = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //popUpButton.addItems(withTitles: frameworks)
        tableView.delegate = self
        tableView.dataSource = self
        
        FileReader.readJSON { (categories) in
            self.categories = categories
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func categorySelected(_ sender: NSPopUpButton) {
        let titleSelected = sender.titleOfSelectedItem
        var selectedFrameworks : [Frameworks] = []
        var frameworkStrings : [String] = []
        for category in categories{
            if category.title.elementsEqual(titleSelected!){
                selectedFrameworks = category.frameworks
            }
        }
        
        for framework in selectedFrameworks{
            frameworkStrings.append(framework.title)
        }
        frameworkPopUpButton.removeAllItems()
        frameworkPopUpButton.addItems(withTitles: frameworkStrings)
    }
    @IBAction func shuffleCategoryAndFramework(_ sender: NSButton) {
        categoryShuffler = Int(arc4random_uniform(UInt32(categories.count)))
        
        print("Category shuffler picks \(categoryShuffler!)")
        
        categoryPopUpButton.selectItem(at: categoryShuffler)
        let titleSelected = categoryPopUpButton.titleOfSelectedItem
        var frameworkStrings : [String] = []
        var selectedFrameworks : [Frameworks] = []
        for category in categories{
            if category.title.elementsEqual(titleSelected!){
                selectedFrameworks = category.frameworks
            }
        }
        
        for framework in selectedFrameworks{
            frameworkStrings.append(framework.title)
        }
        
        frameworkPopUpButton.removeAllItems()
        frameworkPopUpButton.addItems(withTitles: frameworkStrings)
        frameworkShuffler = Int(arc4random_uniform(UInt32(selectedFrameworks.count)))
        print("Framework shuffler picks \(frameworkShuffler!)")
        frameworkPopUpButton.selectItem(at: frameworkShuffler)
    }
    
    @IBAction func selectFrameworkAndSaveData(_ sender: NSButton) {
    }
    
}


