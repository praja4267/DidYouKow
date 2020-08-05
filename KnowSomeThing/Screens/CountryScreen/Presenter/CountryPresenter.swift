//
//  CountryPresenter.swift
//  KnowSomeThing
//
//  Created by Rajasekhar on 05/08/20.
//  Copyright © 2020 Rajasekhar. All rights reserved.
//

import Foundation
class CountryPresenter {
    weak var view: CountryView?
    var viewModels: [ItemModel] = []
    var country: CountryModel? {
        didSet {
            guard let country = country else {
                self.viewModels = []
                view?.setViewModels(self.viewModels)
                return
            }
            
            self.viewModels = country.rows ?? []
            view?.setScreenTitle(title: country.title ?? "")
            view?.setViewModels(self.viewModels)
        }
    }
    
    struct Constants {
        static let endPoint = "/s/2iodh4vg0eortkl/facts.json"
    }
    init() {
    }
    
    deinit {
    }
    
    func configure(with view: CountryView) {
        self.view = view
    }
}


protocol CountryView: class {
    func setViewModels(_ viewModels: [ItemModel])
    func setScreenTitle(title: String)
    func showLoading()
    func hideLoading()
}
