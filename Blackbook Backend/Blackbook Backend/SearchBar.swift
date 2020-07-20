//
//  SearchBar.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 5/30/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import SwiftUI
import Foundation

struct SearchBar: UIViewRepresentable {
    
    
    
//    @Binding var text: String
//
//    class Coordinator: NSObject, UISearchBarDelegate {
//
//        @Binding var text: String
//
//        init(text: Binding<String>) {
//            _text = text
//        }
//
//        func searchBar(_ serachbar: UISearchBar, textDidChange searchText: String) {
//            text = searchText
//        }
//
//    }
    
//    func makeCoordinator() -> SearchBar.Coordinator {
//        return Coordinator(text: $text)
//    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar()
//        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
//        uiView.text = text
    }
}

