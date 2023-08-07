//
//  Authentication.swift
//  definexcase
//
//  Created by Digiturk on 21.01.2023.
//

import SwiftUI

class Authentication: ObservableObject {
    
    @Published var isValidated = false
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
}
