//
//  ProductCardView.swift
//  definexcase
//
//  Created by Digiturk on 22.01.2023.
//

import SwiftUI
import URLImage

struct ProductCardView: View {
    let productList: ProductList
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 1, x: 0, y: 1)
            
            VStack(alignment: .leading, spacing: 8) {
                ViewHelpers.loadProductImage(for: productList)
                
                Text(productList.description)
                    .font(.custom(.regular, size: 12))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                if productList.ratePercentage != nil{
                    Spacer()
                }
                Text(formatPrice(productList.price))
                    .font(.custom(.medium, size: productList.ratePercentage != nil ? 16 : 12))
                    .padding(.top, productList.ratePercentage != nil ? 16 : 8)
                
                HStack(spacing: 2){
                    if let oldPrice = productList.oldPrice{
                        Text(formatPrice(oldPrice))
                            .font(.custom(.medium, size: 12))
                            .strikethrough()
                    }
                    if let discount = productList.discount{
                        if !discount.isEmpty {
                            Text("·")
                                .font(.custom(.regular, size: 14))
                            Text(discount)
                                .font(.custom(.medium, size: 12))
                                .foregroundColor(.discountColor)
                        }
                    }
                    
                }
                if let percentage = productList.ratePercentage {
                    HStack {
                                ForEach(0..<5) { index in
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 12,height: 12)
                                        .foregroundColor(index < Int(percentage / 20) ? .green : .gray)
                                        
                                }
                    }
                    .padding(.bottom, 10)
                }
                
            }
            .padding(8)
        }
    }
    
    
    
    private func formatPrice(_ price: Price?) -> String {
            if let value = price?.value, let currency = price?.currency {
                return String(format: "%.2f", value) + " " + currency + "US"
            } else {
                return ""
            }
        }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(productList: ProductList.dummyData)
    }
}


