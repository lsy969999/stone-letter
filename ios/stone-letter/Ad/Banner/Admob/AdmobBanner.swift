//
//  AdmobBanner.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//
import GoogleMobileAds
import Foundation
class AdmobBanner: NSObject, BannerAd, GADBannerViewDelegate {
    
    var id: String = UUID().uuidString
    var type: BannerAdType = .banner
    var platform: AdPlatform = .admob
    var status: AdStatus = .none
    var adLoaded: Int?
    var context: UIViewController?
    var callbackDelegate: BannerAdCallback
    private var ad: GADBannerView?
    
    init(callbackDelegate: BannerAdCallback){
        self.callbackDelegate = callbackDelegate
    }
    
    func launch(context: UIViewController, adKey: String) {
        self.context = context
        self.ad = GADBannerView()
        self.ad?.adUnitID = adKey
        self.ad?.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(context.view.frame.size.width)
        self.ad?.rootViewController = self.context
        self.ad?.delegate = self
        self.ad?.load(GADRequest())
        if let ad = ad {
            self.context?.view.addSubview(ad)
        }
    }
    
    func info() -> BannerAdInfo {
        return BannerAdInfo(id: id, platform: platform, type: type, status: status, adLoaded: adLoaded)
    }
    
    
    //
    
    
    
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("\(#function) \(platform) \(type) bannerad load successs.")
        self.status = .loaded
        self.adLoaded = Int(Date.now.timeIntervalSince1970) * 1000
        self.callbackDelegate.onLoadSuccess(id: id, platform: platform, type: type)
        
    }
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("\(#function) \(platform) \(type) Ad did fail to load bannerad.")
        let err = error.localizedDescription
        self.callbackDelegate.onLoadFail(id: id, platform: platform, type: type, error: err)
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("\(#function) \(platform) \(type) bannerad on open.")
        self.status = .showing
        self.callbackDelegate.onOpen(id: id, platform: platform, type: type)
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("\(#function) \(platform) \(type) Ad on close.")
        self.callbackDelegate.onClose(id: id, platform: platform, type: type)
    }
    
    func bannerViewDidRecordClick(_ bannerView: GADBannerView) {
        print("\(#function) \(platform) \(type) Ad click")
        self.callbackDelegate.onClick(id: id, platform: platform, type: type)
    }
}
