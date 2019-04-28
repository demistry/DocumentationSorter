//
//  FileReader.swift
//  DocumentationSorter
//
//  Created by David Ilenwabor on 23/04/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import Foundation
import Cocoa

class FileReader{
    typealias completionHandler = ([Category]) -> Void
    class func readJSON(completionHandler : @escaping completionHandler){
        guard let path = Bundle.main.path(forResource: "Documentation", ofType: "json") else{
            return
        }
        print("Path is \(path)")
        let jsonData =  try! Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe)
        
        //print("Agenda JSON Data is \(jsonData)")
        let jsonResult = try! JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        
        //print("Local JSON Result is \(jsonResult)")
        
        let jsonDataNew = try! JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
        let jsonString = String(data: jsonDataNew, encoding: .utf8)
        let data = jsonString!.data(using : .utf8)
        let jsonDecoder = JSONDecoder()
        let categories = try! jsonDecoder.decode([Category].self, from: data!)
        
        saveCoreData(categories: categories)
        completionHandler(categories)
    }
    
    
    fileprivate class func saveCoreData(categories : [Category]){
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DocCategory", in: managedContext)!
        let frameworkEntity = NSEntityDescription.entity(forEntityName: "DocFramework", in: managedContext)!
        
        for category in categories{
            let docCategory = DocCategory(entity: entity, insertInto: managedContext)
            //let docCategoryCreated = DocCategory(
            docCategory.title = category.title
            
            for framework in category.frameworks{
                let docFramework = DocFramework(entity: frameworkEntity, insertInto: managedContext)
                docFramework.title = framework.title
                docFramework.category = docCategory
            }
            
        }
        
        do{
            try managedContext.save()
            UserDefaults.standard.set(true, forKey: "savedFlag")
            print("Categories saved")
        } catch{
            print("Failed to save category objects to core data with error \(error.localizedDescription)")
        }
    }
    
//    class func retrieveCategoryInfo()->[DocCategory]{
//        
//    }
}
