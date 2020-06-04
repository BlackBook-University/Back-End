//
//  HomePage.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 6/3/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        CustomController()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

struct CustomController : UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomController>) -> UIViewController {
        
    let storyboard = UIStoryboard(name: "Home:Explore_page", bundle: Bundle.main)
    let controller = storyboard.instantiateViewController(identifier: "Home")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CustomController>) {
    }
    
}
