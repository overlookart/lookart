//
//  PersistentContainer.swift
//  LookArt
//
//  Created by CaiGou on 2023/6/12.
//

import CoreData
class PersistentContainer: NSPersistentContainer {
    func saveContext(backgroundContext: NSManagedObjectContext? = nil){
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
    func deleteStore(name: String) {
        var url = NSURL.fileURL(withPath: NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0])
        
            
        url.appendPathComponent(name + ".sqlite")
        debugPrint(url)

        do {
            try FileManager.default.removeItem(at: url)
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
        
        do {
            try persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType)
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
