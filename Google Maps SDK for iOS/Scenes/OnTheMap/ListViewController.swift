//
//  ListViewController.swift
//  optima
//
//  Created by Тауекел on 16.01.2024.
//

import UIKit
import SnapKit
import Alamofire

final class ListViewController: UIViewController {
    // MARK: - Private properties
    private var list: [Item]?
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorInset = UIEdgeInsets(
            top: 0, left: 55, bottom: 0, right: 0
        )
        tableView.backgroundColor = UIColor(
            red: 0.97, green: 0.96, blue: 0.98, alpha: 1
        )
        tableView.registerCell(ListTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fetchList()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(tableView)
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Network
    private func fetchList() {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "mocki.io"
        urlComponent.path = "/v1/8474ec09-49e9-4704-b96f-0d1543ec2656"
        
        guard let url = urlComponent.url else { return }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: List.self) { response in
                switch response.result {
                case .success(let data):
                    self.list = data.list
                    self.tableView.reloadData()
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
            }
    }
}

// MARK: - UITableViewDataSource, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        90
    }

    func tableView(
        _ tableView: UITableView, 
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.list?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            forIndexPath: indexPath
        ) as ListTableViewCell
        cell.item = self.list?[indexPath.row]
        cell.backgroundColor = UIColor(
            red: 0.97, green: 0.96, blue: 0.98, alpha: 1
        )
        let numberOfRows = self.tableView(
            tableView, 
            numberOfRowsInSection: indexPath.section
        )
        cell.hidesTopSeparator = indexPath.row == 0
        cell.hidesBottomSeparator = indexPath.row == numberOfRows - 1
        return cell
    }
}
