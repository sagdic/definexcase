//
//  HomeView.swift
//  definexcase
//
//  Created by Digiturk on 21.01.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection){
            DiscoverView()
                .tabItem {
                    Image(systemName: "handbag.fill")
                    selection == 0 ? Text("discover").font(.custom(.regular, size: 14)) : nil
                }
                .tag(0)
            SecondView()
                .tabItem {
                    Image(systemName: "book.fill")
                    selection == 1 ? Text("second") : nil
                }
                .tag(1)
            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    selection == 2 ? Text("cart") : nil
                }
                .tag(2)
            FavoriteView()
                .tabItem {
                    Image(systemName: "tag.fill")
                    selection == 3 ? Text("favorite") : nil
                }
                .tag(3)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    selection == 4 ? Text("profile") : nil
                }
                .tag(4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            HomeView()
                .environment(\.locale, .init(identifier: "en"))
            HomeView()
                .environment(\.locale, .init(identifier: "tr"))
        }
    }
}
