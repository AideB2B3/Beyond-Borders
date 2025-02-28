//
//  CountryView.swift
//  Beyond Borders
//
//  Created by Davide Bellobuono on 28/02/25.
//

import SwiftUI
import Lottie

struct CountryView: View {
    
    @State private var showFlag = false
    @State private var isPlaying = false
    @State private var selectedCountry: (flag: String, name: String) = ("🇮🇹", "Italia")
    
    let countries: [(flag: String, name: String)] = [
        ("🇮🇹", "Italia"),
        ("🇫🇷", "Francia"),
        ("🇩🇪", "Germania"),
        ("🇪🇸", "Spagna"),
        ("🇬🇧", "Regno Unito")
    ]
    
    var body: some View {
        ZStack{
            Color(red: 1.0, green: 0.945, blue: 0.816)
                .ignoresSafeArea()
            
            VStack{
                Text("Tap on the world \nfor country ")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                    .padding(.top, -100)
                
                if showFlag {
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 200, height: 200)
                            .shadow(radius: 5)
                            .overlay(
                                VStack {
                                    Text(selectedCountry.flag)
                                        .font(.largeTitle)
                                        .bold()
                                    
                                    Text(selectedCountry.name)
                                        .font(.title)
                                        .bold()
                                }
                            )
                }
                    .transition(.opacity)
                } else {
                    LottieView(animation: .named("Worldsimple"))
                        .playbackMode(isPlaying ? .playing(.toProgress(1, loopMode: .loop)) : .paused)
                        .animationSpeed(5)
                        .frame(width: 350, height: 350)
                        .onTapGesture {
                            isPlaying = true
                            selectedCountry = countries.randomElement() ?? ("🇮🇹", "Italia")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showFlag = true
                                }
                            }
                        }
                }
                
            }// end VStack
        }//end ZStack
    }
}

#Preview {
    CountryView()
}
