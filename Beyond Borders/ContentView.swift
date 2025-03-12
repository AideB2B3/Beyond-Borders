import SwiftUI
import AVKit

struct ContentView: View {
    
    @State var numParticipants: Int
    @State var participants: [String]
    @State var numRounds: Int
    @State var turnDuration: Int
    var onStart: () -> Void
    var onHome: () -> Void
    
    @State private var isSettingsPresented = false
    @State private var showOnboarding = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(red: 1.0, green: 0.945, blue: 0.816)
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        Image("rettangolo bb")
                            .resizable()
                        
                        Text("Welcome in Beyond Borders")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
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
                    
                    Spacer()

                    
                    Button(action: {
                        if !hasSeenOnboarding {
                            showOnboarding = true
                        } else {
                            isSettingsPresented = true
                        }
                    }) {
                        Text("Start")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding()
                    .fullScreenCover(isPresented: $showOnboarding, onDismiss: {
                        hasSeenOnboarding = true
                    }) {
                        OnBoardingView(isPresented: $showOnboarding)
                    }
                    .fullScreenCover(isPresented: $isSettingsPresented) {
                        SettingsView(numParticipants: numParticipants, participants: participants, numRounds: numRounds, turnDuration: turnDuration, onStart: onStart, onHome: onHome)
                    }
                    
                    NavigationLink(destination: InfoView()) {
                        Text("Info")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
//                    .padding(.bottom, 50)
                }
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

