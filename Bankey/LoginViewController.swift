//
//  ViewController.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/20.
//

import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {

    // MARK: - Properties
    let loginView = LoginView()
    let signInButton = UIButton(type: .system).then {
        $0.configuration = .filled() // iOS 15에 추가 된 기능. filled Style
        $0.configuration?.imagePadding = 8
        $0.setTitle("Sign In", for: .normal)
        
        // .primaryActionTriggered is not limited to buttons, but to controls in general.
        // touchUpInside로 써도 무방
        $0.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
    }
    
    let errorMsgLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .systemRed
        $0.numberOfLines = 0
        $0.isHidden = true
    }
    
    // Login
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
}

extension LoginViewController {
    private func setup() {
        
        // snapKit 내부에서 아래 코드를 호출하고 있으므로 별도 호출 불필요
        // loginView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMsgLabel)
        
        loginView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8) // superview 기준이므로 inset이 적합
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        errorMsgLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
}

// MARK: - SignIn
extension LoginViewController {
    @objc func signInTapped() {
        errorMsgLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            
            // fatalError()는 앱을 그냥 죽이므로 사용할 일은 거의 없음.
            // assert() 와 assertionFailure() 함수는 디버그 모드에서만 동작.
            // precondition() 과 preconditionFailure() 항상 체크한다.
            assertionFailure("loginView로부터 전달받은 username, password가 nil")
            return
        }

        if username.isEmpty || password.isEmpty {
            showLoginFailMessage(withMessage: "Username or Password cannot be blank")
            return
        }
        
        // 단순히 테스트용 prototype 앱이므로 이러한 방식으로 구현.
        if username == "test" && password == "1234" {
            // iOS 15추가 기능, 버튼 indicator 표시
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            showLoginFailMessage(withMessage: "Incorrect Username or Password")
        }
    }
    
    private func showLoginFailMessage(withMessage message: String) {
        errorMsgLabel.isHidden = false
        errorMsgLabel.text = message
    }
}
