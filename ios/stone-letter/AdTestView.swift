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
            ad.load(adKey: "ca-app-pub-3940256099942544/4411468910")
        }, label: {
            Text("Load")
        })
        Button(action: {
            ad.show()
        }, label: {
            Text("show")
        })
    }
}

#Preview {
    AdTestView()
}
