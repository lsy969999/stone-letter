//
//  AdI.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//

import Foundation

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

protocol AdFunction {
    var id: String { get set }
    var platform: AdPlatform { get };
    var status: AdStatus { get set };

    func load(adKey: String)
    func show()
}

protocol FullScreenAd: AdFunction{
    var type: FullScreenAdType { get };
    func info() -> FullScreenAdInfo
}

protocol BannerAd: AdFunction {
    var type: BannerAdType { get };
}

struct FullScreenAdInfo {
    let id: String
    let platform: AdPlatform
    let type: FullScreenAdType
    let status: AdStatus
    let adLoaded: Int?
}
