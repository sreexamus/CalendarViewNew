//
//  ViewController.swift
//  CalendarViewNew
//
//  Created by sreekanth reddy iragam reddy on 1/28/20.
//  Copyright © 2020 CalendarView. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = CustomCalendarView()
        view.addToEdgeConstraints(calendar)

        // Do any additional setup after loading the view.
    }


}

