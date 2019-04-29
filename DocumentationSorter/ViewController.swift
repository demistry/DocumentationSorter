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
    fileprivate var categories : [DocCategory] = []{
        didSet{
            var categoryStringArray : [String] = []
            var frameworkStringArray : [String] = []
            for category in categories{
                categoryStringArray.append(category.title)
            }
            for framework in categories[0].framework{
                let frameworkCasted = framework as! DocFramework
                frameworkStringArray.append(frameworkCasted.title)
            }
            let sortedFramework = frameworkStringArray.sorted { (string1, string2) -> Bool in
                return string1 < string2
            }
            categoryPopUpButton.removeAllItems()
            frameworkPopUpButton.removeAllItems()
            categoryPopUpButton.addItems(withTitles: categoryStringArray)
            frameworkPopUpButton.addItems(withTitles: sortedFramework)
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
//        FileReader.readJSON { (categories) in
//            self.categories = categories
//        }
        let loginFlag = UserDefaults.standard.bool(forKey: "savedFlag")
        if loginFlag {
            FileReader.retrieveCategoryInfo { (result) in
                switch result{
                case .success(let category):
                    self.categories = category
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            print("Flag set")
            
        } else{
            FileReader.readJSON { (category) in
                
            }
        }
        
        
        fetchDataFromCoreData()
    }

    @IBAction func categorySelected(_ sender: NSPopUpButton) {
        let titleSelected = sender.titleOfSelectedItem
        var selectedFrameworks : [DocFramework] = []
        var frameworkStrings : [String] = []
        for category in categories{
            if category.title.elementsEqual(titleSelected!){
                for framework in category.framework{
                    selectedFrameworks.append(framework as! DocFramework)
                }
                
            }
        }
        
        for framework in selectedFrameworks{
            frameworkStrings.append(framework.title)
        }
        let sortedFramework = frameworkStrings.sorted { (string1, string2) -> Bool in
            return string1 < string2
        }
        frameworkPopUpButton.removeAllItems()
        frameworkPopUpButton.addItems(withTitles: sortedFramework)
    }
    @IBAction func shuffleCategoryAndFramework(_ sender: NSButton) {
        categoryShuffler = Int(arc4random_uniform(UInt32(categories.count)))
        print("Categories count is \(categories.count)")
        print("Category shuffler picks \(categoryShuffler!)")
        
        categoryPopUpButton.selectItem(at: categoryShuffler)
        let titleSelected = categoryPopUpButton.titleOfSelectedItem
        var frameworkStrings : [String] = []
        var selectedFrameworks : [DocFramework] = []
        for category in categories{
            if category.title.elementsEqual(titleSelected!){
                for framework in category.framework{
                    selectedFrameworks.append(framework as! DocFramework)
                }
            }
        }
        
        for framework in selectedFrameworks{
            frameworkStrings.append(framework.title)
        }
        
        let sortedFramework = frameworkStrings.sorted { (string1, string2) -> Bool in
            return string1 < string2
        }
        
        frameworkPopUpButton.removeAllItems()
        frameworkPopUpButton.addItems(withTitles: sortedFramework)
        frameworkShuffler = Int(arc4random_uniform(UInt32(selectedFrameworks.count)))
        print("Framework shuffler picks \(frameworkShuffler!)")
        frameworkPopUpButton.selectItem(at: frameworkShuffler)
    }
    
    @IBAction func selectFrameworkAndSaveData(_ sender: NSButton) {
        let selectedFrameworkObject = SelectedFrameworkObject(categoryTitle: categoryPopUpButton.titleOfSelectedItem!, frameworkTitle: frameworkPopUpButton.titleOfSelectedItem!, dateOfSelection: convertDateToString(date: Date()))
        CoreDataUtil.saveToCoreData(selectedFrameworkObject: selectedFrameworkObject)
        fetchDataFromCoreData()
        deleteData(titleSelected: categoryPopUpButton.titleOfSelectedItem!, frameworkTitleSelected: frameworkPopUpButton.titleOfSelectedItem!)
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
    
    fileprivate func deleteData(titleSelected : String, frameworkTitleSelected : String){
    
        for category in categories{
            if category.title.elementsEqual(titleSelected){
                for framework in category.framework{
                    let castedFramework = framework as! DocFramework
                    if castedFramework.title.elementsEqual(frameworkTitleSelected){
                        print("Framework deleted")
                        category.removeFromFramework(castedFramework)
                    }
                }
            }
        }
    }
}


