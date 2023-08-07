//
//  SecondView.swift
//  definexcase
//
//  Created by Digiturk on 21.01.2023.
//

import SwiftUI

struct SecondView: View {
    @State private var secondVM = SecondViewViewModel()
    var body: some View {
        VStack {
            Text("second")
            Text(secondVM.rcString)
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
