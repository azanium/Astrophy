//
//  TVProgrammeCell.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/21/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit
import SnapKit

class TVProgrammeCell: UICollectionViewCell {
    var timeLabel = UILabel()
    var programmeTitleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.lightGray
        
        self.addSubview(timeLabel)
        self.addSubview(programmeTitleLabel)
        let margin = CGRect(x: 10, y: 10, width: 10, height: 10)
        
        timeLabel.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(margin.origin.x)
            make.top.equalToSuperview().offset(margin.origin.y)
            make.right.equalToSuperview().offset(-margin.origin.x)
            make.height.equalTo(30)
        }
        timeLabel.textColor = UIColor.darkGray
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        
        programmeTitleLabel.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(31)
            make.left.equalToSuperview().offset(margin.origin.x)
            make.right.equalToSuperview().offset(-margin.origin.y)
            make.bottom.equalToSuperview().offset(-margin.origin.y)
        }
        programmeTitleLabel.font = UIFont.systemFont(ofSize: 12)
        programmeTitleLabel.numberOfLines = 0
    }
}
