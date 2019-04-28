//
//  CoreDataUtil.swift
//  DocumentationSorter
//
//  Created by David Ilenwabor on 23/04/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import Foundation
import CoreData
import Cocoa

class CoreDataUtil{
    
    typealias fetchCompletionHandler = (Result<[SelectedFrameworkObject], Error>)->Void
    class func saveToCoreData(selectedFrameworkObject : SelectedFrameworkObject){
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SelectedFramework", in: managedContext)!
        let selectedFramework = NSManagedObject(entity: entity, insertInto: managedContext)
        
        selectedFramework.setValue(selectedFrameworkObject.categoryTitle, forKey: "category")
        selectedFramework.setValue(selectedFrameworkObject.frameworkTitle, forKey: "framework")
        selectedFramework.setValue(selectedFrameworkObject.dateOfSelection, forKey: "dateOfSelection")
        
        do{
            try managedContext.save()
            print("Saved to core data")
        }catch{
            print("Could not save due to error \(error.localizedDescription)")
        }
    }
    
    class func readFromCoreData(fetchCompletionHandler : @escaping fetchCompletionHandler){
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SelectedFramework")
        
        do{
            let fetchResult = try managedContext.fetch(fetchRequest) //NSManagedObject
            var selectedFrameworkArray : [SelectedFrameworkObject] = []
            for fetch in fetchResult{
                let category = fetch.value(forKey: "category") as! String
                let framework = fetch.value(forKey: "framework") as! String
                let dateOfSelection = fetch.value(forKey: "dateOfSelection") as! String
                let selectedFrameworkObject = SelectedFrameworkObject(categoryTitle: category, frameworkTitle: framework, dateOfSelection: dateOfSelection)
                selectedFrameworkArray.append(selectedFrameworkObject)
            }
            fetchCompletionHandler(.success(selectedFrameworkArray))
            print("Fetch complete from core data")
        } catch{
            print("Could not fetch details due to error \(error.localizedDescription)")
            fetchCompletionHandler(.failure(error))
        }
    }
    
    
    
    
     
}
