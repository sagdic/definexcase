//
//  AvatarView.swift
//  definexcase
//
//  Created by Tayfun Sagdic on 6.08.2023.
//

import SwiftUI

struct AvatarView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.avatarGrad1, Color.avatarGrad0]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .mask(
                Circle()
                    .frame(width: 40, height: 40)
            )
            
            Text("NA")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.white)
        }
        .frame(width: 40, height: 40)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}
