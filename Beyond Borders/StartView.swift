//
//  ContentView.swift
//  bb
//
//  Created by Christian Ciriello on 26/02/25.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.945, blue: 0.816)
                .ignoresSafeArea()
            
            
            //VStack Title
            VStack {
                Text("assets and instructions")
                    .bold()
                    .font(.largeTitle)
                
                
                 Spacer()
                
                
                //VStack body
                VStack (spacing: 70) {
                    
                    Image("app.icon.nobackground")
                        .resizable()
                        .frame(width: 300, height: 300)
                    
                    
                    Text("spin the globe \nland on a country \nprova prova ")
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.center)
                
                    // Button-ZStack
                    ZStack {
                        RoundedRectangle (cornerRadius: 20)
                            .frame(width: 200, height: 70)
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        Button("Start") {
                            
                        }
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    }
                
                    
                }
                .padding(.bottom, 50)
                
            }
            .padding()
        }
    }
}

#Preview {
    StartView()
}

