//
//  RulesView.swift
//  Beyond Borders
//
//  Created by Michele Mariniello on 12/03/25.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        ZStack{
            
            Color(.background)
                .ignoresSafeArea()
            
            Image("rules")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    RulesView()
}
