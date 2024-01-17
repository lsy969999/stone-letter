//
//  StoneLetterAd.swift
//  stone-letter
//
//  Created by SY L on 1/18/24.
//

import Foundation
import UIKit
class StoneLetterAd: ObservableObject {
    let adSelector: FullScreenAdSelector
    
    init() {
        let rootVC = UIApplication.shared.firstKeyWindow?.rootViewController
        self.adSelector = FullScreenAdSelector(context: rootVC!);
    }
    
    func load(adKey: String){
        self.adSelector.load(platform: .admob, type: .interstitial, adKey: adKey)
    }
    
    func show(){
        let loaded = self.adSelector.info().filter{$0.status == .loaded}
        let id = loaded.first!.id
        self.adSelector.show(id: id)
    }
}
extension UIApplication {
    var firstKeyWindow: UIWindow? {
        // 1
        let windowScenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
        // 2
        let activeScene = windowScenes
            .filter { $0.activationState == .foregroundActive }
        // 3
        let firstActiveScene = activeScene.first
        // 4
        let keyWindow = firstActiveScene?.keyWindow
        
        return keyWindow
    }
}
