//
//  AdmobInterstitial.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//

import Foundation
import GoogleMobileAds
class AdmobInterstitial: NSObject, FullScreenAd, GADFullScreenContentDelegate {
    var id: String = UUID().uuidString
    let platform: AdPlatform = .admob
    let type: FullScreenAdType = .interstitial
    let callbackDelegate: FullscreenAdCallback
    let context: UIViewController
    var status: AdStatus = .none
    var adLoaded: Int?
    private var ad: GADInterstitialAd?
    
    init(context: UIViewController, callbackDelegate: FullscreenAdCallback) {
        self.context = context
        self.callbackDelegate = callbackDelegate
    }
    
    //"ca-app-pub-3940256099942544/4411468910"
    func load(adKey: String) {
        self.status = .loading
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: adKey, request: request){ [self] ad, error in
            if let error = error {
                let err = error.localizedDescription;
                print("Failed to load interstitial ad with error: \(err)")
                self.callbackDelegate.onLoadFail(id: id, platform: platform, type: type, error: err);
              return
            }
            self.ad = ad
            self.ad?.fullScreenContentDelegate = self
            self.status = .loaded
            self.callbackDelegate.onLoadSuccess(id: id, platform: platform, type: type)
          }
    }
    
    func show() {
        guard let ad = ad else {
            print("\(#function) ad is nil")
            return;
        }
        ad.present(fromRootViewController: self.context)
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
    
    func clear() {
        self.ad = nil
        self.status = .none
    }
    
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
        self.callbackDelegate.onClick(id: id, platform: platform, type: type)
    }
}
