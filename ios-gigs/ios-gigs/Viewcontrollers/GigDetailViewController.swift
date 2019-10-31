//
//  GigDetailViewController.swift
//  ios-gigs
//
//  Created by John Pitts on 5/16/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class GigDetailViewController: UIViewController, UIPickerViewDelegate {
    
    
    @IBOutlet var jobTitleTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var jobDescriptionTextView: UITextView!
    
    var gigController: GigController!
    
    var gig: Gig? {
        didSet {
            updateViews()
        }
    }
    // Will I need a PickerView dataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        // updateViews()
    }
    
    func updateViews() {   // where will i call updateViews?
        guard let gig = gig else { self.title = "New Gig"; return } // not sure this return is appropriate
        
        jobTitleTextField.text = gig.title
        jobDescriptionTextView.text = gig.description

        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        df.string(from: gig.dueDate)
        datePicker.setDate(gig.dueDate, animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
 
//        guard let title = jobTitleTextField.text,
//        guard let description = jobDescriptionTextView.text,
//        guard let dueDate = "20120721" else { return }
//
//        //let task = taskController.createTask(with: title)
//
//
//        self.gigController.post(title: title, description: description, dueDate: dueDate) { completion: (Result<gig, gigController.NetworkError>) -> Void) in
//
//            if let error = error {
//                print("Error posting giug: \(error)")
//                 // We couldn't perform what we needed to do
//                return
//            }
//            // We successfully performed the action.
//
//            self.gigController.getAllGigs(completion: { (Result<[gig], gigController.NetworkError>) in
//
//            })
//
//
//        })

    }
}
