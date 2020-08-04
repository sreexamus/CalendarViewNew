//
//  CollectionViewCell.swift
//  CalendarViewNew
//
//  Created by sreekanth reddy iragam reddy on 1/28/20.
//  Copyright © 2020 CalendarView. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        let desc = viewWithTag(1) as? UILabel
        desc?.backgroundColor = .none
        cornerRadius = 0
    }
    
}
