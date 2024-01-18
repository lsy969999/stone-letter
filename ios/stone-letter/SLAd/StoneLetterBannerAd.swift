//
//  StoneLetterBannerAd.swift
//  stone-letter
//
//  Created by SY L on 1/18/24.
//

import Foundation
import UIKit

class StoneLetterBannerAd: ObservableObject {
//    var rootVC: UIViewController
    let adSelector: BannerAdSelector
    init() {
//        rootVC = UIApplication.shared.firstKeyWindow!.rootViewController!
        self.adSelector = BannerAdSelectorImpl();
    }
    
    func launch(context: UIViewController,platform: AdPlatform, type: BannerAdType, adKey: String){
//        self.adSelector.load(platform: platform, type: type, adKey: adKey)
        self.adSelector.launch(context: context, platform: platform, type: type, adKey: adKey)
    }
    
    func remove(platform: AdPlatform, type: BannerAdType){
        let loaded = self.adSelector.info().filter{ $0.platform == platform && $0.type == type}
        if let id = loaded.first?.id {
            self.adSelector.remove(id: id)
        }
    }
    
    func info() {
        let info = adSelector.info()
        info.forEach{
            print("info \($0)")
        }
    }
}
