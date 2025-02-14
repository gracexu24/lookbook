//
//  CustomTabBar.swift
//  lookbook
//
//  Created by Vivian  Ni on 2/8/25.
//


import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    
    @State var tabPoints : [CGFloat] = []
    //storing each tabs midpoint
    
    var body: some View {
        HStack(spacing: 0){
            TabBarButton(image: "house", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "magnifyingglass.circle", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "plus.circle", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
        }
        .padding()
        .background(Color("Tab"))
        .cornerRadius(30)
        .padding(.horizontal)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints : [CGFloat]
    
    var body: some View {
        //midpoint of each button for curve animation
        GeometryReader{reader -> AnyView in
            
            return AnyView(
                Button(action: {
                    //changing tabs
                    withAnimation{
                        selectedTab = image
                    }
                }, label: {
                    //filling the color if it's selected
                    
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color("TabSelected"))
                    //lifting view if its selected
                        .offset(y: selectedTab == image ? -10 : 0)
                })
                //max frame
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        //maxHeight
        .frame(height: 50)
    }
}
