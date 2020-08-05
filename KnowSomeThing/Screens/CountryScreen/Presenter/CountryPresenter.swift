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
    
    func updateCountryData(completion: (() -> Void)? = nil) {
          view?.showLoading()
          RestManager.shared.getRequest(endpoint: Constants.endPoint) { result in
              switch result {
              case .success(let country):
                  self.country = country
              case .failure(let error):
                  self.view?.showError(error: error)
              }
              self.view?.hideLoading()
            completion?()
          }
      }
}

protocol CountryView: class {
    func setViewModels(_ viewModels: [ItemModel])
    func setScreenTitle(title: String)
    func showLoading()
    func hideLoading()
    func showError(error: APIError)
}
