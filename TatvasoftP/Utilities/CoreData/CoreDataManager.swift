//
//  CoreDataManager.swift
//  Mover Bol
//
//  Created by Jaydip on 11/06/20.
//  Copyright © 2020 Jaydip Savaliya. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {
    
    //MARK:- Variable
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TatvasoftP")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var context = persistentContainer.viewContext
    
    //MARK:- Init Funtion
    private init() {}
    
    func save () {
        if context.hasChanges {
            do {
                try context.save()
                print("saved coredata successfully")
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func saveUserData(tblName: String, success: @escaping (_ data: NSManagedObject) -> Void){
        let entity = NSEntityDescription.entity(forEntityName: tblName, in: context)
        let data = NSManagedObject(entity: entity!, insertInto: context)
        success(data)
    }
    
    
    func fetchData(tblName: String, success: @escaping (_ isSuccess: Bool, _ data: Any?) -> Void) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: tblName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let data = convertToJSONArray(data: result as! [NSManagedObject])
            success(true,data)
        } catch {
            print("Error while fetching data")
            success(false,nil)
        }
    }
    
    func updateData(tblName: String, kName: String, kValue: Int, success: @escaping (_ isSuccess: Bool,_ result:NSManagedObject?) -> Void){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: tblName)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate.init(format: "\(kName) = %d", kValue)
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let objToUpdate = result.first as? NSManagedObject else {
                print("No Record Found.")
                return
            }
            print("Update successfully")
            success(true,objToUpdate)
        } catch let error {
            print("error while updating data:\(error)")
            success(false,nil)
        }
    }
    
    func deleteSpecificRecord(tblName:String,kName: String,kValue: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: tblName)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate.init(format: "\(kName) = %@", "\(kValue)")
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let objToDelete = result.first as? NSManagedObject else {
                print("No Record Found.")
                return
            }
            if result.count > 1 {
                for object in result {
                    guard let objectData = object as? NSManagedObject else {continue}
                    context.delete(objectData)
                }
                print("there is \(result.count) record deleted.")
            }else{
                context.delete(objToDelete)
                print("1 record deleted.")
            }
        } catch let error {
            print("error while delete data:\(error)")
        }
        save()
    }
    func deleteAllData(_ tblName:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: tblName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
            print("\(tblName) deleted.")
        } catch let error {
            print("error while delete data:\(error)")
        }
        save()
    }
    
    //convert NSManagedObject to json array
    func convertToJSONArray(data: [NSManagedObject]) -> Any {
        var jsonArray: [[String: Any]] = []
        for item in data {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
    
}

//how to use

//fetch data

//func fetchData(){
//    CoreDataManager.shared.fetchData(tblName: "TblUserData") { (isSuccess, result) in
//        var arrData = result as? [[String:Any]] ?? []
//
//        /CoreDataManager.shared.deleteSpecificRecord(tblName: "TblUserData",
//    }
//}

//save data
//let arrData = result as? [[String:Any]] ?? []
//var id = Int(arrData.last?["id"] as? String ?? "0") ?? 0
//let imgData = (requestPrm["profile_photo"] as? UIImage)?.prepareImageForSaving()
//CoreDataManager.shared.saveUserData(tblName: "TblUserData") { (result) in
//    id += 1
//    result.setValue("\(id)", forKey: "id")
//    result.setValue(requestPrm["name"], forKey: "name")
//    result.setValue(requestPrm["email"], forKey: "email")
//    result.setValue(requestPrm["contact"], forKey: "contact")
//    result.setValue(requestPrm["birthdate"], forKey: "birthdate")
//    result.setValue(imgData, forKey: "profile_photo")
//    result.setValue(requestPrm["description"], forKey: "descri")
//
//    CoreDataManager.shared.save()
//
//    success(true)
//}
