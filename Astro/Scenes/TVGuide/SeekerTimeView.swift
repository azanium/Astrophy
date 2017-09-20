//
//  SeekerTimeView.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit
import SnapKit

class SeekerTimeView: UIView {

    var timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        self.addSubview(timeLabel)
        
        timeLabel.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalToSuperview()
        }
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont.systemFont(ofSize: 11)
        
    }

}
