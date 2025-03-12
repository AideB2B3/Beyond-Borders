//
//  CreditsView.swift
//  Beyond Borders
//
//  Created by Davide Bellobuono on 12/03/25.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    Image("rettangolo bb")
                        .resizable()
                    
                    Text("Special thanks to those who created me:\n\nChristian Ciriello\nDavide BelloBuono\nFabrizio Vollaro\nIrem Nur Arslaner\nMichele Mariniello\nSupriya Palle\n")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(.colorDarkBlue))
                        .multilineTextAlignment(.center)
                        .frame(width: 280)
                        .minimumScaleFactor(0.7)
                        .padding(.horizontal, 10)
                }
                
                HStack {
                    Image("Mascotte")
                        .resizable()
                        .frame(width: 170, height: 170)
                        .offset(x: -90, y: -30)
                }
            }
        }
    }
}

#Preview {
    CreditsView()
}
