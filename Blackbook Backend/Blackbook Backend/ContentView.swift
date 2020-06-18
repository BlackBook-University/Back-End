//
//  ContentView.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 5/21/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import SwiftUI
import UIKit
import Firebase
import Foundation

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
               Home()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tag(0)
            Calendarview()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
                .tag(1)
           Calendarview()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                }
                .tag(2)
            Calendarview()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
                .tag(3)
        }.accentColor(.blue)
            .edgesIgnoringSafeArea(.top)
    }
}


struct postCell: View {
    
    var name = ""
    var id = ""
    var pic = ""
    var image = ""
    var msg = ""
    
    var body: some View {
        
        HStack
        {
//            Animation(url: URL(string: image)!).resizable().frame(width: 50, height: 50).clipShape(Circle())
        
        VStack {
            Text(name).fontWeight(.heavy)
            Text(id)
            Text(msg)
            
//            Animation(url: URL(string: image)!).resizable().frame(height: 300).clipShape(Circle())
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
//    static let blackbook = Blackbooklogo()
    static var previews: some View {
        ContentView()
    }
}

struct datatype : Identifiable {
    
    var id: String
    var name: String
    var msg: String
    var repost: String
    var likes: String
    var pic: String
    var url: String
    var tagId: String
    
}

class getData: ObservableObject {
    
    @Published var datas = [datatype]()
    
    init() {
        
        let db = Firestore.firestore()
        db.collection("posts").addSnapshotListener {(snap, err) in
            
            if err != nil {
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
                    let msg = i.document.get("msg") as! String
                    let repost = i.document.get("repost") as! String
                    let likes = i.document.get("likes") as! String
                    let pic = i.document.get("pic") as! String
                    let url = i.document.get("url") as! String
                    let tagID = i.document.get("id") as! String
                    
                    DispatchQueue.main.async {
                        self.datas.append(datatype(id: id, name: name, msg: msg, repost: repost, likes: likes, pic: pic, url: url, tagId: tagID))
                    }
                }
            }
    }
    
}
}

struct Blackbooklogo: View {
     @State private var searchTerm: String = ""
    var body: some View {
        ZStack{

            Image("Black (1)")
                .resizable()
                .frame(width: 400.0, height: 400.0)
                .position(x: 205, y: 25)
                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                .scaleEffect(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .background(Color("Offwhite"))
                .edgesIgnoringSafeArea(.all)
         
            SearchBar(text: $searchTerm)
                .position(x: 205, y: 150)
                .foregroundColor(Color("Offwhite"))
                
                
        }
    }
}
    

struct Home: View {
    
    @ObservedObject var observedData = getData()
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                List(0..<15){ i in
                    Text("Post \(i)")
//                    postCell(name: i.name, id: i.tagId, pic: i.pic, image: i.image, msg: i.msg)
                }
                
            VStack {
                
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Image("Blackbook(book)").resizable().frame(width: 50, height: 50).scaledToFit().padding()
                    }.background(Color("BlackbookBlue")).foregroundColor(.white)
                    .clipShape(Circle())
                    
                }.padding()
            }
        }.navigationBarTitle("Blackbook", displayMode: .inline)
                .navigationBarItems(leading: Image("White").resizable().frame(width: 35, height: 35).clipShape(Circle()).onTapGesture {
                    print("Slide out menu....")
                })
    }
    }
}


