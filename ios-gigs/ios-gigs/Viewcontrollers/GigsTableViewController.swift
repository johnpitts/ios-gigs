//
//  GigsTableViewController.swift
//  ios-gigs
//
//  Created by John Pitts on 5/16/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class GigsTableViewController: UITableViewController {
    
    
    var gigController = GigController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if gigController.bearer == nil {
            
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
        gigController.getAllGigs { (result) in
            
            do {
                self.gigController.gigs = try result.get()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                NSLog("Error getting all animals")
            }
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gigController.gigs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GigCell", for: indexPath)

        cell.textLabel?.text = gigController.gigs[indexPath.row].title
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        //timeSeenLabel.text = df.string(from: animal.timeSeen)
        cell.detailTextLabel?.text = df.string(from: gigController.gigs[indexPath.row].dueDate)

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LoginSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.gigController = gigController
            }
        } else {
            if segue.identifier == "ShowGig" {
                if let detailVC = segue.destination as? GigDetailViewController,
                   let indexPath = tableView.indexPathForSelectedRow {
                        detailVC.gigController = gigController
                        detailVC.gig = gigController.gigs[indexPath.row]
                }
            }
        }
    }
    
    
}
