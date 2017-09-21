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
import RxSwift
import RxCocoa

class TVGuideCell: UITableViewCell {

    var containerView = UIView()
    var logoImageView = UIImageView()
    var channelTitleLabel = UILabel()
    var programmesCollectionView: UICollectionView!
    
    var programmes = [ChannelEvent]()
    
    fileprivate let kTVProgrammeCellId = "kTVProgrammeCellId"
    
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

    fileprivate func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.black
        
        // Setup container
        self.addSubview(containerView)
        containerView.backgroundColor = UIColor.white
        
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
        logoImageView.backgroundColor = UIColor.clear
        logoImageView.contentMode = .scaleAspectFit
        
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
        
        
        // Programmes Collection View
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: 50, height: 50)
        
        programmesCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        programmesCollectionView.delegate = self
        programmesCollectionView.dataSource = self
        programmesCollectionView.backgroundColor = UIColor.clear
        programmesCollectionView.register(TVProgrammeCell.self, forCellWithReuseIdentifier: kTVProgrammeCellId)
        
        containerView.addSubview(programmesCollectionView)
        programmesCollectionView.snp.remakeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(padding.x)
            make.top.equalToSuperview().offset(margin.top)
            make.right.equalToSuperview().offset(-margin.right)
            make.bottom.equalToSuperview().offset(-margin.bottom)
        }
    }
    
    func assignProgrammes(_ programmes: [ChannelEvent]) {
        self.programmes = programmes
        self.programmesCollectionView.reloadData()
    }
}

extension TVGuideCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return programmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTVProgrammeCellId, for: indexPath) as! TVProgrammeCell
        
        let programme = self.programmes[indexPath.row]
        
        cell.programmeTitleLabel.text = programme.programmeTitle
        cell.timeLabel.text = programme.dispayDateTime
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let hardCodedPadding:CGFloat = 1
        let itemWidth = collectionView.bounds.height - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
