//
//  ChannelCell.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/19/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit
import Hue
import SnapKit
import RxCocoa
import RxSwift

class ChannelCell: UITableViewCell {
    typealias ChannelFavoriteHandler = (UIButton) -> Void
    
    var containerView = UIView()
    var logoImageView = UIImageView()
    var channelTitleLabel = UILabel()
    var channelNumberLabel = UILabel()
    var channelDescriptionLabel = UILabel()
    var favoriteButton = UIButton()
    
    var favoriteChanged: ChannelFavoriteHandler?
    
    let disposeBag = DisposeBag()
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.black
        
        self.addSubview(containerView)
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 3.0
        containerView.layer.masksToBounds = true
        
        containerView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        
        let margin = 10
        let gap = 5
        
        // Set the logo
        containerView.addSubview(logoImageView)
        logoImageView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(margin)
            make.left.equalToSuperview().offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        logoImageView.backgroundColor = UIColor.clear
        logoImageView.contentMode = .scaleAspectFit
        
        containerView.addSubview(channelTitleLabel)
        channelTitleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(gap)
            make.top.equalToSuperview().offset(margin)
            make.height.equalTo(25)
            make.right.equalToSuperview().offset(-margin)
        }
        channelTitleLabel.font = UIFont.systemFont(ofSize: 17)
        channelTitleLabel.textColor = UIColor.darkGray
        
        containerView.addSubview(channelNumberLabel)
        channelNumberLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(gap)
            make.top.equalTo(channelTitleLabel.snp.bottom)
            make.bottom.equalTo(logoImageView.snp.bottom)
            make.right.equalToSuperview().offset(-margin)
        }
        channelNumberLabel.font = UIFont.systemFont(ofSize: 15)
        channelNumberLabel.textColor = UIColor.darkGray
        
        containerView.addSubview(channelDescriptionLabel)
        channelDescriptionLabel.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalTo(logoImageView.snp.bottom).offset(gap)
            make.right.equalToSuperview().offset(-margin)
            make.bottom.equalToSuperview().offset(-margin)
        }
        channelDescriptionLabel.numberOfLines = 0
        channelDescriptionLabel.font = UIFont.systemFont(ofSize: 15)
        channelDescriptionLabel.textColor = UIColor.darkGray
        
        containerView.addSubview(favoriteButton)
        favoriteButton.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(margin)
            make.right.equalToSuperview().offset(-margin)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        favoriteButton.setImage(UIImage(named: "favOff"), for: .normal)
        favoriteButton.setImage(UIImage(named: "favOn"), for: .selected)
        favoriteButton.rx.tap.bind {
            
            self.favoriteChanged?(self.favoriteButton)
            
        }.disposed(by: disposeBag)
    }

}
