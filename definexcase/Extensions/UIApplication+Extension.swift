//
//  UIApplication+Extension.swift
//  definexcase
//
//  Created by Digiturk on 21.01.2023.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
