//
//  AdTestView.swift
//  stone-letter
//
//  Created by SY L on 1/18/24.
//

import SwiftUI

struct AdTestView: View {
    @StateObject var ad = StoneLetterAd()
    var body: some View {
        Button(action: {
            ad.info()
        }, label: {
            Text("info")
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
    }
}

#Preview {
    AdTestView()
}
