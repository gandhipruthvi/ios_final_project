//
//  CoreDataService.swift
//  final_project
//
//  Created by Pruthvi Gandhi on 2021-12-15.
//

import Foundation
import CoreData

class CoreDateService {
    
    static var shared : CoreDateService = CoreDateService()
    //
    func getAllReminder() -> [Reminder]{
        var result = [Reminder]()
        
        // select * from ToDO oreder by task
        let fetch = Reminder.fetchRequest()
        
        // adding order by
        fetch.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: true)]
        //adding where clouse
        
        do{
            result = try persistentContainer.viewContext.fetch(fetch)
        }catch {}
        
        return result
    }
    func insertNewReminder(medicine: String, date:String){
        let newTask = Reminder(context: persistentContainer.viewContext)
        newTask.medicine = medicine
        newTask.date = date
        saveContext()
        
    }
    func deleteOneReminder(toDelete: Reminder){
        persistentContainer.viewContext.delete(toDelete)
        saveContext()
        
    }
   
    func updateReminder(oldReminder: Reminder, newReminder: String, newDate: String){
        // select * from ToDo where task == 'oldTask'
        var toUpdateTask : Reminder
        let str = oldReminder.medicine
        let fetchTask : NSFetchRequest = Reminder.fetchRequest()
        let predicate : NSPredicate = NSPredicate(format:  "medicine == %@", str as! CVarArg)
        fetchTask.predicate = predicate
        do{
            var array  = try persistentContainer.viewContext.fetch(fetchTask)
            
            toUpdateTask = array[0]
            toUpdateTask.medicine = newReminder
            toUpdateTask.date = newDate
            saveContext()
            
        }catch {}
        
        
    }




    func getAllTaskContains(str: String) -> [Reminder]{
        
        var result = [Reminder]()
        
        // select * from ToDo where task CONTAINS 'p'
        let fetch = Reminder.fetchRequest()
        
        if (!str.isEmpty){
//            NSPredicate(format: "task == %@ and date      BEGINSWITH %@ ", arguments: [v1,v2])
            let predicate = NSPredicate(format: "task BEGINSWITH [c] %@", str as CVarArg)
            fetch.predicate = predicate
        }
        do{
            result = try persistentContainer.viewContext.fetch(fetch)
        }catch {}
        
        return result
        
        
    }
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MedicineReminderApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context : NSManagedObjectContext = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
