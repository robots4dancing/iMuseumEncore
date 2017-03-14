//
//  AppDelegate.swift
//  iMuseumEncore
//
//  Created by Valerie Greer on 3/14/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var masterMuseumArray = [Museum]()
    let hostName = "https://data.imls.gov/resource/et8i-mnha.json"
    
    func parseJson(data: Data) {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            print("JSON:\(jsonResult)")
            let museumArray = jsonResult as! [[String:Any]]
            masterMuseumArray.removeAll()
            for museumDictionary in museumArray {
                guard let museumName = museumDictionary["commonname"] as? String else {
                    continue
                }
                guard let museumStreet = museumDictionary["location_1_address"] as? String else {
                    continue
                }
                guard let museumCity = museumDictionary["location_1_city"] as? String else {
                    continue
                }
                guard let museumState = museumDictionary["location_1_state"] as? String else {
                    continue
                }
                guard let museumZip = museumDictionary["location_1_zip"] as? String else {
                    continue
                }
                guard let location = museumDictionary["location_1"] as? [String:Any] else {
                    continue
                }
                guard let point = location["coordinates"] as? [Double]? else {
                    continue
                }
                guard let museumLon = point?[0] else {
                    continue
                }
                guard let museumLat = point?[1] else {
                    continue
                }
                
                let newMuseum = Museum(museumName: museumName, museumStreet: museumStreet, museumCity: museumCity, museumState: museumState, museumZip: museumZip, museumLon: museumLon, museumLat: museumLat)
                masterMuseumArray.append(newMuseum)
            }
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .reload, object: nil)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
        } catch {
            print("JSON Parsing Error")
        }
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func getFile() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let urlString = hostName
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let receivedData = data else {
                print("No Data")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            if receivedData.count > 0 && error == nil {
                print("Received Data:\(receivedData)")
                let dataString = String.init(data: receivedData, encoding: .utf8)
                print("Got Data String:\(dataString!)")
                self.parseJson(data: receivedData)
            } else {
                print("Got Data of Length 0")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        task.resume()
    }



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

