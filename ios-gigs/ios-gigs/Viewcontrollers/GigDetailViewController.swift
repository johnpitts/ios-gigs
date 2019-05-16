//
//  GigDetailViewController.swift
//  ios-gigs
//
//  Created by John Pitts on 5/16/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class GigDetailViewController: UIViewController, UIPickerViewDelegate {
    
    // Will I need a PickerView dataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet var jobTitleTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var jobDescriptionTextView: UITextView!
    
    
}
