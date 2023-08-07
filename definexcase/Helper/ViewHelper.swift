//
//  ViewHelper.swift
//  definexcase
//
//  Created by Tayfun Sagdic on 6.08.2023.
//

import SwiftUI
import URLImage

class ViewHelpers {
    static func loadProductImage(for productList: ProductList) -> some View {
        if let imgUrl = productList.imageURL, let url = URL(string: imgUrl) {
            return AnyView(
                URLImage(url,
                         failure: { error, _ in
                             PlaceHolderImageView()
                         },
                         content: { image in
                             image
                                 .resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .cornerRadius(3)
                         })
            )
        } else {
            return AnyView(PlaceHolderImageView())
        }
    }
}

struct PlaceHolderImageView: View {
    
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}
