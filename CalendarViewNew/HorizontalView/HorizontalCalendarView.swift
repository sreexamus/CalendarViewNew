//
//  VerticalCalendarView.swift
//  CalendarViewNew
//
//  Created by sreekanth reddy iragam reddy on 10/24/20.
//  Copyright © 2020 CalendarView. All rights reserved.
//

import UIKit

class HorizontalCalendarView: UIView {
    let currentDate = Date()
    var calendar:  UICollectionView!
    var heightCons: NSLayoutConstraint?
    var currentMonth = 0
    var viewModel = CustomCalendarViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        calendar = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        calendar.backgroundColor = .white
        calendar.dataSource = self
        calendar.delegate = self
        if let layout = calendar.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    
        calendar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(calendar)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: calendar.leadingAnchor, constant: -10),
            trailingAnchor.constraint(equalTo: calendar.trailingAnchor, constant:10),
            topAnchor.constraint(equalTo: calendar.topAnchor, constant: 0),
            bottomAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 10)
        ])

//        let cellHeight = calendar.bounds.size.width / 7
//        print("cellHeight.. \(cellHeight)")
//        heightCons = calendar.heightAnchor.constraint(equalToConstant: 100 + (300 / 7) * 7)
//        heightCons?.isActive = true
//        heightCons?.priority = UILayoutPriority(500)
        
        calendar.register(UINib(nibName: "CollectionViewCell", bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: "dayCell")
        calendar.register(UINib(nibName: "HorizontalHeaderView", bundle: Bundle(for: type(of: self))), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "horizontalHeaderCollection")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("..heig \(calendar.collectionViewLayout.collectionViewContentSize.height)")
        heightCons?.constant = calendar.collectionViewLayout.collectionViewContentSize.height
        setNeedsLayout()
        
    }

}

extension HorizontalCalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let firstDayOfTheWeekInAMonth = viewModel.getDayOfWeek(viewModel.startOfMonth(viewModel.addMonth(currentDate, month: currentMonth)))
        let noOfDaysLeft = (firstDayOfTheWeekInAMonth ?? 0) - 1
        let noOfCells = Utility.getDaysInMonth(Utility.addMonth(Date(), month: currentMonth)) + noOfDaysLeft
        return noOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("size is \(collectionView.bounds.size.width / 7)")
        return CGSize(width: CGFloat((collectionView.bounds.size.width / 7)), height: CGFloat((collectionView.bounds.size.width / 7)))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CollectionViewCell
        let desc = cell.viewWithTag(1) as? UILabel
        let firstDayOfTheWeekInAMonth = viewModel.getDayOfWeek(viewModel.startOfMonth(viewModel.addMonth(currentDate, month: currentMonth)))
        cell.layer.cornerRadius = 6
        
        let diff = indexPath.item + 1 - firstDayOfTheWeekInAMonth!
        
        if diff >= 0 {
            desc?.text = String(diff + 1)
        } else {
            desc?.text = ""
            desc?.backgroundColor = .white
            return cell
        }
        
        if currentMonth == 0 {
            let currentDay = viewModel.getDayInInt(date: currentDate)
            if let descVal = desc?.text, !descVal.isEmpty, descVal == String(currentDay) {
                desc?.backgroundColor = UIColor.green.withAlphaComponent(0.5)
                return cell
            }
        }
        desc?.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "horizontalHeaderCollection", for: indexPath)
        guard let title = headerView.viewWithTag(1) as? UILabel else {return headerView}
        title.font = .boldSystemFont(ofSize: 20)
        title.text = viewModel.getHeaderTitle(viewModel.addMonth(currentDate, month: currentMonth))
        return headerView
    }
}
