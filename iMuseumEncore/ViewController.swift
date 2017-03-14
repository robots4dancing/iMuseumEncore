//
//  ViewController.swift
//  iMuseumEncore
//
//  Created by Valerie Greer on 3/14/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var masterMuseumArray = [Museum]()
    var currentMuseum :Museum?
//    var museumSearchResult = [Museum]()
    
    @IBOutlet var museumTableView       :UITableView!
//    @IBOutlet var searchBar             :UISearchBar!
    
    //MARK: - Interactivity Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSpecific" {
            let indexPath = museumTableView.indexPathForSelectedRow!
            let currentMuseum = masterMuseumArray[indexPath.row]
            let destVC = segue.destination as! MapViewController
            destVC.currentMuseum = currentMuseum
            museumTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func updateScreen(_ notification: Notification) {
            masterMuseumArray = appDelegate.masterMuseumArray
            museumTableView.reloadData()
    }
    
    @IBAction func getFilePressed(button: UIBarButtonItem) {
        //        guard let reach = reachability else {
        //            return
        //        }
        //        if reach.isReachable {
        appDelegate.getFile()
        //        } else {
        //            print("Host Not Reachable. Turn on the Internet")
        //        }
        
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateScreen(_:)), name: .reload, object: nil)
    //    searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masterMuseumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MuseumTableViewCell
        let currentMuseum = masterMuseumArray[indexPath.row]
        cell.museumNameLabel!.text = currentMuseum.museumName
        cell.museumAddressLabel!.text = currentMuseum.museumFullAddress
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}

//http://stackoverflow.com/questions/30541010/how-to-reload-data-in-a-tableview-from-a-different-viewcontroller-in-swift

extension Notification.Name {
    static let reload = Notification.Name("reload")
}

//extension ViewController: UISearchBarDelegate, UISearchDisplayDelegate {
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        self.museumSearchResult = self.masterMuseumArray.filter ({(aMueseum: Museum) -> Bool in
//            return aMueseum.museumName.lowercased().range(of: searchText.lowercased()) != nil
//        })
//    }
//    
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        searchBar.resignFirstResponder()
//        return true
//    }
//    
//}
