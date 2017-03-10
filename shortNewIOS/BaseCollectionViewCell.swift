//
//  BaseCollectionViewCell.swift
//  shortNewIOS
//
//  Created by SSd on 12/8/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
