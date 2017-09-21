//
//  TVProgrammeCell.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/21/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit
import SnapKit

class ProgrammeView: UIView {
    var timeLabel = UILabel()
    var programmeTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        let margin = CGRect(x: 10, y: 10, width: 10, height: 10)
        
        timeLabel.frame = CGRect(x: margin.origin.x,
                                 y: margin.origin.y,
                                 width: self.frame.size.width - margin.size.width - margin.origin.x,
                                 height: 31)
        programmeTitleLabel.frame = CGRect(x: margin.origin.x,
                                           y: margin.origin.y + 31,
                                           width: self.frame.size.width - margin.size.width - margin.origin.x,
                                           height: self.frame.size.height - 31 - margin.origin.y - margin.size.height)
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.lightGray
        
        self.addSubview(timeLabel)
        self.addSubview(programmeTitleLabel)
        
        timeLabel.textColor = UIColor.darkGray
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        
        programmeTitleLabel.font = UIFont.systemFont(ofSize: 10)
        programmeTitleLabel.numberOfLines = 0
        programmeTitleLabel.textAlignment = .center
    }
}
