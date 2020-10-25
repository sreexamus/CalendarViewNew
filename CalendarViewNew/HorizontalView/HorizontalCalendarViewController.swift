//
//  VerticalCalendarViewController.swift
//  CalendarViewNew
//
//  Created by sreekanth reddy iragam reddy on 10/25/20.
//  Copyright © 2020 CalendarView. All rights reserved.
//

import UIKit

class HorizontalCalendarViewController: UIViewController {
    let horCalendarView = HorizontalCalendarView()
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        horCalendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(horCalendarView)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: horCalendarView.leadingAnchor, constant: -10),
            view.trailingAnchor.constraint(equalTo: horCalendarView.trailingAnchor, constant: 10),
            headerView.bottomAnchor.constraint(equalTo: horCalendarView.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: horCalendarView.bottomAnchor, constant: 10)
        ])
        horCalendarView.calendar.reloadData()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func prevMonth(_ sender: Any) {
        if horCalendarView.currentMonth > 0 {
        horCalendarView.currentMonth = horCalendarView.currentMonth - 1
        }
        horCalendarView.calendar.reloadData()
    }
    
    @IBAction func nextMonh(_ sender: Any) {
        if horCalendarView.currentMonth < 12 {
            horCalendarView.currentMonth = horCalendarView.currentMonth + 1
        }
        horCalendarView.calendar.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
