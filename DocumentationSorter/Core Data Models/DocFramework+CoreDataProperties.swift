//
//  DocFramework+CoreDataProperties.swift
//  DocumentationSorter
//
//  Created by David Ilenwabor on 28/04/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//
//

import Foundation
import CoreData


extension DocFramework {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DocFramework> {
        return NSFetchRequest<DocFramework>(entityName: "DocFramework")
    }

    @NSManaged public var title: String
    @NSManaged public var category: DocCategory

}
