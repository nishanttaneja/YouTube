//
//  BaseCell.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import UIKit

class BaseCell: UICollectionViewCell {
    func configureCell() {  }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

