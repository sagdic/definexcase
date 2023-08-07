//
//  FloatingTextField.swift
//  definexcase
//
//  Created by Digiturk on 19.01.2023.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let text: Binding<String>
    let icon: String
    let isSecured: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            Text(LocalizedStringKey(title))
                .foregroundColor(text.wrappedValue.isEmpty ? Color(.placeholderText) : .accentColor)
                .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.75, anchor: .leading)
            VStack {
                HStack {
                    Group {
                        if isSecured {
                            SecureField("", text: text).textInputAutocapitalization(.never)
                        } else {
                            TextField("", text: text).textInputAutocapitalization(.never)
                        }
                    }
                    Spacer()
                    Image(systemName: icon).foregroundColor(.gray)
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.accentColor)
            }
        }
        .padding(.top, 15)
        .padding(.horizontal, 16)
        .animation(.spring(response: 0.4, dampingFraction: 0.3))
    }
}
