//
//  BannerAdSelector.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//

import UIKit

//import Foundation
class BannerAdSelectorImpl: BannerAdSelector, BannerAdCallback {

    
    
    var bannerAds: [BannerAd] = [];
    let maxDupCnt = 2;
//    var context: UIViewController
    
//    init(context: UIViewController) {
//        self.context = context
//    }
    
    func able(platform: AdPlatform, type: BannerAdType) -> Bool {
        switch (platform, type) {
        case (.admob, .banner): return true
        default:
            return false
        }
    }
    
//    func load(platform: AdPlatform, type: BannerAdType, adKey: String) {
//        guard self.able(platform: platform, type: type) else {
//            print("\(#function) platform: \(platform), type: \(type) not able")
//            return
//        }
//        
//        guard self.countBannerAd(platform: platform, type: type, status: []) < maxDupCnt  else {
//            print("\(#function) platform: \(platform), type: \(type) is max Dup Cnt")
//            return
//        }
//        
//        if let gen = self.generateBannerAd(platform: platform, type: type){
////            gen.load(adKey: adKey)
//            self.bannerAds.append(gen)
//        } else {
//            print("\(#function) platform: \(platform), type: \(type) gen fail")
//        }
//    }
//    
//    func show(id: String) {
//        if let ad = self.findById(id: id) {
////            ad.show()
//        } else {
//            print("\(#function) id: \(id) find fail")
//        }
//    }
    
    func info() -> [BannerAdInfo] {
        return self.bannerAds.map{ $0.info() }
    }
    
//    func clear(id: String) {
//        for (index, ad) in self.bannerAds.enumerated(){
//            if ad.id == id {
//                self.bannerAds.remove(at: index)
//            }
//        }
//    }
    func launch(context: UIViewController, platform: AdPlatform, type: BannerAdType, adKey: String) {
        guard self.able(platform: platform, type: type) else {
            print("\(#function) platform: \(platform), type: \(type) not able")
            return
        }
        guard self.countBannerAd(platform: platform, type: type, status: []) < maxDupCnt  else {
            print("\(#function) platform: \(platform), type: \(type) is max Dup Cnt")
            return
        }
        if let gen = self.generateBannerAd(platform: platform, type: type){
            gen.launch(context: context, adKey: adKey)
            self.bannerAds.append(gen)
        } else {
            print("\(#function) platform: \(platform), type: \(type) gen fail")
        }
    }
    
    func remove(id: String) {
        for (index, ad) in self.bannerAds.enumerated(){
            if ad.id == id {
                self.bannerAds.remove(at: index)
            }
        }
    }
    
    private func findById(id: String) -> BannerAd? {
        return self.bannerAds.first{$0.id == id}
    }
    
    private func countBannerAd(platform: AdPlatform, type: BannerAdType, status: [AdStatus]?) -> Int {
        return self.bannerAds
                    .filter{ $0.platform == platform && $0.type == type}
                    .count
    }
    
    private func generateBannerAd(platform: AdPlatform, type: BannerAdType) -> BannerAd?{
        switch (platform, type) {
        case (.admob, .banner):
            return AdmobBanner(callbackDelegate: self)
        default:
          return nil
        }
    }
    
    func onLoadSuccess(id: String, platform: AdPlatform, type: BannerAdType) {
        print("BannerAdSelectorImpl \(#function) \(platform) \(type)")
    }
    
    func onLoadFail(id: String, platform: AdPlatform, type: BannerAdType, error: String) {
        print("BannerAdSelectorImpl \(#function) \(platform) \(type) \(error)")
    }
    
    func onOpen(id: String, platform: AdPlatform, type: BannerAdType) {
        print("BannerAdSelectorImpl \(#function) \(platform) \(type)")
    }
    
    func onClick(id: String, platform: AdPlatform, type: BannerAdType) {
        print("BannerAdSelectorImpl \(#function) \(platform) \(type)")
    }
    
    func onClose(id: String, platform: AdPlatform, type: BannerAdType) {
        print("BannerAdSelectorImpl \(#function) \(platform) \(type)")
    }
    
    func onException(id: String, platform: AdPlatform, type: BannerAdType, error: String) {
        print("BannerAdSelectorImpl \(#function) \(platform) \(type) \(error)")
    }
}
