import SwiftUI

struct ContentView: View {
    
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
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        
                        NavigationLink(destination: SettingsView(numParticipants: numParticipants, participants: participants, numRounds: numRounds, turnDuration: turnDuration, onStart: onStart)) {
                            Text("Start")
                                .font(.title3)
                                .padding()
                                .bold()
                                .frame(maxWidth: 150)
                                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        }
                        
                        
                    }
                    .padding(.bottom, 50)
                    
                }
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
        onStart: {}
    )
}
