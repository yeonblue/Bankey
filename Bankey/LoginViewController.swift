//
//  ViewController.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/20.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
}

extension LoginViewController {
    private func setup() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8) // superview 기준이므로 inset이 적합
        }
    }
}
