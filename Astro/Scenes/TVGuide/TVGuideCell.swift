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
    fileprivate var seekLineView = UIView()
    
    
    fileprivate var scrollView = UIScrollView()
    
    var programmes = [ChannelEvent]()
    fileprivate var programmeViews = [UIView]()
    fileprivate var viewToProgrammeDictionary = [UIView:ChannelEvent]()
    
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
        
        // Programmes Scroll View
        containerView.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.shadowRadius = 2.0
        scrollView.layer.shadowColor = UIColor.darkGray.cgColor
        scrollView.layer.shadowOffset = CGSize.zero
        scrollView.layer.shadowOpacity = 0.8
        scrollView.backgroundColor = UIColor(hex: "#d0d0d0")
        scrollView.delegate = self
        
        // Red line for time seeker
        containerView.addSubview(seekLineView)
        seekLineView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.width.equalTo(2)
            make.top.equalToSuperview().offset(margin.top)
            make.bottom.equalToSuperview().offset(-margin.bottom)
        }
        seekLineView.backgroundColor = UIColor(hex: "#04a9f3")
    }
    
    override func layoutSubviews() {

        scrollView.snp.remakeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        
        
        var offsetX: CGFloat = 0
        let padding: CGSize = CGSize(width: 5, height: 5)
        var totalWidth: CGFloat = 0
        // Update programme views
        for programmeView in programmeViews {
            if let programme = viewToProgrammeDictionary[programmeView] {
                
                //print("time: \(programme.displayDateTime): \(programme.displayDateTimeInMinutes)")
                programmeView.frame = CGRect(x: CGFloat(programme.displayDateTimeInMinutes * 2) + (scrollView.frame.size.width * 0.5),
                                             y: padding.height + 0,
                                             width: CGFloat(programme.displayDurationInMinutes * 2) - 1,
                                             height: scrollView.frame.size.height - padding.height * 2)
                offsetX += CGFloat(programme.displayDurationInMinutes * 2) + 1
                totalWidth += CGFloat(programme.displayDurationInMinutes * 2)
            }
        }
    
        let size = CGFloat(max(24 * 120, totalWidth))
        scrollView.contentSize = CGSize(width: size + scrollView.frame.size.width, height: scrollView.frame.size.height)
        
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
    }
    
    fileprivate func updateProgrammeViews() {
        
        for programmeView in programmeViews {
            programmeView.removeFromSuperview()
        }
        programmeViews.removeAll()
        viewToProgrammeDictionary.removeAll()
        
        for programme in programmes {
            let pView = ProgrammeView(frame: CGRect.zero)
            
            pView.programmeTitleLabel.text = programme.programmeTitle
            pView.timeLabel.text = programme.displayDateTime
            
            scrollView.addSubview(pView)
            
            viewToProgrammeDictionary[pView] = programme
            programmeViews += [pView]
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    // MARK: - Methods
    
    func assignProgrammes(_ programmes: [ChannelEvent]) {
        self.programmes = programmes
        
        updateProgrammeViews()
    }
    
    func seekTime(hour: Int, minute: Int) {
        let posX = (hour  + (minute / 60)) * 120
        scrollView.setContentOffset(CGPoint(x: posX, y: 0), animated: false)
    }
}

extension TVGuideCell : UIScrollViewDelegate {
    /*
     We don't need to know the position of programme time for now
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let posX = min(max(scrollView.contentOffset.x, 0), 120 * 24)
        let hourComma = posX / 120
        let minutesFrac = hourComma.truncatingRemainder(dividingBy: 1)
        let minutes = Int(min(round(minutesFrac * 60), 59))
        let hour = Int(floor(hourComma))
        let time = hour >= 24 ? "00:00" : String(format: "%02d:%02d", arguments: [hour, minutes])
    }*/
}

