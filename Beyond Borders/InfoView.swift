//
//  RulesView.swift
//  Beyond Borders
//
//  Created by Michele Mariniello on 12/03/25.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack{
            
            Color(.beigeBack)
                .ignoresSafeArea()
            
            Image("Info")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    InfoView()
}
