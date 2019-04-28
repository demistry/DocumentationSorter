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
    
    internal var savedFrameworks : [SelectedFrameworkObject] = []{
        didSet{
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    override func viewWillAppear() {
        FileReader.readJSON { (categories) in
            self.categories = categories
        }
        fetchDataFromCoreData()
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
        let selectedFrameworkObject = SelectedFrameworkObject(categoryTitle: categoryPopUpButton.titleOfSelectedItem!, frameworkTitle: frameworkPopUpButton.titleOfSelectedItem!, dateOfSelection: convertDateToString(date: Date()))
        CoreDataUtil.saveToCoreData(selectedFrameworkObject: selectedFrameworkObject)
        fetchDataFromCoreData()
    }
    
    fileprivate func fetchDataFromCoreData(){
        CoreDataUtil.readFromCoreData { (result) in
            switch result{
            case .success(let selectedFrameworks):
                self.savedFrameworks = selectedFrameworks
            case .failure(let error):
                print("Error encountered is \(error)")
            }
        }
    }
}


