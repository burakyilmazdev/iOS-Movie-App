//
//  CoreDataManager.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 18.06.2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager{
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

   static func createFetchResultsController() -> NSFetchedResultsController<MovieEntity>{
        let request:NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(keyPath: \MovieEntity.title, ascending: false)
        
        request.sortDescriptors = [sortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
    }
    
    
}
