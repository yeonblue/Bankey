//
//  DummyViewController.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/26.
//

import UIKit
import SnapKit
import Then

class DummyViewController: UIViewController {
    
    // MARK: - Properties
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    let label = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    let logoutButton = UIButton(type: .system).then {
        $0.configuration = .filled()
        $0.setTitle("Logout", for: .normal)
        $0.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
    
    weak var delegate: LogoutDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
}

extension DummyViewController {
    func setup() {
        
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func logoutButtonTapped() {
        delegate?.didLogout()
    }
}
