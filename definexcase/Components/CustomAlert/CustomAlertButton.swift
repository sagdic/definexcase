//
//  CustomAlertButton.swift
//  definexcase
//
//  Created by Digiturk on 22.01.2023.
//

import SwiftUI

struct CustomAlertButton: View {

    // MARK: - Value
    // MARK: Public
    let title: LocalizedStringKey
    var action: (() -> Void)? = nil
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        Button {
          action?()
        
        } label: {
            Text(title)
                .font(.custom(.regular, size: 12))
                .foregroundColor(.white)
                .padding(.horizontal, 10)
        }
        .frame(height: 30)
        .background(Color.loginBtnGrad1)
        .cornerRadius(15)
    }
}
