//
//  UIAlert+.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/12/07.
//

import Foundation
import UIKit

extension UIViewController {
    // Networking Alert
    func makeAlert(title: String,
                   message: String,
                   okAction : ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> ())? = nil)
    {
        let alertViewController = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
