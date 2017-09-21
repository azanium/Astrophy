//
//  SeekerView.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit

class SeekerView: UIView {

    typealias SeekerTimeChangedHandler = (SeekerView, String, Int, Int)->Void
    
    fileprivate var scrollView = UIScrollView()
    fileprivate let times = ["12:00AM", "01:00AM", "02:00AM", "03:00AM", "04:00AM", "05:00AM", "06:00AM", "07:00AM", "08:00AM", "09:00AM", "10:00AM", "11:00AM", "12:00PM", "01:00PM", "02:00PM", "03:00PM", "04:00PM", "05:00PM", "06:00PM", "07:00PM", "08:00PM", "09:00PM", "10:00PM", "11:00PM", "12:00AM"]
    fileprivate var timeViews = [SeekerTimeView]()
    fileprivate var nowLabel = UILabel()
    fileprivate var seekerView = UIView()
    
    var seekerTimeChanged: SeekerTimeChangedHandler?
    
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
        scrollView.contentSize = CGSize(width: 60 * 24 + (frame.size.width) + 10, height: scrollView.frame.size.height)
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
            
            time.frame = CGRect(x: CGFloat(index) * 60 + (frame.size.width * 0.5) + 5, y: f.origin.y, width: f.size.width, height: scrollView.frame.size.height)
            index += 1
        }
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.lightGray
        self.addSubview(scrollView)
        self.addSubview(nowLabel)
        self.addSubview(seekerView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
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
    
    func seekTime(hour: Int, minute: Int) {
        let posX = (hour  + (minute / 60)) * 60
        scrollView.setContentOffset(CGPoint(x: posX, y: 0), animated: true)
    }
}

extension SeekerView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let posX = min(max(scrollView.contentOffset.x, 0), 60 * 24)
        let hourComma = posX / 60
        let minutesFrac = hourComma.truncatingRemainder(dividingBy: 1)
        let minutes = Int(min(round(minutesFrac * 60), 59))
        let hour = Int(floor(hourComma))
        let time = hour >= 24 ? "00:00" : String(format: "%02d:%02d", arguments: [hour, minutes])
        
        seekerTimeChanged?(self, time, hour, minutes)
    }
    
}
