//
//  TVGuidePresenter.swift
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

protocol TVGuidePresentationLogic
{
    func presentChannels(response: TVGuide.Channels.Response)
    func presentProgrammes(response: TVGuide.Programme.Response)
}

class TVGuidePresenter: TVGuidePresentationLogic
{
    weak var viewController: TVGuideDisplayLogic?
    
    // MARK: Do something
    
    func presentChannels(response: TVGuide.Channels.Response)
    {
        let viewModel = TVGuide.Channels.ViewModel(channels: response.channels, currentPage: response.currentPage, pageCount: response.pageCount)
        self.viewController?.displayChannels(viewModel: viewModel)
    }
    
    func presentProgrammes(response: TVGuide.Programme.Response) {
        let viewModel = TVGuide.Programme.ViewModel(events: response.events)
        self.viewController?.displayProgrammes(viewModel: viewModel)
    }
}
