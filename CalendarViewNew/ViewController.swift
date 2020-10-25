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
    }

    @IBAction func showHotizontalCalendarView(_ sender: Any) {
        performSegue(withIdentifier: "showVC", sender: nil)
    }
    
    @IBAction func showVerticalCalendarView(_ sender: Any) {
        performSegue(withIdentifier: "showVC", sender: nil)
    }
    
}

