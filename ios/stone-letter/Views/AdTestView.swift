//
//  AdTestView.swift
//  stone-letter
//
//  Created by SY L on 1/18/24.
//

import SwiftUI

struct AdTestView: View {
    @StateObject var ad = StoneLetterFullScreenAd()
    @StateObject var banner = StoneLetterBannerAd()
    var body: some View {
        Button(action: {
            ad.info()
        }, label: {
            Text("info")
        })
        Button(action: {
            banner.info()
        }, label: {
            Text("bannerInfo")
        })
        Divider()
        Button(action: {
            ad.load(platform: .admob, type: .interstitial,adKey: "ca-app-pub-3940256099942544/4411468910")
        }, label: {
            Text("Interstitial Load")
        })
        Button(action: {
            ad.show(platform: .admob, type: .interstitial)
        }, label: {
            Text("Interstitial Show")
        })
        
        Divider()
        Button(action: {
            ad.load(platform: .admob, type: .rewarded, adKey: "ca-app-pub-3940256099942544/1712485313")
        }, label: {
            Text("Rewarded Load")
        })
        Button(action: {
            ad.show(platform: .admob, type: .rewarded)
        }, label: {
            Text("Rewarded Show")
        })
        Divider()
        Button(action: {
//            banner.launch(platform: .admob, type: .banner, adKey: "ca-app-pub-3940256099942544/2934735716")
        }, label: {
            Text("Banner launch")
        })
        Button(action: {
//            banner.remove(platform: .admob, type: .banner)
        }, label: {
            Text("Banner remove")
        })
        BannerAdView(viewModel: banner)
        Divider()
        BannerAdView(viewModel: banner)
    }
}

#Preview {
    AdTestView()
}
