//
//  UILabel+CustomFont.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 16.07.2024.
//

import UIKit

extension UILabel {
    func setCustomFont(name: String, size: CGFloat, textStyle: UIFont.TextStyle) {
        if let customFont = UIFont(name: name, size: size) {
            self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
            self.adjustsFontForContentSizeCategory = true
        }
    }
}
