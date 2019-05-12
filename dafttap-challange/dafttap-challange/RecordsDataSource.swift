//
//  RecordsDataSource.swift
//  dafttap-challange
//
//  Created by Bartosz Cybulski on 12/05/2019.
//  Copyright © 2019 Bartosz Cybulski. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RecordsDataSource {
    
    let entityName = "Records"
    let numberOfClicksKey = "numberOfClicks"
    let gameTimeKey = "gameTime"
    let context : NSManagedObjectContext
    var records: [NSManagedObject] = []
    
    init(context : NSManagedObjectContext){
        self.context = context
    }
    
    func saveData(numberOfClicks: Int, gameTime: Date){
        //only invoked after checking that score is better than the lowest one keeped.
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context )
        let newRecord = NSManagedObject(entity: entity!, insertInto: context)
        newRecord.setValue(gameTime, forKeyPath: gameTimeKey)
        newRecord.setValue(numberOfClicks, forKey: numberOfClicksKey)
        
        do {
            while(records.count > 4){
                removeLowestRecord()
            }
            try context.save()
            records.append(newRecord)
        } catch {
            print("Failed saving")
        }
        print("Records: ")
        print(records)
    }
    
    func fetchData(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            records = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could nod fetch. \(error), \(error.userInfo)" )
        }
    }
    
    func getLowestRecord() -> Int {
        var lowestNumberOfCLicks = 1000000
        for record in records {
            if (record.value(forKey: numberOfClicksKey) as! Int?)! < lowestNumberOfCLicks {
                lowestNumberOfCLicks = (record.value(forKey: numberOfClicksKey) as! Int?)!
            }
        }
        return lowestNumberOfCLicks
    }
    
    func removeLowestRecord() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        let context = appDelegate.persistentContainer.viewContext
        for record in records {
            if (record.value(forKey: numberOfClicksKey) as! Int?)! == getLowestRecord() {
                context.delete(record)
                let index = records.firstIndex(of: record)
                records.remove(at: index!)
                return
            }
        }
    }

}
