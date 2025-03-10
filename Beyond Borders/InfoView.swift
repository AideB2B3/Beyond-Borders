//
//  InfoView.swift
//  Beyond Borders
//
//  Created by Michele Mariniello on 10/03/25.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        
        ZStack {
            Color(red: 1.0, green: 0.945, blue: 0.816)
                .ignoresSafeArea()
            
            VStack {
                Text("Credits:")
                    .font(.largeTitle)
                    .bold()
                
                Text("\nChristian Ciriello\nDavide BelloBuono\nFabrizio Vollaro\nIrem Nur Arslaner\nMichele Mariniello\nSupriya Palle")
                    .font(.title2)
                    .bold()
            }

        }
    }
}

#Preview {
    InfoView()
}
