//
//  Extension.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/26.
//

import UIKit

extension UIColor {
    static let mainTheme = UIColor.systemTeal
}

extension UIViewController {
    func setStatusBar() {
        let statusBarSize = UIApplication.shared.statusBarFrame.size // Deprecated 되었으나 사용 가능
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusbarView = UIView(frame: frame)
        
        statusbarView.backgroundColor = .mainTheme
        view.addSubview(statusbarView)
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large) // iOS 13 이상
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
