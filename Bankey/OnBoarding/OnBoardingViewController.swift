//
//  OnBoardingViewController.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/22.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    // MARK: - Properties
    
    let imgName: String
    let labelText: String
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let label = UILabel().then {
        $0.textAlignment = .center
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.numberOfLines = 0

        // 폰트 크기를 조정할 때, 적절한 크기로 리사이즈
        // adjustsFontSizeToFitWidth는 크기가 모자라면 적당히 줄임
        $0.adjustsFontForContentSizeCategory = true
    }
    
    // MARK: - Lifecycle
    init(imgName: String, labelText: String) {
        self.imgName = imgName
        self.labelText = labelText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
}

extension OnBoardingViewController {
    private func setup() {
        imageView.image = UIImage(named: imgName)
        label.text = labelText
        view.backgroundColor = .white
    }
    
    private func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
}
