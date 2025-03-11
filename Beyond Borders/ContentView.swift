import SwiftUI

struct ContentView: View {
    
    @State var numParticipants: Int
    @State var participants: [String]
    @State var numRounds: Int
    @State var turnDuration: Int
    var onStart: () -> Void
    var onHome: () -> Void
    
    @State private var isSettingsPresented = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(red: 1.0, green: 0.945, blue: 0.816)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Beyond Borders")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                    
                    Spacer()

                        Image("app.icon.nobackground")
                            .resizable()
                            .frame(width: 300, height: 300)
                        
                        Spacer()
                        
                        Button(action: {
                            isSettingsPresented = true
                            
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
                    
                    NavigationLink(destination: InfoView()) {
                        Text("Info")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 100, height: 65)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 50)
                }// End VStack
                .padding()
            }
        }
        .tint(Color(red: 0.176, green: 0.188, blue: 0.278))
    }
}

#Preview {
    ContentView(
        numParticipants: 4,
        participants: ["Player 1", "Player 2", "Player 3", "Player 4"],
        numRounds: 1,
        turnDuration: 60,
        onStart: {},
        onHome: {}
    )
}

