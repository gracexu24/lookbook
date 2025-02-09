//
//  SearchBar.swift
//  lookbookKT
//
//  Created by Tejas Tirthapura on 2/8/25.
//

import SwiftUI

struct SearchBar : View {
    //View Properties
    @State private var searchText: String = ""
    @FocusState private var isSearching: Bool
    @State private var activeTab: Tab = .all
    @Environment(\.colorScheme) private var scheme
    @Namespace private var animation
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15 ) {
                //DummyMessagesView()
            }
            .safeAreaPadding(15)
            .safeAreaInset(edge: .top, spacing: 0){
                ExpandableNavigationBar()
            }
        }
        .background(.gray.opacity(0.15))
        .contentMargins(.top, 190, for: .scrollIndicators)
    }
    
    @ViewBuilder
    func ExpandableNavigationBar(_ title: String = "Search") -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let progress = max(min(-minY / 70, 1), 0)
            VStack(spacing: 10) {
                ///Title
                Text(title)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                
                ///Search Bar
                HStack(spacing: 12){
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                    TextField("Search Outfits", text: $searchText)
                        .focused($isSearching)
                    
                    
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15 - (progress * 15))
                .frame(height: 45)
                .background {
                    RoundedRectangle(cornerRadius: 25.0 - (progress * 25))
                        .fill(.background)
                        .shadow(color: .gray.opacity(0.25), radius: 10, x:0.0, y: 5)
                        .padding(.bottom, -progress * 65)
                        .padding(.top, -progress * 190)
                        .padding(.horizontal, -progress * 15)
                }
 
                .frame(height:50)
            }
            .padding(.top, 25)
            .safeAreaPadding(.horizontal, 15)
            .offset(y: minY < 0 ? -minY : 0)
            .offset(y: -progress * 65 )
        }
        .frame(height: 190)
        .padding(.bottom, 10)
    }
}

struct SearchBar_Preview: PreviewProvider {
    static var previews: some View{
        Search()
    }
}
