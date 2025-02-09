//
//  Profile.swift
//  lookbook2
//
//  Created by Tejas Tirthapura on 2/9/25.
//

import SwiftUI

struct Profile: View{
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Image("fit")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(22)
                        .padding(.top, 2)
                        
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                VStack{
                   Text("Hi, I'm Tejas")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x:45, y:-20)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

            }
        }
    }
    
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
