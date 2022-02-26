//
//  LocalData.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/26.
//

import Foundation

public class LocalData {
    private enum Keys: String {
        case hasOnboarded
    }
    
    public static var hasOnboarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
            // UserDefaults.standard.synchronize() // 굳이 쓰지 않아도 됨
        }
    }
}
