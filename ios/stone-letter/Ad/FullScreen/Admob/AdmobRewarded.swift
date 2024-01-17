//
//  AdmobRewarded.swift
//  stone-letter
//
//  Created by SY L on 1/18/24.
//

import Foundation
import GoogleMobileAds
class AdmobRewarded: NSObject, FullScreenAd, GADFullScreenContentDelegate {
    var id: String = UUID().uuidString
    var platform: AdPlatform = .admob
    var type: FullScreenAdType = .rewarded
    var callbackDelegate: FullscreenAdCallback
    var context: UIViewController
    var status: AdStatus = .none
    var adLoaded: Int?
    private var ad: GADRewardedAd?
    
    init(context: UIViewController, callbackDelegate: FullscreenAdCallback) {
        self.context = context
        self.callbackDelegate = callbackDelegate
    }
    
    func load(adKey: String) {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: adKey, request: request){ [self] ad, error in
            if let error = error {
                let err = error.localizedDescription;
                print("Failed to load rewarded ad with error: \(err)")
                self.callbackDelegate.onLoadFail(id: id, platform: platform, type: type, error: err);
                return
              }
            self.ad = ad
            self.ad?.fullScreenContentDelegate = self
            self.status = .loaded
            self.adLoaded = Int(Date.now.timeIntervalSince1970) * 1000
            self.callbackDelegate.onLoadSuccess(id: id, platform: platform, type: type)
        }
    }
    
    func show() {
        guard let ad = ad else {
            print("\(#function) ad is nil")
            return;
        }
        ad.present(fromRootViewController: self.context) { 
            let reward = ad.adReward
            let amountDouble = reward.amount.doubleValue
            print("Reward received with currency \(reward.amount), amount \(amountDouble)")
            self.callbackDelegate.onRewarded(id: self.id, platform: self.platform, type: self.type, amount: amountDouble)
        }
    }
    
    func info() -> FullScreenAdInfo {
        return FullScreenAdInfo(
            id: self.id,
            platform: self.platform,
            type: self.type,
            status: self.status,
            adLoaded: self.adLoaded
        )
    }
    
    /*
        Admob Interstitial Delegate
     */
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("\(#function) \(platform) \(type) Ad did fail to present full screen content.")
        let err = error.localizedDescription
        self.callbackDelegate.onException(id: id, platform: platform, type: type, error: err)
        
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) \(platform) \(type) Ad will present full screen content.")
        self.status = .showing
        self.callbackDelegate.onOpen(id: id, platform: platform, type: type)
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) \(platform) \(type) Ad did dismiss full screen content.")
        self.callbackDelegate.onClose(id: id, platform: platform, type: type)
    }
    
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) \(platform) \(type) Ad click")
        self.callbackDelegate.onClick(id: id, platform: platform, type: type)
    }
}
