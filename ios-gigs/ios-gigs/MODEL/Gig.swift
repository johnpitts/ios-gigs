//
//  Gig.swift
//  ios-gigs
//
//  Created by John Pitts on 5/16/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import Foundation

struct Gig: Codable {
    
    var title: String
    var description: String
    var dueDate: Date  // API JSON will be format ISO 8601
    
}
