//
//  AdSelector.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//

import Foundation
import UIKit

class FullScreenAdSelector: FullscreenAdSelector, FullscreenAdCallback {
    var context: UIViewController
    var fullScreenAds: [FullScreenAd] = [];
    var delegate: FullscreenAdCallback?
    
    init(context: UIViewController) {
        self.context = context
    }
    
    let maxDupCnt = 2;
    
    func able(platform: AdPlatform, type: FullScreenAdType) -> Bool {
        switch (platform, type) {
        case (.admob, .interstitial): return true
        case (.admob, .rewarded): return true
        case (.admob, .native): return true
        case (.admob, .mrec): return false
        default:
            return false
        }
    }
    
    func load(platform: AdPlatform, type: FullScreenAdType, adKey: String) {
        guard self.able(platform: platform, type: type) else {
            print("\(#function) platform: \(platform), type: \(type) not able")
            return
        }
        
        guard self.countFullscreenAd(platform: platform, type: type, status: []) <= maxDupCnt  else {
            print("\(#function) platform: \(platform), type: \(type) is max Dup Cnt")
            return
        }
        
        if let gen = self.generateFullScreenAd(platform: platform, type: type){
            gen.load(adKey: adKey)
            self.fullScreenAds.append(gen)
        } else {
            print("\(#function) platform: \(platform), type: \(type) gen fail")
        }
    }
    
    func show(id: String) {
        if let ad = self.findById(id: id) {
            ad.show()
        } else {
            print("\(#function) id: \(id) find fail")
        }
    }
    
    func info() -> [FullScreenAdInfo] {
        return self.fullScreenAds.map{ $0.info() }
    }
    
    private func findById(id: String) -> FullScreenAd? {
        return self.fullScreenAds.first{$0.id == id}
    }
    
    private func generateFullScreenAd(platform: AdPlatform, type: FullScreenAdType) -> FullScreenAd?{
        switch (platform, type) {
        case (.admob, .interstitial):
            return AdmobInterstitial(context: self.context, callbackDelegate: self)
        default:
          return nil
        }
    }
    
    private func countFullscreenAd(platform: AdPlatform, type: FullScreenAdType, status: [AdStatus]?) -> Int {
        return self.fullScreenAds
                    .filter{ $0.platform == platform && $0.type == type}
                    .count
    }
    
    func clear(id: String) {
        for (index, ad) in self.fullScreenAds.enumerated(){
            if ad.id == id {
                self.fullScreenAds.remove(at: index)
            }
        }
    }
    
    func onLoadSuccess(id: String, platform: AdPlatform, type: FullScreenAdType) {
        print("FullScreenAdSelector \(#function) \(platform) \(type)")
        self.delegate?.onLoadSuccess(id: id, platform: platform, type: type)
    }
    
    func onLoadFail(id: String, platform: AdPlatform, type: FullScreenAdType, error: String) {
        print("FullScreenAdSelector \(#function) \(platform) \(type) \(error)")
        self.delegate?.onLoadFail(id: id, platform: platform, type: type, error: error)
        self.clear(id: id)
    }
    
    func onOpen(id: String, platform: AdPlatform, type: FullScreenAdType) {
        print("FullScreenAdSelector \(#function) \(platform) \(type)")
        self.delegate?.onOpen(id: id, platform: platform, type: type)
    }
    
    func onClick(id: String, platform: AdPlatform, type: FullScreenAdType) {
        print("FullScreenAdSelector \(#function) \(platform) \(type)")
        self.delegate?.onClick(id: id, platform: platform, type: type)
    }
    
    func onClose(id: String, platform: AdPlatform, type: FullScreenAdType) {
        print("FullScreenAdSelector \(#function) \(platform) \(type)")
        self.delegate?.onClose(id: id, platform: platform, type: type)
        self.clear(id: id)
    }
    
    func onException(id: String, platform: AdPlatform, type: FullScreenAdType, error: String) {
        print("FullScreenAdSelector \(#function) \(platform) \(type) \(error)")
        self.delegate?.onException(id: id, platform: platform, type: type, error: error)
        self.clear(id: id)
    }
}
