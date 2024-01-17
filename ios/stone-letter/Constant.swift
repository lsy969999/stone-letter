//
//  Constant.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//

import Foundation

struct Const {
    static let TEST = Bundle.main.object(forInfoDictionaryKey: "TEST") as! String
    static let FIREBASE_OPTIONS_PATH = Bundle.main.object(forInfoDictionaryKey: "FIREBASE_OPTIONS_PATH") as! String
    static let ENV = Bundle.main.object(forInfoDictionaryKey: "ENV") as! String
}
