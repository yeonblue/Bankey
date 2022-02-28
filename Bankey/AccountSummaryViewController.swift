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
    
    // MARK: - Properties
    var tableView = UITableView()
    var cellData = ["dummyData", "dummyData2"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
        cell.typeLabel.text = cellData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

