//
//  ContentView.swift
//  bb
//
//  Created by Christian Ciriello on 26/02/25.
//
import SwiftUI

struct StartView: View {
    
    @State var numParticipants: Int
    @State var participants: [String]
    @State var numRounds: Int
    @State var turnDuration: Int
    var onStart: () -> Void
    
    var body: some View {
        NavigationStack{
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
                        
                        NavigationLink(destination: ContentView(numParticipants: numParticipants, participants: participants, numRounds: numRounds, turnDuration: turnDuration, onStart: onStart)) {
                            Text("Start")
                                .font(.title2)
                                .bold()
                                .frame(width: 350, height: 60)
                                .background(Color(red: 0.286, green: 0.678, blue: 0.635))
                                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                .cornerRadius(50)
                        }
                        
                        
                    }
                    .padding(.bottom, 50)
                    
                }
                .padding()
            }
        }
        
    }
}

//#Preview {
//    StartView(numParticipants: numParticipants, participants: participants, numRounds: numRounds, turnDuration: turnDuration, onStart: onStart)
//}

