//
//  CountryModel.swift
//  DidYouKnow
//
//  Created by Rajasekhar on 05/08/20.
//  Copyright © 2020 Rajasekhar. All rights reserved.
//

import Foundation
struct CountryModel: Decodable {
    var title: String?
    let rows: [ItemModel]?
}

struct ItemModel: Decodable {
    var title: String?
    var description: String?
    let imageHref: String?
}
