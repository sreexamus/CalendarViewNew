//
//  CustomCalendarView.swift
//  CalendarViewNew
//
//  Created by sreekanth reddy iragam reddy on 1/28/20.
//  Copyright © 2020 CalendarView. All rights reserved.
//

import UIKit


class VerticalCalendarView: UIView {
    let currentDate = Date()
    @IBOutlet weak var calendar: UICollectionView!
    var viewModel: CustomCalendarViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func initialize() {
        let view: UIView = loadNib()
        view.frame = bounds
        addSubview(view)
        viewModel = CustomCalendarViewModel()
        registerCells()
    }

    func registerCells() {
        calendar.register(UINib(nibName: "CollectionViewCell", bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: "dayCell")
        calendar.register(UINib(nibName: "CustomCollectionHeader", bundle: Bundle(for: type(of: self))), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCollection")
        calendar.delegate = self
        calendar.dataSource = self

        // to pin the headers to top
        /*if let flowlayout = calendar.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.sectionHeadersPinToVisibleBounds = true
        } */
    }
}

extension VerticalCalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let firstDayOfTheWeekInAMonth = viewModel.getDayOfWeek(viewModel.startOfMonth(viewModel.addMonth(currentDate, month: section)))
        let noOfDaysLeft = (firstDayOfTheWeekInAMonth ?? 0) - 1
        let noOfCells = Utility.getDaysInMonth(Utility.addMonth(Date(), month: section)) + noOfDaysLeft
        return noOfCells
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.bounds.size.width / 7)), height: CGFloat((collectionView.bounds.size.width / 7)))
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CollectionViewCell
        let desc = cell.viewWithTag(1) as? UILabel
        let firstDayOfTheWeekInAMonth = viewModel.getDayOfWeek(viewModel.startOfMonth(viewModel.addMonth(currentDate, month: indexPath.section)))
        cell.layer.cornerRadius = 6

        let diff = indexPath.item + 1 - firstDayOfTheWeekInAMonth!
        
        if diff >= 0 {
            desc?.text = String(diff + 1)
        } else {
             desc?.text = ""
             desc?.backgroundColor = .white
             return cell
        }
        
        if indexPath.section == 0 {
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
        return CGSize(width: collectionView.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCollection", for: indexPath)
        guard let title = headerView.viewWithTag(1) as? UILabel else {return headerView}
        title.font = .boldSystemFont(ofSize: 20)
        title.text = viewModel.getHeaderTitle(viewModel.addMonth(currentDate, month: indexPath.section))
        return headerView
    }

}
