//
//  FileReader.swift
//  DocumentationSorter
//
//  Created by David Ilenwabor on 23/04/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import Foundation

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
        
        completionHandler(categories)
    }
}
