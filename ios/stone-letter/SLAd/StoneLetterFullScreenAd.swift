//
//  StoneLetterAd.swift
//  stone-letter
//
//  Created by SY L on 1/18/24.
//

import Foundation
import UIKit
class StoneLetterFullScreenAd: ObservableObject {
    let adSelector: FullscreenAdSelector
    
    init() {
        let rootVC = UIApplication.shared.firstKeyWindow?.rootViewController
        self.adSelector = FullScreenAdSelectorImpl(context: rootVC!);
    }
    
    func load(platform: AdPlatform, type: FullScreenAdType, adKey: String){
        self.adSelector.load(platform: platform, type: type, adKey: adKey)
    }
    
    func show(platform: AdPlatform, type: FullScreenAdType){
        let loaded = self.adSelector.info().filter{$0.status == .loaded && $0.platform == platform && $0.type == type}
        if let id = loaded.first?.id {
            self.adSelector.show(id: id)
        }
    }
    
    func info() {
        let info = adSelector.info()
        info.forEach{
            print("info \($0)")
        }
    }
}
