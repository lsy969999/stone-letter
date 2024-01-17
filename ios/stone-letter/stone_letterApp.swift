//
//  stone_letterApp.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//
import SwiftUI
import FirebaseCore
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      //firebase init
      let filePath = Bundle.main.path(forResource: Const.FIREBASE_OPTIONS_PATH, ofType: "plist")!;
      let options = FirebaseOptions.init(contentsOfFile: filePath)!
      FirebaseApp.configure(options: options)
      
      //admob init
      GADMobileAds.sharedInstance().start(completionHandler: nil)
      
      print("AppDelegateTEST: \(Const.TEST), ENV: \(Const.ENV)")
    return true
  }
}

@main
struct stone_letterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
