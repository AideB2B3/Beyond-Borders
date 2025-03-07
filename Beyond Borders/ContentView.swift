import SwiftUI

struct ContentView: View {
    
    @State var numParticipants: Int
    @State var participants: [String]
    @State var numRounds: Int
    @State var turnDuration: Int
    var onStart: () -> Void
//    var totalRounds: Int
//    var timerDuration: Int
    var onHome: () -> Void
    
    @State private var isSettingsPresented = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(red: 1.0, green: 0.945, blue: 0.816)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Start Screen")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                    
                    
                    Spacer()

                    VStack (spacing: 70) {
                        
                        Image("app.icon.nobackground")
                            .resizable()
                            .frame(width: 300, height: 300)
                        
                        
                        Text("spin the globe \nland on a country \nprova prova ")
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        
                        
                        Button(action: {
                            print("Settings Button tapped")
                            isSettingsPresented = true  // Mostra la schermata delle impostazioni
                            
                        }) {
                            Text("Start")
                                .font(.title)
                                .padding()
                                .bold()
                                .frame(width: 130, height: 70)
                                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        }
                        .fullScreenCover(isPresented: $isSettingsPresented) {
                            SettingsView(numParticipants: numParticipants, participants: participants, numRounds: numRounds, turnDuration: turnDuration, onStart: onStart, onHome: onHome)
                            
                        }
//                        NavigationLink(destination: SettingsView(numParticipants: numParticipants, participants: participants, numRounds: numRounds, turnDuration: turnDuration, onStart: onStart, totalRounds: totalRounds, timerDuration: timerDuration, onHome: onHome)) {
//                            Text("Start")
//                                .font(.title3)
//                                .padding()
//                                .bold()
//                                .frame(maxWidth: 150)
//                                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
//                                .foregroundColor(.white)
//                                .cornerRadius(30)
//                        }
                        
                        
                    } // End VStack(spacing)
                    .padding(.bottom, 50)
                    
                }// End VStack
                .padding()
            }
        }
        
    }
}

#Preview {
    ContentView(
        numParticipants: 4,
        participants: ["Player 1", "Player 2", "Player 3", "Player 4"],
        numRounds: 3,
        turnDuration: 60,
        onStart: {},
        onHome: {} // Aggiunto
    )
}

