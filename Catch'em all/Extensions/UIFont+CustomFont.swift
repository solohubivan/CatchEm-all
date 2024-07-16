//
//  UIFont+CustomFont.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 17.07.2024.
//

import UIKit

extension UIFont {
    static func customFont(name: String, size: CGFloat, textStyle: UIFont.TextStyle) -> UIFont {
        let customFont = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
    }
}
