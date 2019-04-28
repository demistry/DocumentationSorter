//
//  DocCategory+CoreDataProperties.swift
//  DocumentationSorter
//
//  Created by David Ilenwabor on 28/04/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//
//

import Foundation
import CoreData


extension DocCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DocCategory> {
        return NSFetchRequest<DocCategory>(entityName: "DocCategory")
    }

    @NSManaged public var title: String
    @NSManaged public var framework: NSSet

}

// MARK: Generated accessors for framework
extension DocCategory {

    @objc(addFrameworkObject:)
    @NSManaged public func addToFramework(_ value: DocFramework)

    @objc(removeFrameworkObject:)
    @NSManaged public func removeFromFramework(_ value: DocFramework)

    @objc(addFramework:)
    @NSManaged public func addToFramework(_ values: NSSet)

    @objc(removeFramework:)
    @NSManaged public func removeFromFramework(_ values: NSSet)

}
