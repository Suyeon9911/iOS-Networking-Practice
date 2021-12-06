//
//  PostItemRequest.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/12/07.
//

import Foundation
import SwiftUI

struct PostRequest: Codable {
    var title: String
    var category: String
    var price: String
    var state: String
    var trade: String
    var content: String

    init(_ title: String, _ category: String, _ price: String, _ state: String, _ trade: String, _ content: String) {
        self.title = title
        self.category = category
        self.price = price
        self.state = state
        self.trade = trade
        self.content = content
    }
}
