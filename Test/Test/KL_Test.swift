//
//  KL_Test.swift
//  Test
//
//  Created by bcmac3 on 16/5/6.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(CollectGank)
class KL_Test: NSManagedObject {
    static let app =  UIApplication.sharedApplication().delegate as! AppDelegate
    static let context = app.managedObjectContext

    // 插入
    static func insert(model: KL_Test) {
        let collectGank = NSEntityDescription.insertNewObjectForEntityForName("KL_Test",inManagedObjectContext: context) as! KL_Test
        collectGank.name = model.name
        collectGank.age = model.age
        do {
            try context.save()
            print("成功")
        }catch {
            fatalError("不能保存\(error)")
        }
    }

    // 查询所有的数据并返回
    static func fetch() -> [KL_Test] {
        var array = [KL_Test]()
        //声明数据的请求
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("KL_Test",                  inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            
            //遍历查询的结果
            print(fetchedObjects)
            array = fetchedObjects as! [KL_Test]
            
        }catch {
            fatalError("不能保存：\(error)")
        }
        return array
    }

    // 修改
    static func update(gank: KL_Test) {
        //声明数据的请求
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("KL_Test",                  inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        let predicate = NSPredicate(format: "name = 'kellen' ")
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            
            //遍历查询的结果
            print(fetchedObjects)
            try context.save()
        }catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    // 是否存在（查找）
    static func exist(gank: KL_Test) -> Bool {
        //声明数据的请求
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("KL_Test",                  inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        //设置查询条件
        let predicate = NSPredicate(format: "name = '\(gank.name)' ")
        fetchRequest.predicate = predicate
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            //遍历查询的结果
            guard (fetchedObjects != nil && fetchedObjects!.count > 0) else {
                return false
            }
            return true
        }catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    // 删除
    static func deleted(gank: KL_Test) {
        //声明数据的请求
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("CollectGank",                  inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        let predicate = NSPredicate(format: "name = '\(gank.name)'")
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            print(fetchedObjects)
            //遍历查询的结果
            for info:KL_Test in fetchedObjects as! [KL_Test]{
                //删除对象
                context.deleteObject(info)
            }
            //重新保存-更新到数据库
            try context.save()
            
        }catch {
            fatalError("不能保存：\(error)")
        }
    }
}
