//
//  DataBaseHelper.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/22/23.
//

import Foundation
import UIKit
import CoreData

class DataBaseHelper {

    
    private let controller: NSFetchedResultsController<Show>
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {fatalError()}
        let request = Show.fetchRequest()
        let managedContext = appDelegate.persistentContainer.viewContext
        controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func requestFavorites(completion: @escaping ((Result<[Show], Error>) -> Void)) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError()}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Show")

        controller.managedObjectContext.performAndWait {
   
            do {
                try self.controller.performFetch()
                let savedMovies = try managedContext.fetch(fetchRequest) as? [Show]
                completion(.success(savedMovies ?? []))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func save(movie: ShowToCoreData) {
        controller.managedObjectContext.performAndWait {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Show",in: managedContext)!
            let show = Show(entity: entity, insertInto: managedContext)
                 
            show.name = movie.name
            show.imageUrl = movie.imageURL
            show.summary = movie.summary
            show.id = movie.id
            
            self.controller.managedObjectContext.insert(show)
            try? self.controller.managedObjectContext.save()
        }
    }
    
    func delete(movie: Show) {
        
        controller.managedObjectContext.performAndWait {
            self.controller.managedObjectContext.delete(movie)
            try? self.controller.managedObjectContext.save()
        }
    }
    
}


@objc(Show)
public class Show: NSManagedObject {
    

}


extension Show {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Show> {
       
        let request = NSFetchRequest<Show>(entityName:"Show")
        request.sortDescriptors = []
        return request
        
    }

    @NSManaged public var name: String
    @NSManaged public var summary: String
    @NSManaged public var imageUrl: String
    @NSManaged public var id: Int

}

extension Show : Identifiable {

}
