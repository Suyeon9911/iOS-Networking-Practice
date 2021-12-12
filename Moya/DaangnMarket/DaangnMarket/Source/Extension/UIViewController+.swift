//
//  UIViewController+.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/12/12.
//

import Foundation

extension WritingViewController: PostItemDelegate {
    func titleDataSend(title: String) {
        let titleCell =  TextFieldTableViewCell()
        titleCell.type = .plain

        //self.receiveData[0] = titleCell.textField.text ?? ""
    }

    func priceDataSend(price: String) {
        let priceCell =  TextFieldTableViewCell()
        priceCell.type = .button

        //self.receiveData[1] = priceCell.textField.text ?? ""
    }

    func contentDataSend(content: String) {
        let contentCell = TextViewTableViewCell()

        //self.receiveData[2] = contentCell.textView.text ?? ""
    }


}
