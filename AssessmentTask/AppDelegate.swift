//
//  AppDelegate.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
let defaults: UserDefaults = UserDefaults.standard

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        if defaults.isLoggedIn {
            let homeVC = HomeViewController.instantiate(fromAppStoryboard: .main)
            let navController = UINavigationController(rootViewController: homeVC)
            self.window?.rootViewController = navController
        } else {
            if let onboardingVC = OnboardingViewController.instantiateFromNib() {
                self.window?.rootViewController = UINavigationController(rootViewController: onboardingVC)
            }
        }
        return true
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "AssessmentTask")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
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
