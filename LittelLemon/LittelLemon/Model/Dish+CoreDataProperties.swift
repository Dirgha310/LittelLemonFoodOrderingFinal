//
//  Dish+CoreDataProperties.swift
//  LittleLemon
//
//  Created by Dirgha Kathiriya on 09/08/2023.
//
//

import Foundation
import CoreData


extension Dish1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var category: String?
    @NSManaged public var dishDescription: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var title: String?

}

extension Dish1 : Identifiable {

}
