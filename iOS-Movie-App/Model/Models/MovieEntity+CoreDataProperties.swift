//
//  MovieEntity+CoreDataProperties.swift
//  
//
//  Created by Burak Yılmaz on 11.06.2022.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var backdrop_path: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var title: String?

}
