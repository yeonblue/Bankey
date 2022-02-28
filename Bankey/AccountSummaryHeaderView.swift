//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/27.
//

import UIKit
import SnapKit

class AccountSummaryHeaderView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        // UIView.noIntrinsicMetric 프로퍼티를 넘겨주어 해당 방향에 대해서는 고유 크기가 결정되지 않게 가능
        return CGSize(width: UIView.noIntrinsicMetric, height: 150)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = .mainTheme
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
