//
//  Category.swift
//  DocumentationSorter
//
//  Created by David Ilenwabor on 21/04/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import Foundation


struct Category : Codable{
    var title : String
    var frameworks : [Frameworks]
    
    func getCategory(title : String)->Category?{
        if title.elementsEqual(self.title){
            return self
        } else{
            return nil
        }
    }
}

struct Frameworks : Codable{
    var title : String
}
