//
//  DiscoverView.swift
//  definexcase
//
//  Created by Digiturk on 21.01.2023.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var authentication: Authentication
    @StateObject private var discoverVM = DiscoverViewModelImpl(service: DefinexServiceImpl())
    @State private var isRefreshing = false
    
    
    var body: some View {
        ZStack {
            content
            if discoverVM.isRefreshing {
                VStack {
                    RefreshIndicator()
                    Spacer()
                }
            }
        }.task {
            discoverVM.getFirstList()
            discoverVM.getSecondList()
            discoverVM.getThirdList()
        }
    }
    
    @ViewBuilder
     private var content: some View {
         if (discoverVM.lists[.first] == nil) {
         ProgressView()
       } else {
         VStack {
           discoverView
         }
       }
     }
    
    private var discoverView: some View {
        RefreshableScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 24){
                                AvatarView()
                                Text("Home")
                                    .font(.title)
                            }.padding(8)
                            Group {
                                switch discoverVM.state {
                                case .loading:
                                    ProgressView()
                                case .failed(error: let error):
                                    ErrorView(error: error, handler: discoverVM.getFirstList)
                                case .success(content: _):
                                    VStack(spacing: 16) {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 8){
                                                ForEach(discoverVM.lists[.first] ?? []) { item in
                                                    ProductCardView(productList: item)
                                                        .frame(height: 240)
                                                }
                                            }
                                        }
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 16) {
                                                ForEach(discoverVM.lists[.second] ?? []) { item in
                                                    ProductCardView(productList: item)
                                                        .frame(width: 120, height: 180)
                                                }
                                            }
                                        }
                                        LazyVGrid(columns: [
                                            GridItem(.flexible(minimum: 0, maximum: .infinity)),
                                            GridItem(.flexible(minimum: 0, maximum: .infinity))
                                        ], spacing: 16) {
                                            ForEach(discoverVM.lists[.third] ?? []) { item in
                                                ProductCardView(productList: item)
                                            }
                                        }
                                    }
                                }
                            }
                        }
        }
        .refreshable {
            discoverVM.refresh()
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}


