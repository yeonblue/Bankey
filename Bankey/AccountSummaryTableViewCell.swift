//
//  AccountSummaryTableViewCell.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/28.
//

import UIKit
import SnapKit
import Then

class AccountSummaryTableViewCell: UITableViewCell {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    
    struct AccountSummaryCellViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var attributedBalanceString: NSMutableAttributedString?{
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    static let reuseIdentifier = "AccountSummaryTableViewCell"
    static let rowHeight: CGFloat = 90
    
    // MARK: - Properties
    let viewModel: AccountSummaryCellViewModel? = nil
    
    let typeLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.adjustsFontForContentSizeCategory = true
        $0.text = "Account Type"
    }
    
    let underlineView = UIView().then {
        $0.backgroundColor = .mainTheme
    }
    
    let nameLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .body)
        $0.adjustsFontForContentSizeCategory = true
        $0.text = "Account Name"
    }
    
    let balanceStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    let balanceLabel = UILabel().then {
        $0.textAlignment = .right
        $0.text = "Balance"
    }
    
    let balanceAmountLabel = UILabel().then {
        $0.textAlignment = .right
    }
    
    let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")?.withTintColor(.mainTheme,
                                                                       renderingMode: .alwaysOriginal)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryTableViewCell {
    private func layout() {
        contentView.addSubview(typeLabel) // tableViewCell의 경우 contentView에 추가
        typeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.leading.equalTo(typeLabel.snp.leading)
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
            make.width.equalTo(typeLabel.snp.width)
            make.height.equalTo(3)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeLabel)
            make.top.equalTo(underlineView.snp.bottom).offset(16)
        }
        
        contentView.addSubview(balanceStackView)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(balanceAmountLabel)
        
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        balanceStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(48)
        }
        
        contentView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(16)
        }
    }
    
    func configure(viewModel: AccountSummaryCellViewModel) {
        typeLabel.text = viewModel.accountType.rawValue
        nameLabel.text = viewModel.accountName
        balanceAmountLabel.attributedText = viewModel.attributedBalanceString
        
        switch viewModel.accountType {
            
        case .Banking:
            underlineView.backgroundColor = .mainTheme
            balanceLabel.text = "Balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Current Balance"
        case .Investment:
            underlineView.backgroundColor = .systemIndigo
            balanceLabel.text = "Value"
        }
    }
}
