//
//  BannerAdView.swift
//  stone-letter
//
//  Created by SY L on 1/18/24.
//

import Foundation
import SwiftUI

struct BannerAdView: UIViewControllerRepresentable {
    @State private var viewWidth: CGFloat = .zero
    @ObservedObject var viewModel: StoneLetterBannerAd
    func makeUIViewController(context: Context) -> some UIViewController {
        let bannerViewController = BannerViewController()
        viewModel.launch(context: bannerViewController, platform: .admob, type: .banner, adKey: "ca-app-pub-3940256099942544/2934735716")
        return bannerViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


class BannerViewController: UIViewController {
    
}
