//
//  ViewController.swift
//  KnowSomeThing
//
//  Created by Rajasekhar on 05/08/20.
//  Copyright © 2020 Rajasekhar. All rights reserved.
//

import UIKit
import Anchorage

class CountryViewController: UIViewController {
    let itemsTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style:UITableView.Style.plain)
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let presenter: CountryPresenter
    var viewModels: [ItemModel]?
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
         loader.hidesWhenStopped = true
        return loader
    }()
    
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
        self.viewModels = viewModels
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
        return viewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell, let item = viewModels?[indexPath.row] else { return UITableViewCell() }
        cell.configureCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
