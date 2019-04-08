//
//  AppDelegate.swift
//  Todoey
//
//  Created by Salvatore La spina on 06/04/2019.
//  Copyright © 2019 Salvatore La spina. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
 //      print(Realm.Configuration.defaultConfiguration.fileURL)
    
        
        
        do{
            _ = try Realm()
        }catch {
            print("Error initializing new realm \(error)")
        }
        
        return true
    }


}

