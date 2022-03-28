//
//  PaddingLabel.swift
//  Speeches
//
//  Created by turu on 2022/03/29.
//

import UIKit

// https://stackoverflow.com/questions/27459746/adding-space-padding-to-a-uilabel/58876988#58876988
class PadddingLabel: UILabel {
    var topInset: CGFloat = 0
    var bottomInset: CGFloat = 0
    var leftInset: CGFloat = 0
    var rightInset: CGFloat = 0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        let rects = bounds.inset(by: insets)
        return super.textRect(forBounds: rects, limitedToNumberOfLines: numberOfLines)
    }
}
