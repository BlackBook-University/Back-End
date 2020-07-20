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
import SDWebImageSwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    @State var show = false

    
    var body: some View {
        
        ZStack {
            TabView(selection: $selection){
                           Home()
                            .tabItem {
                                VStack {
                                    Image(systemName: "house")
                                    Text("Home")
                                }
                            }
                            .tag(0)
                        Search()
                            .tabItem {
                                VStack {
                                    Image(systemName: "magnifyingglass")
                                    Text("Search")
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
            
            VStack {
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    Image("Blackbook(book)").resizable().frame(width: 50, height: 50).scaledToFit().padding()
                }.background(Color("BlackbookBlue")).foregroundColor(.white)
                .clipShape(Circle())
                
            }.padding()
                
            }.padding(.bottom, 65)
        
            }.sheet(isPresented: $show) {
                
                CreatePost(show: self.$show)
            }
        }
}
        


struct postCellBottom : View{
    
    var body: some View {
        
        HStack(spacing: 40) {
            
            Button(action: {
                
            }) {
                
                Image(systemName: "bubble.middle.bottom").resizable().frame(width: 20, height: 20)
                
                
            }.foregroundColor(.gray)
            
            
            Button(action: {
                           
                       }) {
                           
                           Image(systemName: "arrow.2.squarepath").resizable().frame(width: 20, height: 20)
                           
                           
            }.foregroundColor(.gray)
            
            
            Button(action: {
                           
                       }) {
                           
                           Image(systemName: "suit.heart.fill").resizable().frame(width: 20, height: 20)
                           
                           
            }.foregroundColor(.gray)
            
            
            Button(action: {
                           
                       }) {
                           
                           Image(systemName: "square.and.arrow.up").resizable().frame(width: 20, height: 20)
                           
                           
            }.foregroundColor(.gray)
        }
    }
}



struct postCellTop: View {
    
    
    var name = ""
    var id = ""
    var pic = ""
    var image = ""
    var msg = ""
    
    var body: some View {
        
        HStack(alignment: .top)
        {
            
            VStack {
                
                AnimatedImage(url: URL(string: image)!).resizable().frame(width: 50, height: 50).clipShape(Circle())
                
                Spacer()
            }
            
            
            
        VStack(alignment: .leading) {
            
            Text(name).fontWeight(.heavy)
            Text(id)
            Text(msg).padding(.top, 8)
            
            
        }
            
        }.padding()
        
    }
}


struct postCellMiddle: View {
    
    var pic = ""
    
    var body : some View {
        
        AnimatedImage(url: URL(string: pic)!).resizable().frame(height: 300).cornerRadius(20).padding()
    }
}


struct CreatePost : View {
    
    @Binding var show : Bool
    @State var txt = ""
    
    var body : some View {
        
        VStack {
            
            HStack {
                
                Button(action: {
                    
                    self.show.toggle()
                }) {
                    
                    Text("Cancel")
                    
                }
                
                Spacer()
                
                Button(action: {
                    
                    postPost(msg: self.txt)
                    self.show.toggle()
                    
                }) {
                    
                    Text("Post").padding()
                    
                }.background(Color("BlackbookBlue"))
                    .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            multilineTextField(txt: $txt)
        }.padding()
    }
}


struct multilineTextField: UIViewRepresentable {
    
    @Binding var txt: String
    
    func makeCoordinator() -> multilineTextField.Coordinator {
        
        return multilineTextField.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<multilineTextField>) -> UITextView {
        
        let text = UITextView()
        text.isEditable = true
        text.isUserInteractionEnabled = true
        text.text = "Type away"
        text.textColor = .gray
        text.font = .systemFont(ofSize: 20)
        text.delegate = context.coordinator
        
        return text
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<multilineTextField>) {
        
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent: multilineTextField
        
        init(parent1 : multilineTextField) {
            
            parent = parent1
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            
            self.parent.txt = textView.text
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

func postPost(msg: String) {
    
    let db = Firestore.firestore()
    
    db.collection("posts").document().setData(["name": "Brathwaite", "id" : "@brath", "msg": msg, "repost": "0", "likes": "0", "pic":"", "url": ""]) { (err) in
        
        if err != nil {
            
            print((err?.localizedDescription)!)
            
            return
        }
        
        print("success")
        }
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
         
//            SearchBar(text: $searchTerm)
//                .position(x: 205, y: 150)
//                .foregroundColor(Color("Offwhite"))
                
                
        }
    }
}
    

struct Home: View {
    
    @ObservedObject var observedData = getData()
        
    var body: some View {
        
        NavigationView {
            
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading){
                        
                        ForEach(observedData.datas){ i in
                            
                            postCellTop(name: i.name, id: i.tagId, pic: i.pic, image: i.url, msg: i.msg)
                            
                            if i.pic != "" {
                              
                                postCellMiddle(pic: i.pic).padding(.leading, 60)
                            }
                            
                            postCellBottom().offset(x: UIScreen.main.bounds.width / 4)
                        }
                        
                    }.padding(.bottom, 15)
                    
                }
                
        .navigationBarTitle("Blackbook", displayMode: .inline)
                .navigationBarItems(leading:
                    
                    Image("White").resizable().frame(width: 35, height: 35).clipShape(Circle()).onTapGesture {
                    print("Slide out menu....")
                }
            
            )
        }
    }
}

struct Search: View {
    
    @ObservedObject var datas = getTopTags()
    
    var body: some View {
        
        NavigationView {
            
            List(datas.top) { i in
                
                SearchCell(tag: i.tag, posts: i.posts)
                
            }.navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
            
                HStack {
                    
                    Image("White").resizable().frame(width: 35, height: 35).clipShape(Circle()).onTapGesture {
                        print("Slide out menu....")
                    }
                    
                    SearchBar().frame(width: UIScreen.main.bounds.width - 120)
                }
            
            
            , trailing:
            
                Button(action: {
                    
                }, label: {
                    
                    Image(systemName:"person.badge.plus.fill").resizable().frame(width:25, height: 25)
                    
                    
                    }).foregroundColor(Color("BlackbookBlue"))
            
            
            )
        }
    }
}

struct SearchCell: View {
    
    var tag = ""
    var posts = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            Text(tag).fontWeight(.heavy)
            Text(posts + " Posts").fontWeight(.light)
        }
    }
}

//struct SearchBar: UIViewRepresentable {
//    
//    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
//        
//        let search = UISearchBar()
//        return search
//    }
//    
//    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
//        <#code#>
//    }
//}

class getTopTags: ObservableObject {
    
    @Published var top = [Topdatatype]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("Top").order(by: "posts", descending: true).getDocuments{
            (snap, err) in
            
            if err != nil {
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents {
                
                let id = i.documentID
                let tag = i.get("tag") as! String
                let posts = i.get("posts") as! NSNumber
                
                self.top.append(Topdatatype(id: id, tag: tag, posts: "\(posts)"))
            }
            }
    }
    
}

struct Topdatatype : Identifiable {
    
    var id: String
    var tag: String
    var posts: String
}



