//
//  ViewController.swift
//  DidYouKnow
//
//  Created by Rajasekhar on 05/08/20.
//  Copyright © 2020 Rajasekhar. All rights reserved.
//

import UIKit
import Anchorage

class CountryViewController: UIViewController {
    let itemsTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let presenter: CountryPresenter
    var models: [ItemModel]?
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
         loader.hidesWhenStopped = true
        return loader
    }()
    
    var refreshControl = UIRefreshControl()
    
    init() {
        self.presenter = CountryPresenter()
        super.init(nibName: nil, bundle: nil)
        presenter.configure(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.updateCountryData()
    }

    func setupUI() {
        self.view.addSubview(loader)
        loader.center = view.center
        self.view.backgroundColor = .white
        self.view.addSubview(itemsTableView)
        itemsTableView.edgeAnchors == view.edgeAnchors
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = .defaultBlue
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        itemsTableView.addSubview(refreshControl)
        itemsTableView.tableFooterView = UIView()
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        presenter.updateCountryData {
            DispatchQueue.main.async {[weak self] in
                UIView.animate(withDuration: 0.5, animations: {
                    sender.endRefreshing()
                    self?.itemsTableView.contentOffset = CGPoint.zero
                })
            }
        }
    }
}

extension CountryViewController: CountryView {
    func showError(error: APIError) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
    
    func setScreenTitle(title: String) {
        DispatchQueue.main.async {
            self.title = title
        }
    }
    
    func setViewModels(_ viewModels: [ItemModel]) {
        self.models = viewModels
        DispatchQueue.main.async { [weak self] in
            self?.itemsTableView.reloadData()
        }
    }
    
    func showLoading() {
        loader.startAnimating()
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loader.stopAnimating()
        }
    }
}

extension CountryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = models?[indexPath.row] else { return UITableViewCell() }
        if item.imageHref == nil && item.title == nil && item.description == nil {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        cell.configureCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let item = models?[indexPath.row] , item.imageHref == nil && item.title == nil && item.description == nil {
            return 0.1
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
