//
//  TVGuideCell.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit
import SnapKit
import Hue

class TVGuideCell: UITableViewCell {

    var containerView = UIView()
    var logoImageView = UIImageView()
    var channelTitleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.black
        
        // Setup container
        self.addSubview(containerView)
        containerView.backgroundColor = UIColor.white
        //containerView.layer.cornerRadius = 3.0
        //containerView.layer.masksToBounds = true
        containerView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        
        let margin = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let padding = CGPoint(x: 5, y: 5)
        
        // Setup logo
        containerView.addSubview(logoImageView)
        logoImageView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(margin.left)
            make.top.equalToSuperview().offset(margin.top)
            make.bottom.equalTo(containerView.snp.centerY)
            make.width.equalTo(70)
        }
        logoImageView.backgroundColor = UIColor.black
        
        containerView.addSubview(channelTitleLabel)
        channelTitleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom)
            make.left.equalToSuperview().offset(margin.left)
            make.right.equalTo(logoImageView.snp.right)
            make.bottom.equalToSuperview().offset(-margin.bottom)
        }
        channelTitleLabel.font = UIFont.systemFont(ofSize: 11)
        channelTitleLabel.textColor = UIColor.darkGray
        channelTitleLabel.numberOfLines = 0
        channelTitleLabel.textAlignment = .center
    }
    
}
