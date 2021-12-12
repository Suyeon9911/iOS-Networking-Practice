//
//  postItemDelegate.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/12/12.
//

import Foundation

protocol PostItemDelegate {
    func titleDataSend(title: String)
    func priceDataSend(price: String)
    func contentDataSend(content: String)
}
