//
//  AppDelegate.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 5/8/21.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK: - Properties
    var window: UIWindow?

    //MARK: - Application Functions
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: - Dynamics Link Handlers
    func handleIncomingDynamicLink(_ dynamicLink: DynamicLink) {
        guard let url = dynamicLink.url else {
            print("That's weird my dynamic link has no url")
            return
        }
        print("Your incoming link parameter is \(url.absoluteString)")
        
        guard (dynamicLink.matchType == .unique || dynamicLink.matchType == .default) else {
            print("Not a strong enough match type to continue")
            return
        }

        //Parse the link Parameter
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {return}
        
        for queryItem in queryItems {
            print("Parameter \(queryItem.name) has a value of \(queryItem.value ?? "")")
        }
        if components.path == "/events" {
            //loading a specific event
            if let eventIDQueryItem = queryItems.first(where: {$0.name == "id"}) {
                guard let id = eventIDQueryItem.value else {return}
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                guard let newDetailVC = storyboard.instantiateViewController(withIdentifier: "PlannerViewController") as?
                        PlannerViewController else {return}
                EventController.shared.fetchEventWith(id: id) { success in
                    switch success {
                    
                    case true:
                        newDetailVC.event = EventController.shared.eventDynamicLink
                        (self.window?.rootViewController as? UINavigationController)?.popToViewController(newDetailVC, animated: true)

                    case false:
                        print("Unable to find event with id: \(id)")
                    }
                }
            }
        }
    }
    
    private func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            print("Incoming url in \(incomingURL)")
            let linkHandled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL)
            { (dynamicLink, err) in
                guard err == nil else {
                    print("Found an error! \(err!.localizedDescription)")
                    return
                }
                if let dynamicLink = dynamicLink {
                    self.handleIncomingDynamicLink(dynamicLink)
                }
            }
            if linkHandled {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("I have received a URL through a custom scheme! \(url.absoluteString)")
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            self.handleIncomingDynamicLink(dynamicLink)
            return true
        } else {
            //maybe handle google or facebook sign in here
            return false
        }
    }
}

