//
//  ChannelsInteractor.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/19/17.
//  Copyright (c) 2017 Ainasoft. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ChannelsBusinessLogic
{
    func fetchChannels(request: Channels.List.Request)
    func sortChannelNumbers(ascending: Bool)
    func sortChannelNames(ascending: Bool)
}

protocol ChannelsDataStore
{
    var channelMetas: [ChannelMeta] { get set }
}

class ChannelsInteractor: ChannelsBusinessLogic, ChannelsDataStore
{
    var presenter: ChannelsPresentationLogic?
    var worker: ChannelsWorker? = ChannelsWorker()
    var channelMetas: [ChannelMeta] = [ChannelMeta]()
    
    // MARK: Do something
    
    func fetchChannels(request: Channels.List.Request)
    {
        worker?.fetchChannels(onCompletionHandler: { [weak self] (response) in
            
            switch response {
            case .success(let channels):
                var ids = [String]()
                for ch in channels {
                    ids += [String(ch.id)]
                }
                let idList = ids.joined(separator: ",")
                self?.fetchMetadata(ids: idList)
                
            case .error(let message):
                let response = Channels.Error.Response(message: message)
                self?.presenter?.presentChannelsError(response: response)
            }
            
        })
    }
    
    func fetchMetadata(ids: String) {
        
        worker?.fetchChannelMetas(ids: ids) { [weak self] (response) in
            switch response {
            case .success(let channelMetas):
                self?.channelMetas = channelMetas
                let resp = Channels.Metadata.Response(metas: channelMetas)
                self?.presenter?.presentChannelMetas(response: resp)
                
            case .error(let message):
                let resp = Channels.Error.Response(message: message)
                self?.presenter?.presentChannelsError(response: resp)
            }
        }
    }
    
    func sortChannelNumbers(ascending: Bool) {
        channelMetas.sort { ascending ? $0.0.channelStubNumber < $0.1.channelStubNumber : $0.0.channelStubNumber > $0.1.channelStubNumber }
        let response = Channels.Metadata.Response(metas: channelMetas)
        self.presenter?.presentChannelMetas(response: response)
    }
    
    func sortChannelNames(ascending: Bool) {
        channelMetas.sort { ascending ? $0.0.channelTitle < $0.1.channelTitle : $0.0.channelTitle > $0.1.channelTitle }
        let response = Channels.Metadata.Response(metas: channelMetas)
        self.presenter?.presentChannelMetas(response: response)
    }
}
