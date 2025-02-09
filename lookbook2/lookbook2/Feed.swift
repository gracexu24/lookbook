//
//  Feed.swift
//  lookbook2
//
//  Created by Vivian  Ni on 2/8/25.
//

import SwiftUI

import SwiftUI

struct Feed: View {
    var body: some View {
        ZStack {
            ScrollView{
                VStack(){
                    ProfileView()
                        .padding()
                    Spacer()
                    VStack {
                        ZStack{
                            Image("fit")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(22)
                                .frame(width: 320, height: 340)
                                .padding(.top, 150)
                                .padding(.bottom, 150)
                            VStack{
                                
                            }
                            .padding(100)
                            .frame(width:320, height: 150)
                            .background(.ultraThinMaterial)
                            .cornerRadius(22)
                            .offset(x: 0, y: 210)
                            VStack{
                                Text("@vivianknee")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .offset(x: -75, y: 160)
                                Text("Hi this is my OOTD!")
                                    .font(.system(size: 10))
                                    .fontWeight(.bold)
                                    .offset(x: -75, y: 165)
                            }
                            HStack{
                                Image(systemName: "hand.thumbsup")
                                
                            }
                            
                        }
                        //stack ends
                        ZStack{
                            Image("fit2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(22)
                                .frame(width: 320, height: 340)
                                .padding(.top, 150)
                                .padding(.bottom, 150)
                            VStack{
                                
                            }
                            .padding(100)
                            .frame(width:320, height: 150)
                            .background(.ultraThinMaterial)
                            .cornerRadius(22)
                            .offset(x: 0, y: 210)
                            VStack{
                                Text("@vivianknee")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .offset(x: -75, y: 160)
                                Text("Hi this is my OOTD!")
                                    .font(.system(size: 10))
                                    .fontWeight(.bold)
                                    .offset(x: -75, y: 165)
                            }
                            
                        }
                    }
                }
            }
        }
    }
}


struct Feed_Previews:
    PreviewProvider {
    static var previews: some View {
        Feed()
    }
}

@ViewBuilder
func ProfileView()->some View{
    HStack {
        VStack(alignment: .leading, spacing: 4){
            HStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                })
                Text("Vivian")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
            }
        }
        VStack {
            Text("@viviaknee")
                .font(.system(size: 15))
                .fontWeight(.light)
                .foregroundColor(.gray)
                .offset(x: -75, y: 33)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        Image(systemName: "bell.badge.circle.fill")
            .font(.system(size: 33))
            .foregroundColor(.black.opacity(0.7))
    }
}
