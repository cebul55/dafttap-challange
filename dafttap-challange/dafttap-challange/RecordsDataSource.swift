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
        self.fetchData()
        self.sortData()
    }
    
    func saveData(numberOfClicks: Int, gameTime: String){
        //only invoked after checking that score is better than the lowest one keeped.
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
            self.sortData()
        } catch {
            print("Failed saving")
        }
        print("Records: ")
        print(records)
    }
    
    func fetchData(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            records = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could nod fetch. \(error), \(error.userInfo)" )
        }
    }
    
    func sortData(){
        records.sort(by: {
            if ($0.value(forKey: numberOfClicksKey) as! Int?)! == ($1.value(forKey: numberOfClicksKey) as! Int?)!
            {
                let format = DateFormatter()
                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date1 = format.date(from: ($0.value(forKey: gameTimeKey) as! String?)! )
                let date2 = format.date(from: ($1.value(forKey: gameTimeKey) as! String?)! )
                return date1! > date2!
            }
            else {
                return ($0.value(forKey: numberOfClicksKey) as! Int?)! > ($1.value(forKey: numberOfClicksKey) as! Int?)!
            }
        })
    }
    
    func getLowestRecord() -> Int {
        var lowestNumberOfCLicks = 1000000
        for record in records {
            if (record.value(forKey: numberOfClicksKey) as! Int?)! < lowestNumberOfCLicks {
                lowestNumberOfCLicks = (record.value(forKey: numberOfClicksKey) as! Int?)!
            }
        }
        if records.count == 0 {
            return 0
        }
        return lowestNumberOfCLicks
    }
    
    func removeLowestRecord() {
        //removes lowest and oldest record if more than one has the same numberOfClick
//        var tmpRecords : [NSManagedObject:Date] = [:]
//        for record in records {
//            if (record.value(forKey: numberOfClicksKey) as! Int?)! == getLowestRecord() {
//                context.delete(record)
//                let index = records.firstIndex(of: record)
//                records.remove(at: index!)
//                return
//            }
//        }
        let recordToDelete = records[records.count - 1]
        let index = records.lastIndex(of: recordToDelete)
        context.delete(recordToDelete)
        records.remove(at: index!)
    }

}
