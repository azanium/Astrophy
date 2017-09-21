//
//  TVGuideViewController.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright (c) 2017 Ainasoft. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import ALThreeCircleSpinner
import XLActionController
import RxSwift
import RxCocoa
import Kingfisher

protocol TVGuideDisplayLogic: class
{
    func displayChannels(viewModel: TVGuide.Channels.ViewModel)
    func displayProgrammes(viewModel: TVGuide.Programme.ViewModel)
}

class TVGuideViewController: UIViewController, TVGuideDisplayLogic
{
    var interactor: TVGuideBusinessLogic?
    var router: (NSObjectProtocol & TVGuideRoutingLogic & TVGuideDataPassing)?
    
    fileprivate let kCellIdentifier = "TVGuideCell"
    
    var tableView: UITableView!
    let spinner = ALThreeCircleSpinner(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    
    var displayedChannels = Variable([ChannelMeta]())
    var displayedProgrammesDictionary = [String:[ChannelEvent]]()
    
    let disposeBag = DisposeBag()
    private var sortChannelNumberAscending = true
    private var sortChannelNameAscending = true
    
    let seekerView = SeekerView()
    var isLoading = false
    var currentPage = 1
    var pageCount = 0
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = TVGuideInteractor()
        let presenter = TVGuidePresenter()
        let router = TVGuideRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        
        self.decorateNavigationBar()
        
        // We used hardcoded UI, because Xcode 8.3.3 has bug with top layout constraint on interface builder
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = .none
        tableView.rowHeight = 40
        tableView.tableHeaderView = UIView(frame: CGRect.zero)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(TVGuideCell.self, forCellReuseIdentifier: kCellIdentifier)
        
        setupSpinner()
        seekerView.seekerTimeChanged = seekerTimeChanged
    }
    
    func setupSpinner() {
        self.view.addSubview(spinner)
        spinner.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupUI()
        
        setupTableRowBindings()
        
        loadChannels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Loading Data

    func loadChannels(page: Int = 1)
    {
        isLoading = true
        self.spinner.startAnimating()
        
        let request = TVGuide.Channels.Request(page: page)
        interactor?.fetchChannels(request: request)
    }
    
    func loadProgrammes(page: Int = 1) {
        isLoading = true
        self.spinner.startAnimating()
        
        let request = TVGuide.Programme.Request(page: page, startDate: "2017-09-21 00:00", endDate: "2017-09-21 23:59")
        interactor?.fetchProgrammes(request: request)
    }
    
    // MARK: - Action Events
    
    func seekerTimeChanged(seekerView: SeekerView, time: String, hour: Int, minute: Int) {
        print("Time: \(time)")
    }
    
    // MARK: - Display
    
    func displayChannels(viewModel: TVGuide.Channels.ViewModel) {
        print("Channel displayed")
        isLoading = false
        
        self.spinner.stopAnimating()
        
        for channel in viewModel.channels {
            displayedChannels.value.append(channel)
        }
        
        currentPage = viewModel.currentPage
        pageCount = viewModel.pageCount
        
    }
    
    func displayProgrammes(viewModel: TVGuide.Programme.ViewModel) {
        for event in viewModel.events {
            var displayedEvents = displayedProgrammesDictionary[event.channelId]
            if displayedEvents == nil {
                displayedEvents = [ChannelEvent]()
            }
            displayedEvents! += [event]
            displayedProgrammesDictionary[event.channelId] = displayedEvents!
        }
        
        print("programmes: \(displayedProgrammesDictionary)")
        self.tableView.reloadData()
    }
}

extension TVGuideViewController : UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if !isLoading && currentPage < pageCount {
                    self.loadChannels(page: currentPage + 1)
                }
            }
        }
    }
    fileprivate func setupTableRowBindings() {
        
        // Bind out displayed channels to the tableview
        displayedChannels.asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: kCellIdentifier, cellType: TVGuideCell.self)
            ) { (index, meta, cell) in
                
                if let programmes = self.displayedProgrammesDictionary[meta.channelId] {
                    cell.assignProgrammes(programmes)
                }
                
                cell.channelTitleLabel.text = meta.channelTitle
                
                if meta.defaultLogo != "" {
                    let imageUrl = URL(string: meta.defaultLogo)!
                    cell.logoImageView.kf.indicatorType = .activity
                    cell.logoImageView.kf.setImage(with: ImageResource(downloadURL: imageUrl, cacheKey: imageUrl.path))
                }
            }
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return seekerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
