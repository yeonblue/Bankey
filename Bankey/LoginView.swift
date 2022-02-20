//
//  LoginView.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/20.
//

import UIKit
import SnapKit
import Then

class LoginView: UIView {
    
    // MARK: - Properties
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    let usernameTextField = UITextField().then {
        $0.placeholder = "Username"
    }
    
    let passwordTextField = UITextField().then {
        $0.placeholder = "Password"
        $0.isSecureTextEntry = true
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    // 스토리보드에서 쓰는 초기화 함수
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    func setup() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        backgroundColor = .orange
    }
    
    func layout() {
        
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

    }
}

// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
