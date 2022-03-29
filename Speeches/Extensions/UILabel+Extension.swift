//
//  UILabel+Extension.swift
//  Speeches
//
//  Created by turu on 2022/03/29.
//

import UIKit

extension UILabel {
    var textSize: CGSize {
        return self.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
    }
}
