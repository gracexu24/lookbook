//
//  Home.swift
//  lookbookKT
//
//  Created by Tejas Tirthapura on 2/8/25.
//

import SwiftUI
struct Search: View {
    //View Properties
    @State private var searchText: String = ""
    @FocusState private var isSearching: Bool
    @State private var activeTab: Tab = .all
    @Environment(\.colorScheme) private var scheme
    @Namespace private var animation
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15 ) {
                DummyMessagesView()
            }
            .safeAreaPadding(15)
            .safeAreaInset(edge: .top, spacing: 0){
                ExpandableNavigationBar()
            }
        }
        .background(.gray.opacity(0.15))
        .contentMargins(.top, 190, for: .scrollIndicators)
    }
        
    ///Expandable Navigation Bar
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
            //Custom Segmented Picker
            ScrollView(.horizontal){
                HStack(spacing: 12){
                    ForEach(Tab.allCases, id:\.rawValue) { tab in
                        Button(action: {
                            withAnimation(.snappy) {
                                activeTab = tab
                            }
                        }) {
                            Text(tab.rawValue)
                                .font(.callout)
                                .foregroundStyle(activeTab == tab ? (scheme == .dark ? .black
                                    : .white) : Color.primary )
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .background{
                                    if activeTab == tab {
                                        Capsule()
                                            .fill(Color.primary)
                                            .matchedGeometryEffect(id: "ACTIVETAB", in:
                                                animation)
                                    } else {
                                        Capsule()
                                            .fill(.background)
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
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
    ///Dummy Messages View
    @ViewBuilder
    func DummyMessagesView() -> some View {
        ForEach(0..<200, id: \.self) { _ in
            HStack(spacing: 20) {
                Circle()
                    .frame(width: 55, height: 55)
                VStack(alignment: .leading, spacing: 6, content: {
                    Rectangle()
                        .frame(width: 140, height: 8)
                    Rectangle()
                        .frame(width: 80, height: 8)
                    Rectangle()
                        .frame(width: 80, height: 8)
                })
            }
            .foregroundStyle(.gray.opacity(0.4))
            .padding(.horizontal, 10)
        }
    }
}
struct Search_Preview: PreviewProvider {
    static var previews: some View{
        Search()
    }
}
    

