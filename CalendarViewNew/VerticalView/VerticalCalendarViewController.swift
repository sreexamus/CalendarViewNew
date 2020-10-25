//
//  CalendarViewController.swift
//  CalendarViewNew
//
//  Created by sreekanth reddy iragam reddy on 10/23/20.
//  Copyright © 2020 CalendarView. All rights reserved.
//

import UIKit

class VerticalCalendarViewController: UIViewController {
    let calendarView = VerticalCalendarView()
    
    var heightCons: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
            view.addToEdgeConstraints(calendarView, UIEdgeInsets(top: 10, left: -10, bottom: 10, right: 10))
    }
}
