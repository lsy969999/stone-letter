//
//  Ad.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//

import Foundation
enum AdPlatform: String {
    case admob = "admob"
    case appLovin = "applovin"
}

enum FullScreenAdType: String {
    case interstitial = "interstitial"
    case rewarded = "rewarded"
    case native = "native"
    case mrec = "mrec"
}

enum BannerAdType: String {
    case banner = "banner"
    case native = "native"
}

enum AdStatus: String {
    case none = "none"
    case loading = "loading"
    case loaded = "loaded"
    case showing = "showing"
}
