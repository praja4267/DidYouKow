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
    
    init() {
        self.presenter = CountryPresenter()
        super.init(nibName: nil, bundle: nil)
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
        self.view.backgroundColor = .white
        self.view.addSubview(itemsTableView)
        itemsTableView.edgeAnchors == view.edgeAnchors
    }
}


