//
//  Font+Extension.swift
//  definexcase
//
//  Created by Digiturk on 19.01.2023.
//

import SwiftUI

extension Font {
    static func custom(_ font: CustomFont, size: CGFloat) -> SwiftUI.Font{
        SwiftUI.Font.custom(font.rawValue, size: size)
    }
}
