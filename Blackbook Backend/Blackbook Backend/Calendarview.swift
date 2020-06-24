//
//  Calendarview.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 5/21/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import SwiftUI

struct Calendarview: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("Black (1)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
                    .position(x: 205, y: 30)
            }
        }
    }
}

struct Calendarview_Previews: PreviewProvider {
    static var previews: some View {
        Calendarview()
    }
}
