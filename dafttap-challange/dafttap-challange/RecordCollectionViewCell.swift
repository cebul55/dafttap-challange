//
//  RecordCollectionViewCell.swift
//  dafttap-challange
//
//  Created by Bartosz Cybulski on 10/05/2019.
//  Copyright © 2019 Bartosz Cybulski. All rights reserved.
//

import Foundation
import UIKit

class RecordCollectionViewCell : UICollectionViewCell {
    var label = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        label.frame = frame
        self.label.text = ""
        self.label.textAlignment = .center
        self.contentView.addSubview(label)
        self.center = self.contentView.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
