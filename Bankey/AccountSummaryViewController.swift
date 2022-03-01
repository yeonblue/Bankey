//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/27.
//

import UIKit
import SnapKit
import Then

class AccountSummaryViewController: UIViewController {
    
    struct Username {
        let firstName: String
        let lastName: String
    }
    
    var username: Username?
    var accountInfo: [AccountSummaryTableViewCell.AccountSummaryCellViewModel] = []
    
    // MARK: - Properties
    var tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        genearateSampleAccountInfo()
    }
}

extension AccountSummaryViewController {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryTableViewCell.self,
                           forCellReuseIdentifier: AccountSummaryTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = AccountSummaryTableViewCell.rowHeight
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupHeaderView()
    }
    
    private func setupHeaderView() {
        let headerView = AccountSummaryHeaderView(frame: .zero)
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) // 가장 작은 사이즈 기준
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension AccountSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! AccountSummaryTableViewCell
        let accountInfo = accountInfo[indexPath.row]
        cell.configure(viewModel: accountInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountInfo.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AccountSummaryViewController {
    func genearateSampleAccountInfo() {
        typealias ViewModel = AccountSummaryTableViewCell.AccountSummaryCellViewModel
        
        let savings = ViewModel(accountType: .Banking,
                                accountName: "Basic Savings",
                                balance: 929466.23)
        let chequing = ViewModel(accountType: .Banking,
                                 accountName: "No-Fee All-In Chequing",
                                 balance: 17562.44)
        let visa = ViewModel(accountType: .CreditCard,
                             accountName: "Visa Avion Card",
                             balance: 412.83)
        let masterCard = ViewModel(accountType: .CreditCard,
                                   accountName: "Student Mastercard",
                                   balance: 50.83)
        let investment1 = ViewModel(accountType: .Investment,
                                    accountName: "Tax-Free Saver",
                                    balance: 2000.00)
        let investment2 = ViewModel(accountType: .Investment,
                                    accountName: "Growth Fund",
                                    balance: 15000.00)
        
        accountInfo.append(savings)
        accountInfo.append(chequing)
        accountInfo.append(visa)
        accountInfo.append(masterCard)
        accountInfo.append(investment1)
        accountInfo.append(investment2)
    }
}
