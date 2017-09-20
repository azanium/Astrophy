//
//  SeekerView.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit

class SeekerView: UIView {

    fileprivate var scrollView = UIScrollView()
    fileprivate let times = ["12:00AM", "01:00AM", "02:00AM", "03:00AM", "04:00AM", "05:00AM", "06:00AM", "07:00AM", "08:00AM", "09:00AM", "10:00AM", "11:00AM", "12:00PM", "01:00PM", "02:00PM", "03:00PM", "04:00PM", "05:00PM", "06:00PM", "07:00PM", "08:00PM", "09:00PM", "10:00PM", "11:00PM", "12:00AM"]
    fileprivate var timeViews = [SeekerTimeView]()
    fileprivate var nowLabel = UILabel()
    fileprivate var seekerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        scrollView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        }
        scrollView.contentSize = CGSize(width: 60 * 24 + (frame.size.width), height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor.darkGray
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        
        nowLabel.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(70)
        }
        
        seekerView.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(2)
        }
        
        var index = 0
        for time in timeViews {
            let f = time.frame
            
            time.frame = CGRect(x: CGFloat(index) * 60 + (frame.size.width * 0.5), y: f.origin.y, width: f.size.width, height: scrollView.frame.size.height)
            index += 1
        }
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.lightGray
        self.addSubview(scrollView)
        self.addSubview(nowLabel)
        self.addSubview(seekerView)
        scrollView.showsVerticalScrollIndicator = false
        
        for time in times {
            let time1 = SeekerTimeView(frame: CGRect.zero)
            time1.timeLabel.text = time
            scrollView.addSubview(time1)
            timeViews += [time1]
        }
        
        nowLabel.backgroundColor = UIColor(hex: "#04a9f3")
        nowLabel.textColor = UIColor.white
        nowLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nowLabel.text = "NOW"
        nowLabel.textAlignment = .center
        
        seekerView.backgroundColor = UIColor(hex: "#04a9f3")
    }
}
