//
//  Home.swift
//  lookbook2
//
//  Created by Vivian  Ni on 2/8/25.
//

import SwiftUI

struct Home: View {
    @State var selectedTab =  "house"
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Color("TabBG")
                .ignoresSafeArea()
            
            //tab bar
            CustomTabBar(selectedTab: $selectedTab)
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
