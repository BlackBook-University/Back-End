//
//  ContentView.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 5/21/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            Blackbooklogo()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tag(0)
            Blackbooklogo()
                .tabItem {
                    VStack {
                        Image(systemName: "mappin.circle")
                        Text("Map")
                    }
                }
                .tag(1)
           Blackbooklogo()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                }
                .tag(2)
            Blackbooklogo()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
                .tag(3)
        }
        .padding(0.0)
        .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
        .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/-610.0/*@END_MENU_TOKEN@*/)
        
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            ContentView()
            .background(Color("Offwhite"))
            .edgesIgnoringSafeArea(.vertical)
//            Image("Black (1)")
//                .resizable()
//                .frame(width: 400.0, height: 400.0)
//                .clipShape(Circle())
//                .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/-350.0/*@END_MENU_TOKEN@*/)
//                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
//                .scaleEffect(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        }
        
    }
}

extension Color {
    static let dominantColor = Color("Offwhite")
}


struct Blackbooklogo: View {
     @State private var searchTerm: String = ""
    var body: some View {
        ZStack{
            Image("Black (1)")
                .resizable()
                .frame(width: 400.0, height: 400.0)
                .clipShape(Circle())
                .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/-350.0/*@END_MENU_TOKEN@*/)
                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                .scaleEffect(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            
            Color("Offwhite")
                .edgesIgnoringSafeArea(.vertical)
         
            SearchBar(text: $searchTerm)
                .background(Color.black)
                .padding(.top, 10.0)
                .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/391.0/*@END_MENU_TOKEN@*/)
                
        }
    }
}


