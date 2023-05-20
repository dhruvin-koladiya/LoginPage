//
// AppDelegate.swift
// LoginPageUI
//
// Created by R82 on 27/12/22.
//
import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var databasePath: String = ""
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppDelegate.databasePath = getDatabasePath()
        return true
    }
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions
                     sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not
        //running, this will be called shortly after
        //application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to
        //the discarded scenes, as they will not return.
    }
    
    func getDatabasePath() -> String{
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let databaseMainBundlePath = Bundle.main.path(forResource:"registration", ofType: "db")
        print(databaseMainBundlePath)
        print(documentDirectoryPath)
        let databasePath = documentDirectoryPath[0] + "/" + "registration.db"
        let fileManager = FileManager()
        if fileManager.fileExists(atPath: databasePath) == false {
            print("Copy the file")
            do{
                try fileManager.copyItem(atPath: databaseMainBundlePath ?? "", toPath: databasePath)
                return databasePath
            } catch {
                print("Something went wrong")
                return ""
            }
        }
        return databasePath
        
    }
}
