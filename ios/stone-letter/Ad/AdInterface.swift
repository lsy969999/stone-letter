//
//  AdI.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//

import Foundation
import UIKit

protocol FullscreenAdSelector {
    func able(platform: AdPlatform, type: FullScreenAdType) -> Bool
    func load(platform: AdPlatform, type: FullScreenAdType, adKey: String)
    func show(id: String)
    func info() -> [FullScreenAdInfo]
    func clear(id: String)
}

protocol FullscreenAdCallback {
    func onLoadSuccess(id: String, platform: AdPlatform, type: FullScreenAdType)
    func onLoadFail(id: String, platform: AdPlatform, type: FullScreenAdType, error: String)
    func onOpen(id: String, platform: AdPlatform, type: FullScreenAdType)
    func onClick(id: String, platform: AdPlatform, type: FullScreenAdType)
    func onClose(id: String, platform: AdPlatform, type: FullScreenAdType)
    func onRewarded(id: String, platform: AdPlatform, type: FullScreenAdType, amount: Double?)
    func onException(id: String, platform: AdPlatform, type: FullScreenAdType, error: String)
}

protocol BannerAdSelector {
    func able(platform: AdPlatform, type: BannerAdType) -> Bool
    func info() -> [BannerAdInfo]
    
    func launch(context: UIViewController, platform: AdPlatform, type: BannerAdType, adKey: String)
    func remove(id: String)
}

protocol BannerAdCallback {
    func onLoadSuccess(id: String, platform: AdPlatform, type: BannerAdType)
    func onLoadFail(id: String, platform: AdPlatform, type: BannerAdType, error: String)
    func onOpen(id: String, platform: AdPlatform, type: BannerAdType)
    func onClick(id: String, platform: AdPlatform, type: BannerAdType)
    func onClose(id: String, platform: AdPlatform, type: BannerAdType)
    func onException(id: String, platform: AdPlatform, type: BannerAdType, error: String)
}

protocol FullScreenAd{
    var id: String { get set }
    var platform: AdPlatform { get };
    var status: AdStatus { get set };
    var type: FullScreenAdType { get };
    func load(adKey: String)
    func show()
    func info() -> FullScreenAdInfo
}

protocol BannerAd {
    var id: String { get set }
    var platform: AdPlatform { get };
    var status: AdStatus { get set };
    var type: BannerAdType { get };
    func info() -> BannerAdInfo
    func launch(context: UIViewController, adKey: String)
}

struct FullScreenAdInfo {
    let id: String
    let platform: AdPlatform
    let type: FullScreenAdType
    let status: AdStatus
    let adLoaded: Int?
}

struct BannerAdInfo {
    let id: String
    let platform: AdPlatform
    let type: BannerAdType
    let status: AdStatus
    let adLoaded: Int?
}
